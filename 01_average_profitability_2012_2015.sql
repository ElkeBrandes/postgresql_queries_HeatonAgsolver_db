
-- add cluid_mukey as a unique identifyer to the original table
/*
ALTER TABLE clumu_cgsb_profit_2012_2015
ADD COLUMN cluid_mukey TEXT;

UPDATE clumu_cgsb_profit_2012_2015
SET cluid_mukey = cluid || mukey;
*/
-- calculate mean profits for each polygon in a new table
-- calculate standard deviation as a measure of variability 
-- convert to metric system
/*
DROP TABLE IF EXISTS "01_clumu_cgsb_profit_2012_2015_mean";
CREATE TABLE "01_clumu_cgsb_profit_2012_2015_mean"
AS SELECT
fips,
cluid,
cluid_mukey,
acres / 2.471 as clumuha,
AVG(profit_csr2) * 2.471 AS mean_profit_ha,
STDDEV_POP(profit_csr2 * 2.471) AS std_profit
FROM clumu_cgsb_profit_2012_2015
GROUP BY cluid_mukey, cluid, acres, fips_crent;
*/

-- for distribution, round profits and std deviation to the dollar and aggregate
/*
ALTER TABLE "01_clumu_cgsb_profit_2012_2015_mean"
ADD COLUMN profit_mean_ha_rounded FLOAT;
ALTER TABLE "01_clumu_cgsb_profit_2012_2015_mean"
ADD COLUMN profit_std_ha_rounded FLOAT;

UPDATE "01_clumu_cgsb_profit_2012_2015_mean"
SET 
profit_mean_ha_rounded = ROUND(mean_profit_ha,0),
profit_std_ha_rounded = ROUND(std_profit,0);

-- aggregate to the rounded mean profit values by summing up the areas

DROP TABLE IF EXISTS "01_profit_mean_2012_2015_aggregated";
CREATE TABLE "01_profit_mean_2012_2015_aggregated"
AS SELECT 
profit_mean_ha_rounded,
sum(clumuha) as sum_ha
FROM "01_clumu_cgsb_profit_2012_2015_mean"
GROUP BY profit_mean_ha_rounded;

-- calculate total area:
-- SELECT SUM(sum_ha) FROM "01_profit_mean_2012_2015_aggregated" WHERE profit_mean_ha_rounded < 0;
-- result: 3699190 ha

-- create distributions for each year 
-- convert into metric system
-- aggregate to profitability
*/
-- 2012:
/*
DROP TABLE IF EXISTS "01_profit_rounded_aggregated_2012";
CREATE TABLE "01_profit_rounded_aggregated_2012"
AS WITH 
profit_rounded_2012 AS(
SELECT
ccrop,
acres/2.471 as clumuha,
ROUND(profit_csr2*2.471,0) as profit_2012_ha_rounded
FROM clumu_cgsb_profit_2012_2015
WHERE year = 2012)
 SELECT
profit_2012_ha_rounded,
SUM(clumuha) AS area
FROM profit_rounded_2012
GROUP BY profit_2012_ha_rounded;

-- 2013:

DROP TABLE IF EXISTS "01_profit_rounded_aggregated_2013";
CREATE TABLE "01_profit_rounded_aggregated_2013"
AS WITH 
profit_rounded_2013 AS(
SELECT
ccrop,
acres/2.471 as clumuha,
ROUND(profit_csr2*2.471,0) as profit_2013_ha_rounded
FROM clumu_cgsb_profit_2012_2015
WHERE year = 2013)
 SELECT
profit_2013_ha_rounded,
SUM(clumuha) AS area
FROM profit_rounded_2013
GROUP BY profit_2013_ha_rounded;


-- 2014:
DROP TABLE IF EXISTS "01_profit_rounded_aggregated_2014";
CREATE TABLE "01_profit_rounded_aggregated_2014"
AS WITH 
profit_rounded_2014 AS(
SELECT
ccrop,
acres/2.471 as clumuha,
ROUND(profit_csr2*2.471,0) as profit_2014_ha_rounded
FROM clumu_cgsb_profit_2012_2015
WHERE year = 2014)
 SELECT
profit_2014_ha_rounded,
SUM(clumuha) AS area
FROM profit_rounded_2014
GROUP BY profit_2014_ha_rounded;

-- 2015:
DROP TABLE IF EXISTS "01_profit_rounded_aggregated_2015";
CREATE TABLE "01_profit_rounded_aggregated_2015"
AS WITH 
profit_rounded_2015 AS(
SELECT
ccrop,
acres/2.471 as clumuha,
ROUND(profit_csr2*2.471,0) as profit_2015_ha_rounded
FROM clumu_cgsb_profit_2012_2015
WHERE year = 2015)
 SELECT
profit_2015_ha_rounded,
SUM(clumuha) AS area
FROM profit_rounded_2015
GROUP BY profit_2015_ha_rounded;
*/

-- create a table with the area in corn and soybean and the area below break even profit for each county 
/*
DROP TABLE IF EXISTS "01_profit_below_breakeven_total_area_county_12_15";
CREATE TABLE "01_profit_below_breakeven_total_area_county_12_15"
AS WITH profit_below_breakeven AS (
SELECT 
fips,
sum(clumuha) AS area
FROM "01_clumu_cgsb_profit_2012_2015_mean"
WHERE mean_profit_ha < 0
GROUP BY fips),
total_area AS (
SELECT
fips,
sum(clumuha) AS total_area
FROM "01_clumu_cgsb_profit_2012_2015_mean"
GROUP BY fips)
SELECT 
t1.*,
t2.total_area
FROM profit_below_breakeven AS t1
JOIN total_area AS t2 ON t1.fips = t2.fips;

-- add a column to calculate % of area below break EVENT

ALTER TABLE "01_profit_below_breakeven_total_area_county_12_15"
ADD COLUMN percent_area NUMERIC;

UPDATE "01_profit_below_breakeven_total_area_county_12_15"
SET percent_area = (area / total_area)*100;

-- calculate area weighted average profitability per county 

DROP TABLE IF EXISTS "01_profit_mean_county_2012_2015";
CREATE TABLE "01_profit_mean_county_2012_2015"
AS SELECT
fips,
sum(mean_profit_ha * clumuha)/sum(clumuha) AS mean_county_profit
FROM "01_clumu_cgsb_profit_2012_2015_mean"
GROUP BY fips;
*/

-- extract 
