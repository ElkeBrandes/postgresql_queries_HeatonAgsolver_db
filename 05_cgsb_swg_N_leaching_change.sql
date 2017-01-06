-- from the two model runs: cg sb 2012 - 2015 and swg 2006-2015, compare the changes in NO3 leaching
-- create cluid_mukey in the CG/SB table (since the SWG has only mukey to distinguish between different model outcomes):
/*
ALTER TABLE isu_cgsb_clumu_proc
ADD COLUMN cluid_mukey TEXT;
UPDATE isu_cgsb_clumu_proc
SET cluid_mukey = cluid || mukey;

-- create index for the field cluid_mukey (for faster performance)

CREATE INDEX dndc_clumu ON isu_cgsb_clumu_proc (cluid_mukey);
CREATE INDEX dndc_cgsb_mu ON isu_cgsb_clumu_proc (mukey);
CREATE INDEX dndc_swg_mu ON isu_swg_results_proc (mukey);
*/

--join:
-- cluid_mukey, mukey, clumuha, and mean profit from table "01_clumu_cgsb_profit_2012_2015_mean"
-- ave no3 leaching of CGSB (converted to kg/ha) from isu_cgsb_clumu_proc
-- ave no3 leaching of swg (converted to kg/ha) from isu_swg_results_proc

/*
DROP TABLE IF EXISTS "05_dndc_clumu_cgsb_swg";
CREATE TABLE "05_dndc_clumu_cgsb_swg"
AS WITH 
cgsb_table AS(
SELECT
t1.fips_crent AS fips,
t1.cluid_mukey,
t2.mukey,
t1.clumuha,
t1.mean_profit_ha,
t2.ave_no3_leach * 0.4536 * 2.471 AS ave_no3_leach_ha_cgsb
FROM "01_clumu_cgsb_profit_2012_2015_mean" as t1
JOIN isu_cgsb_clumu_proc as t2 on t1.cluid_mukey = t2.cluid_mukey
),
swg_7500_table AS(
SELECT
mukey,
ave_no3_leach * 0.4536 * 2.471 AS ave_no3_leach_ha_swg_7500
FROM isu_swg_results_proc WHERE yld_tag = 7500
),
swg_10000_table AS(
SELECT
mukey,
ave_no3_leach * 0.4536 * 2.471 AS ave_no3_leach_ha_swg_10000
FROM isu_swg_results_proc WHERE yld_tag = 10000
),
swg_12500_table AS(
SELECT
mukey,
ave_no3_leach * 0.4536 * 2.471 AS ave_no3_leach_ha_swg_12500
FROM isu_swg_results_proc WHERE yld_tag = 12500
),
swg_table1 AS(
SELECT
t1.*,
t2.ave_no3_leach_ha_swg_7500
FROM cgsb_table AS t1
LEFT JOIN swg_7500_table AS t2 ON t1.mukey = t2.mukey
),
swg_table2 AS (
SELECT
t1.*,
t2.ave_no3_leach_ha_swg_10000
FROM swg_table1 AS t1
LEFT JOIN swg_10000_table AS t2 ON t1.mukey = t2.mukey
)
SELECT 
t1.*,
t2.ave_no3_leach_ha_swg_12500
FROM swg_table2 as t1
JOIN swg_12500_table as t2 on t1.mukey = t2.mukey;
*/

-- add a column to enter the no3 leaching values for the profit optimized scenario:
-- ave_no3_leach_po for profit optimized (all areas where mean profit < -250 goes into swg)
-- add a column to enter the no3 leaching values for the water quality optimized scenario
-- ave_no3_leach_wo for water quality optimized (all areas where no3 leaching >100 go into swg)
/*
ALTER TABLE "05_dndc_clumu_cgsb_swg"
ADD COLUMN ave_no3_leach_po_7500 NUMERIC;
ALTER TABLE "05_dndc_clumu_cgsb_swg"
ADD COLUMN ave_no3_leach_po_10000 NUMERIC;
ALTER TABLE "05_dndc_clumu_cgsb_swg"
ADD COLUMN ave_no3_leach_po_12500 NUMERIC;
ALTER TABLE "05_dndc_clumu_cgsb_swg"
ADD COLUMN ave_no3_leach_wo_7500 NUMERIC;
ALTER TABLE "05_dndc_clumu_cgsb_swg"
ADD COLUMN ave_no3_leach_wo_10000 NUMERIC;
ALTER TABLE "05_dndc_clumu_cgsb_swg"
ADD COLUMN ave_no3_leach_wo_12500 NUMERIC;
*/
/*
UPDATE "05_dndc_clumu_cgsb_swg"
SET 
ave_no3_leach_po_7500 = CASE WHEN mean_profit_ha >= -150 THEN ave_no3_leach_ha_cgsb ELSE ave_no3_leach_ha_swg_7500 END,
ave_no3_leach_po_10000 = CASE WHEN mean_profit_ha >= -150 THEN ave_no3_leach_ha_cgsb ELSE ave_no3_leach_ha_swg_10000 END,
ave_no3_leach_po_12500 = CASE WHEN mean_profit_ha >= -150 THEN ave_no3_leach_ha_cgsb ELSE ave_no3_leach_ha_swg_12500 END,
ave_no3_leach_wo_7500 = CASE WHEN ave_no3_leach_ha_cgsb <= 60 THEN ave_no3_leach_ha_cgsb ELSE ave_no3_leach_ha_swg_7500 END,
ave_no3_leach_wo_10000 = CASE WHEN ave_no3_leach_ha_cgsb <= 60 THEN ave_no3_leach_ha_cgsb ELSE ave_no3_leach_ha_swg_10000 END,
ave_no3_leach_wo_12500 = CASE WHEN ave_no3_leach_ha_cgsb <= 60 THEN ave_no3_leach_ha_cgsb ELSE ave_no3_leach_ha_swg_12500 END;


-- test for errors in the data set:
select sum(clumuha) from "05_dndc_clumu_cgsb_swg" where ave_no3_leach_ha_cgsb is null;
-- result: 22866 ha

select sum(clumuha) from "05_dndc_clumu_cgsb_swg" where mean_profit_ha is not null;
-- result: 9370307 ha
select sum(clumuha) from "05_dndc_clumu_cgsb_swg";
-- test for area below/above cut offs:
select sum(clumuha) from "05_dndc_clumu_cgsb_swg" where mean_profit_ha < -250;
-- 876356
select sum(clumuha) from "05_dndc_clumu_cgsb_swg" where mean_profit_ha < -200;
-- 1178665
select sum(clumuha) from "05_dndc_clumu_cgsb_swg" where mean_profit_ha < -150;
-- 2109058
select sum(clumuha) from "05_dndc_clumu_cgsb_swg" where mean_profit_ha < 0;
-- 3675705
select sum(clumuha) from "05_dndc_clumu_cgsb_swg" where ave_no3_leach_ha_cgsb > 100;
-- 441942
select sum(clumuha) from "05_dndc_clumu_cgsb_swg" where ave_no3_leach_ha_cgsb > 75;
-- 1237460
select sum(clumuha) from "05_dndc_clumu_cgsb_swg" where ave_no3_leach_ha_cgsb > 70;
-- 1517001
select sum(clumuha) from "05_dndc_clumu_cgsb_swg" where ave_no3_leach_ha_cgsb > 65;
-- 1862223
select sum(clumuha) from "05_dndc_clumu_cgsb_swg" where ave_no3_leach_ha_cgsb > 60;
-- 
select sum(clumuha) from "05_dndc_clumu_cgsb_swg" where ave_no3_leach_ha_cgsb > 50;
-- 3379478
*/
-- take sums for Iowa (in Mg) for the BAU, profit optimization and water quality optimization scenarios:

DROP TABLE IF EXISTS "05_dndc_no3_leach_sums_iowa_scenarios";
CREATE TABLE "05_dndc_no3_leach_sums_iowa_scenarios"
AS SELECT
(sum(ave_no3_leach_ha_cgsb * clumuha)) / 1000  as sum_ave_no3_leach_cgsb,
(sum(ave_no3_leach_po_7500 * clumuha)) / 1000  as sum_ave_no3_leach_po_7500,
(sum(ave_no3_leach_po_10000 * clumuha)) / 1000  as sum_ave_no3_leach_po_10000,
(sum(ave_no3_leach_po_12500 * clumuha)) / 1000  as sum_ave_no3_leach_po_12500,
(sum(ave_no3_leach_wo_7500 * clumuha)) / 1000  as sum_ave_no3_leach_wo_7500,
(sum(ave_no3_leach_wo_10000 * clumuha)) / 1000  as sum_ave_no3_leach_wo_10000,
(sum(ave_no3_leach_wo_12500 * clumuha)) / 1000  as sum_ave_no3_leach_wo_12500
FROM "05_dndc_clumu_cgsb_swg";


-- extract data of Carroll county
/*
DROP TABLE IF EXISTS "05_dndc_clumu_cgsb_2011_2014_ia027";
CREATE TABLE "05_dndc_clumu_cgsb_2011_2014_ia027"
AS SELECT
*
FROM isu_cgsb_clumu_proc
WHERE fips = 'IA027';


DROP TABLE IF EXISTS "05_dndc_clumu_swg_2005_2014_ia027";
CREATE TABLE "05_dndc_clumu_swg_2005_2014_ia027"
AS SELECT
*
FROM isu_swg_clumu_proc
WHERE fips = 'IA027';
*/
-- join both tables and convert NO3 leaching in metric units
/*
DROP TABLE IF EXISTS "05_dndc_clumu_leach_change_ia027";
CREATE TABLE "05_dndc_clumu_leach_change_ia027"
AS SELECT
t1.cluid,
t1.mukey,
t1.ave_no3_leach * 0.4536 * 2.471 as ave_no3_leach_cs,
t2.ave_no3_leach * 0.4536 * 2.471 as ave_no3_leach_swg
FROM "05_dndc_clumu_cgsb_2011_2014_ia027" as t1 
JOIN "05_dndc_clumu_swg_2005_2014_ia027" as t2 on t1.cluid = t2.cluid AND t1.mukey = t2.mukey;
*/
-- add cluid_mukey and change COLUMN
/*
ALTER TABLE "05_dndc_clumu_leach_change_ia027"
ADD COLUMN cluid_mukey TEXT,
ADD COLUMN ave_no3_leach_change NUMERIC;

UPDATE "05_dndc_clumu_leach_change_ia027"
SET cluid_mukey = cluid || mukey;
*/

-- join this table with the selection table: 02_subset_unprofit_15_percent
/*
DROP TABLE IF EXISTS "05_dndc_clumu_leach_change_unprofit_ia027";
CREATE TABLE "05_dndc_clumu_leach_change_unprofit_ia027"
AS SELECT 
t1.*,
t2.mean_profit_ha
FROM "05_dndc_clumu_leach_change_ia027" as t1
LEFT JOIN "02_subset_unprofit_15_percent" as t2 on t1.cluid_mukey = t2.cluid_mukey;
*/
/*
UPDATE "05_dndc_clumu_leach_change_unprofit_ia027"
SET ave_no3_leach_change = ave_no3_leach_swg - ave_no3_leach_cs WHERE mean_profit_ha IS NOT NULL;

UPDATE "05_dndc_clumu_leach_change_unprofit_ia027"
SET ave_no3_leach_change = '0' WHERE mean_profit_ha IS NULL;
*/


