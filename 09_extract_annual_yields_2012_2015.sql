-- extract a table with yields and crops for each year 2012-2015
-- using WITH table AS query to build auxiliary table that are only available for the current query
-- all values are tranformed to metric units and rounded
-- the resulting table 09_yields_2012_2015 can be exported in psql to a txt file and used in ArcGIS
-- change yields from bu/ac to kg/ha


DROP TABLE IF EXISTS "09_yields_2012_2015";
CREATE TABLE "09_yields_2012_2015" AS
WITH 
yieldtable12 AS (
SELECT
fips,
cluid_mukey as cluid_mukey12,
acres / 2.471 as clumuha,
ccrop as crop12,
(CASE WHEN ccrop = 'CG' THEN (yield / 39.368 ) * 2471 ELSE (yield / 36.7437) * 2471 END) as yield12
FROM clumu_cgsb_profit_2012_2015 
WHERE year = '2012'
),
yieldtable13 AS (
SELECT
cluid_mukey as cluid_mukey13,
ccrop as crop13,
(CASE WHEN ccrop = 'CG' THEN (yield / 39.368 ) * 2471 ELSE (yield / 36.7437) * 2471 END) as yield13
FROM clumu_cgsb_profit_2012_2015 
WHERE year = '2013'
),
yieldtable14 AS (
SELECT
cluid_mukey as cluid_mukey14,
ccrop as crop14,
(CASE WHEN ccrop = 'CG' THEN (yield / 39.368 ) * 2471 ELSE (yield / 36.7437) * 2471 END) as yield14
FROM clumu_cgsb_profit_2012_2015 
WHERE year = '2014'
),
yieldtable15 AS (
SELECT
cluid_mukey as cluid_mukey15,
ccrop as crop15,
(CASE WHEN ccrop = 'CG' THEN (yield / 39.368 ) * 2471 ELSE (yield / 36.7437) * 2471 END) as yield15
FROM clumu_cgsb_profit_2012_2015 
WHERE year = '2015'
),
yieldtable1213 AS (
SELECT
t1.*,
t2.crop13,
t2.yield13
from yieldtable12 as t1
LEFT JOIN yieldtable13 as t2 on t1.cluid_mukey12 = t2.cluid_mukey13
),
yieldtable1214 AS (
SELECT 
t1.*,
t2.crop14,
t2.yield14
from yieldtable1213 as t1
LEFT JOIN yieldtable14 as t2 on t1.cluid_mukey12 = t2.cluid_mukey14
)
SELECT
t1.*,
t2.crop15,
t2.yield15
FROM yieldtable1214 as t1
LEFT JOIN yieldtable15 as t2 ON t1.cluid_mukey12 = t2.cluid_mukey15;

-- join yield cutoffs to the yield table 

DROP TABLE IF EXISTS "09_yields_cutoffs_2012_2015";
CREATE TABLE "09_yields_cutoffs_2012_2015" AS
SELECT 
t1.*,
t2.cut_cg_min_16,
t2.cut_sb_min_16,
t2.cut_cg_2nd_16,
t2.cut_sb_2nd_16,
t2.cut_cg_min_6,
t2.cut_sb_min_6,
t2.cut_cg_2nd_6,
t2.cut_sb_2nd_6
FROM "09_yields_2012_2015" AS t1
LEFT JOIN per_county_min_yields AS t2 ON t1.fips = t2.fips;
