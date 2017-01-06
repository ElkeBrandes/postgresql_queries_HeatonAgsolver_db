-- take means of corn yields over the years 2011-2015
/*
DROP TABLE IF EXISTS "08_mean_corn_yields_2011_2015";
CREATE TABLE "08_mean_corn_yields_2011_2015"
AS SELECT
fips,
cluid_mukey,
ROUND((AVG(yield) / 39.368 ) * 2.471,2) as mean_corn_yield,
COUNT('CG') as cg_count,
ROUND((AVG(yield) / 39.368 ) * 2.471,1) as mean_corn_yield_round,
clumuacres / 2.471 as clumuha
FROM clumu_cgsb_profit_2011_2014
WHERE ccrop = 'CG' 
GROUP BY cluid_mukey, clumuacres, fips;

-- group by the rounded yields for distribution:

DROP TABLE IF EXISTS "08_yields_round_aggr";
CREATE TABLE "08_yields_round_aggr"
AS SELECT
mean_corn_yield_round,
sum(clumuha) as area_ha
FROM "08_mean_corn_yields_2011_2015"
GROUP by mean_corn_yield_round;
*/
/*
-- check area that would fall into different cut off yield scenarios:

-- yield < 5 Mg/ha:
SELECT sum(clumuha) FROM "08_mean_corn_yields_2011_2015" WHERE mean_corn_yield < 5;

-- Yield < 7.5 Mg/ha:
SELECT sum(clumuha) FROM "08_mean_corn_yields_2011_2015" WHERE mean_corn_yield < 7.5;

-- Yield < 8 Mg/ha:
SELECT sum(clumuha) FROM "08_mean_corn_yields_2011_2015" WHERE mean_corn_yield < 8;

-- Yield < 8.5 Mg/ha:
SELECT sum(clumuha) FROM "08_mean_corn_yields_2011_2015" WHERE mean_corn_yield < 8.5;
*/

-- aggregate area weighted mean yields to county

DROP TABLE IF EXISTS "08_county_mean_corn_yields_2011_2015";
CREATE TABLE "08_county_mean_corn_yields_2011_2015"
AS SELECT
fips,
round(sum(mean_corn_yield*clumuha)/sum(clumuha),1) AS county_yield
FROM "08_mean_corn_yields_2011_2015"
GROUP BY fips;

