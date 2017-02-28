-- the aim of this script is to calculate land values based on county averages scaled to CSR2

-- join CSR2 values from SSURGO to clumu details from the profit table, only 
-- taking values from one year to avoid duplicates

DROP TABLE IF EXISTS "10_clumu_csr2";
CREATE TABLE "10_clumu_csr2" AS 
SELECT
t1.fips,
t1.year,
t1.cluid,
t1.mukey,
t1.cluid_mukey,
t1.acres,
t2.iacornsr
FROM clumu_cgsb_profit_2012_2015 AS t1 
INNER JOIN ssurgo_ia_csr2 AS t2 ON t1.mukey = t2.mukey;

SELECT sum(acres) FROM "10_clumu_csr2" WHERE iacornsr IS NULL;
-- result: 57560 acres

-- calculate per county area-weighted mean CSR2 --> 10_county_mean_csr2

DROP TABLE IF EXISTS "10_county_mean_csr2";
CREATE TABLE "10_county_mean_csr2"
AS SELECT
fips,
year,
round(sum(iacornsr::NUMERIC * acres)/sum(acres),0) AS cnty_mean_csr2
FROM "10_clumu_csr2"
GROUP BY fips, year;

-- import table cnty_farmland_values_2012_2015 (in us$/acre)
-- join county mean CSR2 and table with mean county land values 2012-2015 

DROP TABLE IF EXISTS "10_cnty_land_csr2_index";
CREATE TABLE "10_cnty_land_csr2_index"
AS SELECT 
t1.*,
t2.cnty_mean_csr2
FROM cnty_farmland_values_2012_2015 AS t1
INNER JOIN "10_county_mean_csr2" AS t2 ON t1.fips = t2.fips and t1.year = t2.year;

-- add columns and calculate the coefficient D (land value increase / crs2 point increase)

ALTER TABLE "10_cnty_land_csr2_index"
ADD coeff NUMERIC;

UPDATE "10_cnty_land_csr2_index"
SET coeff = round(land_value/cnty_mean_csr2,2);

-- join the coefficients to the clumu scale table 

DROP TABLE IF EXISTS "10_clumu_land_values_2012_2015";
CREATE TABLE "10_clumu_land_values_2012_2015"
AS SELECT 
t1.*,
t2.coeff
FROM "10_clumu_csr2" AS t1
INNER JOIN "10_cnty_land_csr2_index" AS t2 ON t1.fips = t2.fips AND t1.year = t2.year;

-- add columns and calculate the clumu scale land values 

ALTER TABLE "10_clumu_land_values_2012_2015"
ADD clumu_land_value NUMERIC;

UPDATE "10_clumu_land_values_2012_2015"
SET clumu_land_value = round(coeff * iacornsr::NUMERIC,2);

-- calculate clu area weighted means of land values 

DROP TABLE IF EXISTS "10_clu_land_values_2012_2015";
CREATE TABLE "10_clu_land_values_2012_2015"
AS SELECT 
cluid,
year,
round(sum(clumu_land_value * acres)/sum(acres),0) AS clu_land_value
FROM "10_clumu_land_values_2012_2015"
GROUP by cluid, year;

-- calculate annual land costs as 1.5% of land value and in metric units

ALTER TABLE "10_clu_land_values_2012_2015"
ADD clu_land_cost NUMERIC;

UPDATE "10_clu_land_values_2012_2015"
SET clu_land_cost = clu_land_value * 0.015;

-- join the land values to the other components to calculate profitability

DROP TABLE IF EXISTS "10_clumu_cgsb_profit_land_values_2012_2015";
CREATE TABLE "10_clumu_cgsb_profit_land_values_2012_2015"
AS SELECT
t1.fips,
t1.cluid,
t1.mukey,
t1.cluid_mukey,
t1.year,
t1.musym,
t1.acres,
t1.ccrop,
t1.pcrop,
t1.yield,
t1.clu_cash_rent_csr2,
t1.preharv_machinery,
t1.seed_chem,
t1.harv_machinery,
t1.labor,
t1.n_cost,
t1.p_cost,
t1.k_cost,
t1.grain_price,
t1.profit_csr2,
t2.clu_land_cost
FROM clumu_cgsb_profit_2012_2015 AS t1
INNER JOIN "10_clu_land_values_2012_2015" AS t2 ON t1.cluid = t2.cluid AND t1.year = t2.year;

-- add profit with land cost:

ALTER TABLE "10_clumu_cgsb_profit_land_values_2012_2015"
ADD profit_land_cost NUMERIC;

update "10_clumu_cgsb_profit_land_values_2012_2015"
set
profit_land_cost =
( yield * grain_price ) - ( clu_land_cost + preharv_machinery + seed_chem
+ labor + n_cost + p_cost + k_cost + ( harv_machinery * yield ) );
 
-- add a column to the table to calculate profit per ha and round to the full dollar

ALTER TABLE "10_clumu_cgsb_profit_land_values_2012_2015"
ADD profit_land_cost_ha_round NUMERIC;

update "10_clumu_cgsb_profit_land_values_2012_2015"
set profit_land_cost_ha_round = round(profit_land_cost * 2.471,0)


-- aggregate profits per year and full dollar amount
--2012
DROP TABLE IF EXISTS "profit_landcost_rounded_aggregated_2012";
CREATE TABLE "profit_landcost_rounded_aggregated_2012"
AS SELECT 
profit_land_cost_ha_round AS profit_ha_rounded,
sum(acres)/2.471 as area_ha
FROM "10_clumu_cgsb_profit_land_values_2012_2015"
WHERE year = 2012
GROUP BY profit_land_cost_ha_round;

--2013
DROP TABLE IF EXISTS "profit_landcost_rounded_aggregated_2013";
CREATE TABLE "profit_landcost_rounded_aggregated_2013"
AS SELECT 
profit_land_cost_ha_round AS profit_ha_rounded,
sum(acres)/2.471 as area_ha
FROM "10_clumu_cgsb_profit_land_values_2012_2015"
WHERE year = 2013
GROUP BY profit_land_cost_ha_round;

--2014
DROP TABLE IF EXISTS "profit_landcost_rounded_aggregated_2014";
CREATE TABLE "profit_landcost_rounded_aggregated_2014"
AS SELECT 
profit_land_cost_ha_round AS profit_ha_rounded,
sum(acres)/2.471 as area_ha
FROM "10_clumu_cgsb_profit_land_values_2012_2015"
WHERE year = 2014
GROUP BY profit_land_cost_ha_round;

--2015
DROP TABLE IF EXISTS "profit_landcost_rounded_aggregated_2015";
CREATE TABLE "profit_landcost_rounded_aggregated_2015"
AS SELECT 
profit_land_cost_ha_round AS profit_ha_rounded,
sum(acres)/2.471 as area_ha
FROM "10_clumu_cgsb_profit_land_values_2012_2015"
WHERE year = 2015
GROUP BY profit_land_cost_ha_round;

-- calculate 2012-2015 profit averages and convert to metric units

DROP TABLE IF EXISTS "10_clumu_cgsb_profit_land_values_mean_2012_2015";
CREATE TABLE "10_clumu_cgsb_profit_land_values_mean_2012_2015"
AS SELECT
cluid_mukey,
acres,
round(avg(profit_land_cost)*2.471,2) AS profit_land_cost_ha,
round(avg(profit_land_cost)*2.471,0) AS profit_land_costround_ha
FROM "10_clumu_cgsb_profit_land_values_2012_2015"
GROUP BY cluid_mukey, acres;

-- agregate to the same profit value for distribution

DROP TABLE IF EXISTS "10_profit_land_values_aggr_2012_2015";
CREATE TABLE "10_profit_land_values_aggr_2012_2015"
AS SELECT
profit_land_costround_ha AS profit_land_cost,
sum(acres)/2.471 AS area_ha
FROM "10_clumu_cgsb_profit_land_values_mean_2012_2015"
GROUP BY profit_land_costround_ha;

