
-- calculate corn and soybean yields from NCCPI 
-- NCCPI for corn and soybeans is in the SSURGO database 
-- join yields to map units


-- Bonner et al use the production per county of the area that was in corn each year, from 2007-2012
-- we can do it the same way, getting the areas in corn and soybeans and the total production per county and year from NASS database 

-- export the NASS tables and get them in a tidy shape:
-- columns: fips, year, crop, total crop production, total harvested acres

-- add a column fips and derive values from the column county ANSI
-- so that it is the same as fips
-- and adapt the naming convention of commodity



ALTER TABLE xyz
ADD COLUMN fips TEXT;

UPDATE nass_cgsb_yields_2011_2015
SET 
fips = concat('IA00', "County ANSI") WHERE "County ANSI" < 10,
fips = concat('IA0', "County ANSI") WHERE "County ANSI" > 9 AND "County ANSI"::int < 100,
fips = concat('IA', "County ANSI") WHERE "County ANSI" > 99;
"Commodity" = 'CG' WHERE "Commodity" = 'CORN',
"Commodity" = 'SB' WHERE "Commodity" = 'SOYBEANS';

------------------------------
------------------------------
-- join the total area from table "61_total_area_county_2011_2014" with the nass table data 

DROP TABLE IF EXISTS "61_ny_j_nass_cgsb_county_production_pre";
CREATE TABLE "61_ny_j_nass_cgsb_county_production_pre"
AS SELECT
t1."Year" as year,
t1."Commodity" as crop,
t1.fips,
t1."Value" as yield,
t2.sum as tot_area
FROM nass_cgsb_yields_2011_2015 as t1
INNER JOIN "61_total_area_county_2011_2014" AS t2
ON t1.fips = t2.fips AND t1."Year"::INT = t2.year;

 -- add a column to calculate county level corn and soybean production, if all areas was planted into either corn or soybeans:

ALTER TABLE "61_ny_j_nass_cgsb_county_production_pre"
ADD COLUMN prod FLOAT;

UPDATE "61_ny_j_nass_cgsb_county_production_pre"
SET prod = yield::numeric * tot_area;

-- the values in column prod are the equivalent to NY_j in Bonner et al (2014).

-- change the table layout, so that corn and soybean production is shown in two different columns 

DROP TABLE IF EXISTS "61_ny_j_nass_cgsb_county_production";
CREATE TABLE "61_ny_j_nass_cgsb_county_production"
AS 
WITH corn_table AS (
SELECT
year,
fips,
prod as prod_nass_corn
FROM "61_ny_j_nass_cgsb_county_production_pre"
WHERE crop = 'CG'),
soy_table  AS (
SELECT
year,
fips,
prod as prod_nass_soy
FROM "61_ny_j_nass_cgsb_county_production_pre"
WHERE crop = 'SB')
SELECT
t1.year,
t1.fips,
t1.prod_nass_corn,
t2.prod_nass_soy
FROM corn_table as t1
LEFT JOIN soy_table as t2
ON t1.year = t2.year AND t1.fips = t2.fips;




-- To calculate EY, we need to join the ISPAID yields (calculated in table ssurgo_ia_CSR2) to the cluid_mukey rows in the 
-- table clumu_cgsb_profit_2011_2014.

-- aggregate area over mukey from table clumu_cgsb_profit_2011_2014, selecting a year (not relevant which year);

DROP TABLE IF EXISTS "61_mukey_areas";
CREATE TABLE "61_mukey_areas"
AS SELECT
fips,
mukey,
sum(clumuacres) AS mukey_acres
FROM clumu_cgsb_profit_2011_2014
WHERE year = '2014'
GROUP BY mukey, fips;

-- join ispaid yields from table ssurgo_ia_csr2 to the fips and areas in table "61_mukey_areas"
-- note: by joining on both mukey and fips, the areas that are in a county that is not associated with a given mukey are not assigned 
-- a yield but a NULL. 

DROP TABLE IF EXISTS "61_ispaid_yields_area";
CREATE TABLE "61_ispaid_yields_area"
AS SELECT
t1.fips,
t1.mukey,
t1.mukey_acres,
t2.ispaid_j_corn,
t2.ispaid_j_soy
FROM "61_mukey_areas" as t1
LEFT JOIN ssurgo_ia_csr2 as t2
ON t1.mukey = t2.mukey and t1.fips = t2.areasymbol;

-- calulate the product of each mukey area and associated corn and soybean yield in two new columns 

ALTER TABLE "61_ispaid_yields_area"
ADD corn_x_acres FLOAT; 
ALTER TABLE "61_ispaid_yields_area"
ADD soy_x_acres FLOAT;

UPDATE "61_ispaid_yields_area"
SET 
corn_x_acres = mukey_acres * ispaid_j_corn,
soy_x_acres = mukey_acres * ispaid_j_soy;


-- aggregate over each county to calculate the production according to the ispaid yields:

DROP TABLE IF EXISTS "61_ey_ispaid_cgsb_county_production";
CREATE TABLE "61_ey_ispaid_cgsb_county_production"
AS SELECT
fips,
sum(corn_x_acres) as prod_ispaid_corn,
sum(soy_x_acres) as prod_ispaid_soy
FROM "61_ispaid_yields_area"
GROUP BY fips;



-- join the two tables "61_ey_ispaid_cgsb_county_production" and "61_ny_j_nass_cgsb_county_production"
-- to calculate the correction factor CF_j for each year and crop

DROP TABLE IF EXISTS "61_cf_j_county";
CREATE TABLE "61_cf_j_county"
AS SELECT
t1.*,
t2.prod_ispaid_corn,
t2.prod_ispaid_soy
FROM "61_ny_j_nass_cgsb_county_production" as t1
LEFT JOIN "61_ey_ispaid_cgsb_county_production" as t2 ON t1.fips = t2.fips;


ALTER TABLE "61_cf_j_county"
ADD cf_j_corn FLOAT;
ALTER TABLE "61_cf_j_county"
ADD cf_j_soy FLOAT;

UPDATE "61_cf_j_county"
SET 
cf_j_corn = round((prod_nass_corn::NUMERIC - prod_ispaid_corn::NUMERIC) / prod_nass_corn::NUMERIC,2),
cf_j_soy = round((prod_nass_soy::NUMERIC - prod_ispaid_soy::NUMERIC) / prod_nass_soy::NUMERIC,2);


-- join all the components needed to calculate yields and respective profitability

DROP TABLE
IF EXISTS clumu_cgsb_profit_2011_2014_single_crop;
CREATE TABLE clumu_cgsb_profit_2011_2014_single_crop AS WITH 
 yield_table AS (
	SELECT
		t1.fips,
		t1.cluid,
		t1.mukey,
		t1.cluid_mukey,
		t1.year,
		t1.clumuacres,
		t1.clu_cash_rent,
		t2.ispaid_j_corn AS ispaid_yield_corn,
		t2.ispaid_j_soy AS ispaid_yield_soy
	FROM
		clumu_cgsb_profit_2011_2014 AS t1
	LEFT JOIN ssurgo_ia_csr2 AS t2 ON t1.mukey = t2.mukey
),
 budget_table_corn AS (
	SELECT
		*
	FROM
		crop_budgets_2010_2015
	WHERE
		"type" = 'CG following SB' AND year IN ('2011', '2012', '2013', '2014')
),
 budget_table_soy AS (
	SELECT
		*
	FROM
		crop_budgets_2010_2015
	WHERE
		"type" = 'SB following CG' AND year IN ('2011', '2012', '2013', '2014')
),
budget_table AS (
SELECT
t1.year,
t1."preharvest ($/acre)" AS preharvest_cg,
t1."seed and chem ($/acre)" AS seed_chem_cg,
t1."harvest machinery ($/bu)" AS harv_mach_cg,
t1."labor ($/acre)" AS labor_cg,
t1."N ($/acre)" AS n_cg,
t1."P ($/acre)" AS p_cg,
t1."K ($/acre)" AS k_cg,
t1."grain price ($/bu)" AS price_cg,
t2."preharvest ($/acre)" AS preharvest_sb,
t2."seed and chem ($/acre)" AS seed_chem_sb,
t2."harvest machinery ($/bu)" AS harv_mach_sb,
t2."labor ($/acre)" AS labor_sb,
t2."N ($/acre)" AS n_sb,
t2."P ($/acre)" AS p_sb,
t2."K ($/acre)" AS k_sb,
t2."grain price ($/bu)" AS price_sb
FROM budget_table_corn AS t1
LEFT JOIN budget_table_soy AS t2
ON t1.year = t2.year
),
yield_budget_table AS (
SELECT
t1.*,
t2.preharvest_cg,
t2.seed_chem_cg,
t2.harv_mach_cg,
t2.labor_cg,
t2.n_cg,
t2.p_cg,
t2.k_cg,
t2.price_cg,
t2.preharvest_sb,
t2.seed_chem_sb,
t2.harv_mach_sb,
t2.labor_sb,
t2.n_sb,
t2.p_sb,
t2.k_sb,
t2.price_sb
FROM yield_table as t1
LEFT JOIN budget_table as t2 
ON t1.year = t2.year::INT)
SELECT
t1.*,
t2.cf_j_corn as yield_corr_f_corn,
t2.cf_j_soy as yield_corr_f_soy
FROM yield_budget_table as t1
LEFT JOIN "61_cf_j_county" as t2 ON t1.fips = t2.fips AND t1.year = t2.year::INT;


-- add yield columns 
-- add a CG and SB price column 
-- add profit columns 

ALTER TABLE clumu_cgsb_profit_2011_2014_single_crop
ADD 
yield_cg NUMERIC;
ALTER TABLE clumu_cgsb_profit_2011_2014_single_crop
ADD 
yield_sb NUMERIC;
ALTER TABLE clumu_cgsb_profit_2011_2014_single_crop
ADD 
profit_cg FLOAT;
ALTER TABLE clumu_cgsb_profit_2011_2014_single_crop
ADD 
profit_sb FLOAT;

-- calculate all values 

UPDATE clumu_cgsb_profit_2011_2014_single_crop
SET 
yield_cg = round(ispaid_yield_corn::NUMERIC + (ispaid_yield_corn::NUMERIC * yield_corr_f_corn::NUMERIC),2),
yield_sb = round(ispaid_yield_soy::NUMERIC + (ispaid_yield_soy::NUMERIC * yield_corr_f_soy::NUMERIC),2);

UPDATE clumu_cgsb_profit_2011_2014_single_crop
SET 
profit_cg =
round(( yield_cg * price_cg::NUMERIC ) - ( clu_cash_rent + preharvest_cg::NUMERIC + seed_chem_cg::NUMERIC
+ labor_cg::NUMERIC + n_cg::NUMERIC + p_cg::NUMERIC + k_cg::NUMERIC + ( harv_mach_cg::NUMERIC * yield_cg )),0),
profit_sb =
round(( yield_sb * price_sb::NUMERIC ) - ( clu_cash_rent + preharvest_sb::NUMERIC + seed_chem_sb::NUMERIC
+ labor_sb::NUMERIC + n_sb::NUMERIC + p_sb::NUMERIC + k_sb::NUMERIC + ( harv_mach_sb::NUMERIC * yield_sb )),0);

/*
VACUUM clumu_cgsb_profit_2011_2014_single_crop;
*/
