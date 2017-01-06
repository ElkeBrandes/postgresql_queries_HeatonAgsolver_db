-- add profit and roi (columns are already provided):
/*
update clumu_cgsb_profit_2011_2014
set
profit =
( yield * grain_price ) - ( clu_cash_rent + preharv_machinery + seed_chem
+ labor + n_cost + p_cost + k_cost + ( harv_machinery * yield ) );
 
update clumu_cgsb_profit_2011_2014
set
roi = profit/( clu_cash_rent + preharv_machinery + seed_chem
+ labor + n_cost + p_cost + k_cost + ( harv_machinery * yield ) );


*/

-- add cluid_mukey as a unique identifyer to the original table
/*
ALTER TABLE clumu_cgsb_profit_2011_2014
ADD COLUMN cluid_mukey TEXT;
*/

UPDATE clumu_cgsb_profit_2011_2014
SET cluid_mukey = cluid || mukey;


-- calculate mean profits for each polygon in a new table
-- calculate standard deviation as a measure of variability 
-- convert to metric system
/*
DROP TABLE IF EXISTS "01_clumu_cgsb_profit_2011_2014_mean";
CREATE TABLE "01_clumu_cgsb_profit_2011_2014_mean"
AS SELECT
fips,
cluid,
cluid_mukey,
clumuacres / 2.471 as clumuha,
AVG(profit) * 2.471 AS mean_profit_ha,
STDDEV_POP(profit * 2.471) AS std_profit
FROM clumu_cgsb_profit_2011_2014
GROUP BY cluid_mukey, cluid, clumuacres, fips;
*/

-- for distribution, round profits and std deviation to the dollar and aggregate
/*
ALTER TABLE "01_clumu_cgsb_profit_2011_2014_mean"
ADD COLUMN profit_mean_ha_rounded FLOAT;

UPDATE "01_clumu_cgsb_profit_2011_2014_mean"
SET profit_mean_ha_rounded = ROUND(mean_profit_ha,0);

ALTER TABLE "01_clumu_cgsb_profit_2011_2014_mean"
ADD COLUMN profit_std_ha_rounded FLOAT;

UPDATE "01_clumu_cgsb_profit_2011_2014_mean"
SET profit_std_ha_rounded = ROUND(std_profit,0);
*/
-- aggregate to the rounded mean profit values by summing up the areas
/*
DROP TABLE IF EXISTS "01_profit_mean_2011_2014_aggregated";
CREATE TABLE "01_profit_mean_2011_2014_aggregated"
AS SELECT 
profit_mean_ha_rounded,
sum(clumuha) as sum_ha
FROM "01_clumu_cgsb_profit_2011_2014_mean"
GROUP BY profit_mean_ha_rounded;

-- aggregate to the profit std deviation values by summing up the areas

DROP TABLE IF EXISTS "01_profit_std_2011_2014_aggregated";
CREATE TABLE "01_profit_std_2011_2014_aggregated"
AS SELECT 
profit_std_ha_rounded,
sum(clumuha) as sum_ha
FROM "01_clumu_cgsb_profit_2011_2014_mean"
GROUP BY profit_std_ha_rounded;
*/

-- calculate total area:
--SELECT SUM(sum) FROM "01_profit_mean_2011_2014_aggregated" WHERE profit_mean_ha_rounded < 0;


-- create distributions for each year 
-- 2011:
-- convert into metric system
/*
DROP TABLE IF EXISTS "01_profit_rounded_2011";
CREATE TABLE "01_profit_rounded_2011"
AS SELECT
ccrop,
clumuacres/2.471 as clumuha,
ROUND(profit*2.471,0) as profit_2011_ha_rounded
FROM clumu_cgsb_profit_2011_2014
WHERE year = 2011;

-- aggregate to profitability
DROP TABLE IF EXISTS "01_profit_rounded_aggregated_2011";
CREATE TABLE "01_profit_rounded_aggregated_2011"
AS SELECT
profit_2011_ha_rounded,
SUM(clumuha) AS area
FROM "01_profit_rounded_2011"
GROUP BY profit_2011_ha_rounded;

-- 2012:
-- convert into metric system

DROP TABLE IF EXISTS "01_profit_rounded_2012";
CREATE TABLE "01_profit_rounded_2012"
AS SELECT
ccrop,
clumuacres/2.471 as clumuha,
ROUND(profit*2.471,0) as profit_2012_ha_rounded
FROM clumu_cgsb_profit_2011_2014
WHERE year = 2012;

-- aggregate to profitability
DROP TABLE IF EXISTS "01_profit_rounded_aggregated_2012";
CREATE TABLE "01_profit_rounded_aggregated_2012"
AS SELECT
profit_2012_ha_rounded,
SUM(clumuha) AS area
FROM "01_profit_rounded_2012"
GROUP BY profit_2012_ha_rounded;

-- 2013:
-- convert into metric system

DROP TABLE IF EXISTS "01_profit_rounded_2013";
CREATE TABLE "01_profit_rounded_2013"
AS SELECT
ccrop,
clumuacres/2.471 as clumuha,
ROUND(profit*2.471,0) as profit_2013_ha_rounded
FROM clumu_cgsb_profit_2011_2014
WHERE year = 2013;

-- aggregate to profitability
DROP TABLE IF EXISTS "01_profit_rounded_aggregated_2013";
CREATE TABLE "01_profit_rounded_aggregated_2013"
AS SELECT
profit_2013_ha_rounded,
SUM(clumuha) AS area
FROM "01_profit_rounded_2013"
GROUP BY profit_2013_ha_rounded;

-- 2014:
-- convert into metric system

DROP TABLE IF EXISTS "01_profit_rounded_2014";
CREATE TABLE "01_profit_rounded_2014"
AS SELECT
ccrop,
clumuacres/2.471 as clumuha,
ROUND(profit*2.471,0) as profit_2014_ha_rounded
FROM clumu_cgsb_profit_2011_2014
WHERE year = 2014;

-- aggregate to profitability
DROP TABLE IF EXISTS "01_profit_rounded_aggregated_2014";
CREATE TABLE "01_profit_rounded_aggregated_2014"
AS SELECT
profit_2014_ha_rounded,
SUM(clumuha) AS area
FROM "01_profit_rounded_2014"
GROUP BY profit_2014_ha_rounded;


-- 
DROP TABLE IF EXISTS "01_total_area_county";
CREATE TABLE "01_total_area_county"
AS SELECT
fips,
sum(clumuha) AS total_area
FROM "01_clumu_cgsb_profit_2011_2014_mean"
GROUP BY fips;

-- aggregate area below break even per county

DROP TABLE IF EXISTS "01_profit_below_breakeven_county";
CREATE TABLE "01_profit_below_breakeven_county"
AS SELECT
fips,
sum(clumuha) AS area
FROM "01_clumu_cgsb_profit_2011_2014_mean"
WHERE mean_profit_ha < 0
GROUP BY fips;

-- add a column with the GEOID

ALTER TABLE "01_profit_below_breakeven_county"
ADD COLUMN geoid TEXT;

UPDATE "01_profit_below_breakeven_county"
SET geoid = '19' || substring(fips from 3 for 3);

--join the tables 01_profit_below_breakeven_county and 01_total_area_county

DROP TABLE IF EXISTS "01_profit_below_breakeven_total_area_county";
CREATE TABLE "01_profit_below_breakeven_total_area_county"
AS SELECT 
t1.*,
t2.total_area
FROM "01_profit_below_breakeven_county" AS t1
JOIN "01_total_area_county" AS t2 ON t1.fips = t2.fips;


-- calculate area weighted average profitability per county 

DROP TABLE IF EXISTS "01_profit_mean_county";
CREATE TABLE "01_profit_mean_county"
AS SELECT
fips,
sum(mean_profit_ha * clumuha)/sum(clumuha) AS mean_county_profit
FROM "01_clumu_cgsb_profit_2011_2014_mean"
GROUP BY fips;


ALTER TABLE "01_profit_mean_county"
ADD COLUMN geoid TEXT;

UPDATE "01_profit_mean_county"
SET geoid = '19' || substring(fips from 3 for 3);

*/
