-- extract a table with yields and crops for each year 2011-2014
-- using WITH table AS query to build auxiliary table that are only available for the current query
-- all values are tranformed to metric units and rounded
-- the resulting table 09_yields_2011_2014 can be exported in psql to a txt file and used in ArcGIS
-- change yields from bu/ac to kg/ha

/*
DROP TABLE IF EXISTS "09_yields_2011_2014";
CREATE TABLE "09_yields_2011_2014" AS
WITH 
yieldtable11 AS (
SELECT
fips_crent,
cluid_mukey as cluid_mukey11,
acres / 2.471 as clumuha,
ccrop as crop11,
(CASE WHEN ccrop = 'CG' THEN (yield / 39.368 ) * 2471 ELSE (yield / 36.7437) * 2471 END) as yield11
FROM clumu_cgsb_profit_2011_2014 
WHERE year = '2011'
),
yieldtable12 AS (
SELECT
cluid_mukey as cluid_mukey12,
ccrop as crop12,
(CASE WHEN ccrop = 'CG' THEN (yield / 39.368 ) * 2471 ELSE (yield / 36.7437) * 2471 END) as yield12
FROM clumu_cgsb_profit_2011_2014 
WHERE year = '2012'
),
yieldtable13 AS (
SELECT
cluid_mukey as cluid_mukey13,
ccrop as crop13,
(CASE WHEN ccrop = 'CG' THEN (yield / 39.368 ) * 2471 ELSE (yield / 36.7437) * 2471 END) as yield13
FROM clumu_cgsb_profit_2011_2014 
WHERE year = '2013'
),
yieldtable14 AS (
SELECT
cluid_mukey as cluid_mukey14,
ccrop as crop14,
(CASE WHEN ccrop = 'CG' THEN (yield / 39.368 ) * 2471 ELSE (yield / 36.7437) * 2471 END) as yield14
FROM clumu_cgsb_profit_2011_2014 
WHERE year = '2014'
),
yieldtable1112 AS (
SELECT
t1.*,
t2.crop12,
t2.yield12
from yieldtable11 as t1
LEFT JOIN yieldtable12 as t2 on t1.cluid_mukey11 = t2.cluid_mukey12
),
yieldtable1113 AS (
SELECT 
t1.*,
t2.crop13,
t2.yield13
from yieldtable1112 as t1
LEFT JOIN yieldtable13 as t2 on t1.cluid_mukey11 = t2.cluid_mukey13
)
SELECT
t1.*,
t2.crop14,
t2.yield14
FROM yieldtable1113 as t1
LEFT JOIN yieldtable14 as t2 ON t1.cluid_mukey11 = t2.cluid_mukey14;
*/
-- join yield cutoffs to the yield table 

DROP TABLE IF EXISTS "09_yields_cutoffs_2011_2014";
CREATE TABLE "09_yields_cutoffs_2011_2014" AS
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
FROM "09_yields_2011_2014" AS t1
LEFT JOIN per_county_min_yields AS t2 ON t1.fips_crent = t2.fips;
