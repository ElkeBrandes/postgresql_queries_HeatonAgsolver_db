-- from table clumu_cgsb_profit_2011_2014_mean, filter out areas that should go into switchgrass:
-- 1. mean profit < 0
-- 2. combined area at least 15% of CLU area 


-- calculate total clu areas:
/*
DROP TABLE IF EXISTS "02_clu_area";
CREATE TABLE "02_clu_area"
AS SELECT
cluid,
sum(clumuha) AS cluha
FROM "01_clumu_cgsb_profit_2011_2014_mean"
GROUP BY cluid;

-- calculate number of clumu per CLU with profits < 0:

DROP TABLE IF EXISTS "02_clu_count";
CREATE TABLE "02_clu_count"
AS SELECT
cluid,
count(cluid) AS clucount
FROM "01_clumu_cgsb_profit_2011_2014_mean"
WHERE mean_profit_ha < 0
GROUP BY cluid;

DROP TABLE IF EXISTS "02_clu_area_below_zero";
CREATE TABLE "02_clu_area_below_zero"
AS SELECT
cluid,
sum(clumuha) AS cluha0
FROM "01_clumu_cgsb_profit_2011_2014_mean"
WHERE mean_profit_ha < 0
GROUP BY cluid;

*/

-- join the above tables
/*
DROP TABLE IF EXISTS "02_clumu_cgsb_profit_switch1";
CREATE TABLE "02_clumu_cgsb_profit_switch1" AS 
WITH clutable1 AS (
SELECT
t1.fips,
t1.cluid,
t2.cluha,
t1.cluid_mukey,
t1.clumuha,
t1.mean_profit_ha,
t1.std_profit
FROM "01_clumu_cgsb_profit_2011_2014_mean" AS t1
LEFT JOIN "02_clu_area" AS t2 ON t1.cluid = t2.cluid
), clutable2 AS (
SELECT 
t1.fips,
t1.cluid,
t1.cluha,
t2.clucount,
t1.cluid_mukey,
t1.clumuha,
t1.mean_profit_ha,
t1.std_profit
FROM clutable1 AS t1
LEFT JOIN "02_clu_count" AS t2 ON t1.cluid = t2.cluid
)
SELECT
t1.fips,
t1.cluid,
t1.cluha,
t2.cluha0,
t1.clucount,
t1.cluid_mukey,
t1.clumuha,
t1.mean_profit_ha,
t1.std_profit
FROM clutable2 AS t1
LEFT JOIN "02_clu_area_below_zero" AS t2 ON t1.cluid = t2.cluid;
*/
-- create tables that contain the annual values for crop, yields, price, profit and ROI in metric units:
/*
DROP TABLE IF EXISTS "02_clumu_2011";
CREATE TABLE "02_clumu_2011" AS 
SELECT
cluid_mukey,
ccrop AS crop11,
(CASE WHEN ccrop = 'CG' THEN round(yield*56*0.454*2.471*0.001,2) ELSE round(yield*60*0.454*2.471*0.001,2) END) AS yield11,
(CASE WHEN ccrop = 'CG' THEN round((grain_price/(56*0.454))*1000,2) ELSE round((grain_price/(60*0.454))*1000,2) END) AS grain_price11,
round(clu_cash_rent * 2.471,2) AS clu_cash_rent11,
round(preharv_machinery*2.471,2) AS preharvest_machinery11,
round(seed_chem * 2.471,2) AS seed_chem11,
round(labor * 2.471,2) AS labor11,
round(n_cost * 2.471,2) AS n_cost11,
round(p_cost * 2.471,2) AS p_cost11,
round(k_cost * 2.471,2) AS k_cost11,
round(harv_machinery * yield * 2.471,2) AS harv_machinery11,
round(profit*2.471,2) AS profit11,
round(roi,2) AS roi11
FROM clumu_cgsb_profit_2011_2014
WHERE year = 2011;

DROP TABLE IF EXISTS "02_clumu_2012";
CREATE TABLE "02_clumu_2012" AS 
SELECT
cluid_mukey,
ccrop AS crop12,
(CASE WHEN ccrop = 'CG' THEN round(yield*56*0.454*2.471*0.001,2) ELSE round(yield*60*0.454*2.471*0.001,2) END) AS yield12,
(CASE WHEN ccrop = 'CG' THEN round((grain_price/(56*0.454))*1000,2) ELSE round((grain_price/(60*0.454))*1000,2) END) AS grain_price12,
round(clu_cash_rent * 2.471,2) AS clu_cash_rent12,
round(preharv_machinery*2.471,2) AS preharvest_machinery12,
round(seed_chem * 2.471,2) AS seed_chem12,
round(labor * 2.471,2) AS labor12,
round(n_cost * 2.471,2) AS n_cost12,
round(p_cost * 2.471,2) AS p_cost12,
round(k_cost * 2.471,2) AS k_cost12,
round(harv_machinery * yield * 2.471,2) AS harv_machinery12,
round(profit*2.471,2) AS profit12,
round(roi,2) AS roi12
FROM clumu_cgsb_profit_2011_2014
WHERE year = 2012;

DROP TABLE IF EXISTS "02_clumu_2013";
CREATE TABLE "02_clumu_2013" AS 
SELECT
cluid_mukey,
ccrop AS crop13,
(CASE WHEN ccrop = 'CG' THEN round(yield*56*0.454*2.471*0.001,2) ELSE round(yield*60*0.454*2.471*0.001,2) END) AS yield13,
(CASE WHEN ccrop = 'CG' THEN round((grain_price/(56*0.454))*1000,2) ELSE round((grain_price/(60*0.454))*1000,2) END) AS grain_price13,
round(clu_cash_rent * 2.471,2) AS clu_cash_rent13,
round(preharv_machinery*2.471,2) AS preharvest_machinery13,
round(seed_chem * 2.471,2) AS seed_chem13,
round(labor * 2.471,2) AS labor13,
round(n_cost * 2.471,2) AS n_cost13,
round(p_cost * 2.471,2) AS p_cost13,
round(k_cost * 2.471,2) AS k_cost13,
round(harv_machinery * yield * 2.471,2) AS harv_machinery13,
round(profit*2.471,2) AS profit13,
round(roi,2) AS roi13
FROM clumu_cgsb_profit_2011_2014
WHERE year = 2013;

DROP TABLE IF EXISTS "02_clumu_2014";
CREATE TABLE "02_clumu_2014" AS 
SELECT
cluid_mukey,
ccrop AS crop14,
(CASE WHEN ccrop = 'CG' THEN round(yield*56*0.454*2.471*0.001,2) ELSE round(yield*60*0.454*2.471*0.001,2) END) AS yield14,
(CASE WHEN ccrop = 'CG' THEN round((grain_price/(56*0.454))*1000,2) ELSE round((grain_price/(60*0.454))*1000,2) END) AS grain_price14,
round(clu_cash_rent * 2.471,2) AS clu_cash_rent14,
round(preharv_machinery*2.471,2) AS preharvest_machinery14,
round(seed_chem * 2.471,2) AS seed_chem14,
round(labor * 2.471,2) AS labor14,
round(n_cost * 2.471,2) AS n_cost14,
round(p_cost * 2.471,2) AS p_cost14,
round(k_cost * 2.471,2) AS k_cost14,
round(harv_machinery * yield * 2.471,2) AS harv_machinery14,
round(profit*2.471,2) AS profit14,
round(roi,2) AS roi14
FROM clumu_cgsb_profit_2011_2014
WHERE year = 2014;

*/
-- join 02_clumu_cgsb_profit_switch1 with the tables containing the year data 

/*
DROP TABLE IF EXISTS "02_clumu_cgsb_profit_switch2";
CREATE TABLE "02_clumu_cgsb_profit_switch2" AS 
WITH table11 AS (
SELECT
t1.fips,
t1.cluid,
t1.cluha,
t1.cluha0,
t1.clucount,
t1.cluid_mukey,
t1.clumuha,
t1.mean_profit_ha,
t1.std_profit,
t2.crop11,
t2.yield11,
t2.grain_price11,
t2.clu_cash_rent11,
t2.preharvest_machinery11,
t2.seed_chem11,
t2.labor11,
t2.n_cost11,
t2.p_cost11,
t2.k_cost11,
t2.harv_machinery11,
t2.profit11,
t2.roi11
FROM "02_clumu_cgsb_profit_switch1" AS t1
INNER JOIN "02_clumu_2011" AS t2 ON t1.cluid_mukey = t2.cluid_mukey)
, table12 AS (
SELECT 
t1.*,
t2.crop12,
t2.yield12,
t2.grain_price12,
t2.clu_cash_rent12,
t2.preharvest_machinery12,
t2.seed_chem12,
t2.labor12,
t2.n_cost12,
t2.p_cost12,
t2.k_cost12,
t2.harv_machinery12,
t2.profit12,
t2.roi12
FROM table11 AS t1
INNER JOIN "02_clumu_2012" AS t2 ON t1.cluid_mukey = t2.cluid_mukey)
, table13 AS (
SELECT 
t1.*,
t2.crop13,
t2.yield13,
t2.grain_price13,
t2.clu_cash_rent13,
t2.preharvest_machinery13,
t2.seed_chem13,
t2.labor13,
t2.n_cost13,
t2.p_cost13,
t2.k_cost13,
t2.harv_machinery13,
t2.profit13,
t2.roi13
FROM table12 AS t1
INNER JOIN "02_clumu_2013" AS t2 ON t1.cluid_mukey = t2.cluid_mukey)
SELECT 
t1.*,
t2.crop14,
t2.yield14,
t2.grain_price14,
t2.clu_cash_rent14,
t2.preharvest_machinery14,
t2.seed_chem14,
t2.labor14,
t2.n_cost14,
t2.p_cost14,
t2.k_cost14,
t2.harv_machinery14,
t2.profit14,
t2.roi14
FROM table13 AS t1
INNER JOIN "02_clumu_2014" AS t2 ON t1.cluid_mukey = t2.cluid_mukey
*/



-- filter out polygons with mean profit < 0, that add up to 15% or more of the whole CLU:
/*
DROP TABLE IF EXISTS "02_subset_unprofit_15_percent";
CREATE TABLE "02_subset_unprofit_15_percent"
AS SELECT 
*
FROM "02_clumu_cgsb_profit_switch2"
WHERE mean_profit_ha < 0 
AND cluha0/cluha >= 0.15;
*/
/*
-- check total area of the subset:
SELECT sum(clumuha) FROM "02_subset_unprofit_15_percent";
--1049211.22
SELECT sum(clumuha) FROM "02_subset_unprofit_15_percent" WHERE crop11 = 'CG' AND crop12 = 'CG' AND crop13 = 'CG' AND crop14 = 'CG';
-- 198244.73
SELECT sum(clumuha) FROM "02_subset_unprofit_15_percent" WHERE crop11 = 'CG' AND crop12 = 'SB' AND crop13 = 'CG' AND crop14 = 'SB';
-- 218853.48
SELECT sum(clumuha) FROM "02_subset_unprofit_15_percent" WHERE crop11 = 'SB' AND crop12 = 'CG' AND crop13 = 'SB' AND crop14 = 'CG';
-- 270657.89
SELECT sum(clumuha) FROM "02_subset_unprofit_15_percent" WHERE crop11 = 'SB' AND crop12 = 'CG' AND crop13 = 'CG' AND crop14 = 'CG';
-- 87532.46
SELECT sum(clumuha) FROM "02_subset_unprofit_15_percent" WHERE crop11 = 'CG' AND crop12 = 'SB' AND crop13 = 'CG' AND crop14 = 'CG';
-- 54409.10
SELECT sum(clumuha) FROM "02_subset_unprofit_15_percent" WHERE crop11 = 'CG' AND crop12 = 'CG' AND crop13 = 'SB' AND crop14 = 'CG';
-- 44896.70
SELECT sum(clumuha) FROM "02_subset_unprofit_15_percent" WHERE crop11 = 'CG' AND crop12 = 'CG' AND crop13 = 'CG' AND crop14 = 'SB';
-- 47180.99
SELECT sum(clumuha) FROM "02_subset_unprofit_15_percent" WHERE crop11 = 'SB' AND crop12 = 'CG' AND crop13 = 'CG' AND crop14 = 'SB';
-- 46703.35
SELECT sum(clumuha) FROM "02_subset_unprofit_15_percent" WHERE crop11 = 'CG' AND crop12 = 'CG' AND crop13 = 'SB' AND crop14 = 'SB';
-- 3652.96

SELECT sum(clumuha) FROM "02_subset_unprofit_15_percent" WHERE crop11 = 'CG' AND crop12 = 'SB' AND crop13 = 'SB' AND crop14 = 'SB';
-- 7152.25
SELECT sum(clumuha) FROM "02_subset_unprofit_15_percent" WHERE crop11 = 'SB' AND crop12 = 'SB' AND crop13 = 'CG' AND crop14 = 'CG';
-- 8008.05

*/


-- calculate area weighted means of each of the costs/revenues for each rotation

-- CG,CG,CG,CG

DROP TABLE IF EXISTS "02_means_cccc";
CREATE TABLE "02_means_cccc"
AS SELECT
sum(clumuha) AS total_ha,
sum(mean_profit_ha * clumuha)/NULLIF (sum(clumuha),0) AS mean_profit_4yrs,
sum(profit11 * clumuha)/NULLIF (sum(clumuha),0) AS mean_profit11,
sum(profit12 * clumuha)/NULLIF (sum(clumuha),0) AS mean_profit12,
sum(profit13 * clumuha)/NULLIF (sum(clumuha),0) AS mean_profit13,
sum(profit14 * clumuha)/NULLIF (sum(clumuha),0) AS mean_profit14,
sum(yield11 * clumuha)/NULLIF (sum(clumuha),0) AS mean_yield11,
sum(yield12 * clumuha)/NULLIF (sum(clumuha),0) AS mean_yield12,
sum(yield13 * clumuha)/NULLIF (sum(clumuha),0) AS mean_yield13,
sum(yield14 * clumuha)/NULLIF (sum(clumuha),0) AS mean_yield14,
249.67 AS corn_price11,
272.97 AS corn_price12,
177.39 AS corn_price13,
145.53 AS corn_price14,
sum(clu_cash_rent11 * clumuha)/NULLIF (sum(clumuha),0) AS mean_cash_rent11,
sum(clu_cash_rent12 * clumuha)/NULLIF (sum(clumuha),0) AS mean_cash_rent12,
sum(clu_cash_rent13 * clumuha)/NULLIF (sum(clumuha),0) AS mean_cash_rent13,
sum(clu_cash_rent14 * clumuha)/NULLIF (sum(clumuha),0) AS mean_cash_rent14,
214*2.471 AS state_mean_cash_rent11,
252*2.471 AS state_mean_cash_rent12,
270*2.471 AS state_mean_cash_rent13,
260*2.471 AS state_mean_cash_rent14,
sum(preharvest_machinery11 * clumuha)/NULLIF (sum(clumuha),0) AS mean_preharv_mach11,
sum(preharvest_machinery12 * clumuha)/NULLIF (sum(clumuha),0) AS mean_preharv_mach12,
sum(preharvest_machinery13 * clumuha)/NULLIF (sum(clumuha),0) AS mean_preharv_mach13,
sum(preharvest_machinery14 * clumuha)/NULLIF (sum(clumuha),0) AS mean_preharv_mach14,
sum(seed_chem11 * clumuha)/NULLIF (sum(clumuha),0) AS mean_seed_chem11,
sum(seed_chem12 * clumuha)/NULLIF (sum(clumuha),0) AS mean_seed_chem12,
sum(seed_chem13 * clumuha)/NULLIF (sum(clumuha),0) AS mean_seed_chem13,
sum(seed_chem14 * clumuha)/NULLIF (sum(clumuha),0) AS mean_seed_chem14,
sum(labor11 * clumuha)/NULLIF (sum(clumuha),0) AS mean_labor11,
sum(labor12 * clumuha)/NULLIF (sum(clumuha),0) AS mean_labor12,
sum(labor13 * clumuha)/NULLIF (sum(clumuha),0) AS mean_labor13,
sum(labor14 * clumuha)/NULLIF (sum(clumuha),0) AS mean_labor14,
sum(n_cost11 * clumuha)/NULLIF (sum(clumuha),0) AS n_cost11,
sum(n_cost12 * clumuha)/NULLIF (sum(clumuha),0) AS n_cost12,
sum(n_cost13 * clumuha)/NULLIF (sum(clumuha),0) AS n_cost13,
sum(n_cost14 * clumuha)/NULLIF (sum(clumuha),0) AS n_cost14,
sum(p_cost11 * clumuha)/NULLIF (sum(clumuha),0) AS p_cost11,
sum(p_cost12 * clumuha)/NULLIF (sum(clumuha),0) AS p_cost12,
sum(p_cost13 * clumuha)/NULLIF (sum(clumuha),0) AS p_cost13,
sum(p_cost14 * clumuha)/NULLIF (sum(clumuha),0) AS p_cost14,
sum(k_cost11 * clumuha)/NULLIF (sum(clumuha),0) AS k_cost11,
sum(k_cost12 * clumuha)/NULLIF (sum(clumuha),0) AS k_cost12,
sum(k_cost13 * clumuha)/NULLIF (sum(clumuha),0) AS k_cost13,
sum(k_cost14 * clumuha)/NULLIF (sum(clumuha),0) AS k_cost14,
sum(harv_machinery11 * clumuha)/NULLIF (sum(clumuha),0) AS harv_mach11,
sum(harv_machinery12 * clumuha)/NULLIF (sum(clumuha),0) AS harv_mach12,
sum(harv_machinery13 * clumuha)/NULLIF (sum(clumuha),0) AS harv_mach13,
sum(harv_machinery14 * clumuha)/NULLIF (sum(clumuha),0) AS harv_mach14
FROM "02_subset_unprofit_15_percent"
WHERE crop11 = 'CG'
AND crop12 = 'CG'
AND crop13 = 'CG'
AND crop14 = 'CG';

-- CG,SB,CG,SB

DROP TABLE IF EXISTS "02_means_cscs";
CREATE TABLE "02_means_cscs"
AS SELECT
sum(clumuha) AS total_ha,
sum(mean_profit_ha * clumuha)/NULLIF (sum(clumuha),0) AS mean_profit_4yrs,
sum(profit11 * clumuha)/NULLIF (sum(clumuha),0) AS mean_profit11,
sum(profit12 * clumuha)/NULLIF (sum(clumuha),0) AS mean_profit12,
sum(profit13 * clumuha)/NULLIF (sum(clumuha),0) AS mean_profit13,
sum(profit14 * clumuha)/NULLIF (sum(clumuha),0) AS mean_profit14,
sum(yield11 * clumuha)/NULLIF (sum(clumuha),0) AS mean_yield11,
sum(yield12 * clumuha)/NULLIF (sum(clumuha),0) AS mean_yield12,
sum(yield13 * clumuha)/NULLIF (sum(clumuha),0) AS mean_yield13,
sum(yield14 * clumuha)/NULLIF (sum(clumuha),0) AS mean_yield14,
249.67 AS corn_price11,
533.77 AS soy_price12,
177.39 AS corn_price13,
364.90 AS soy_price14,
sum(clu_cash_rent11 * clumuha)/NULLIF (sum(clumuha),0) AS mean_cash_rent11,
sum(clu_cash_rent12 * clumuha)/NULLIF (sum(clumuha),0) AS mean_cash_rent12,
sum(clu_cash_rent13 * clumuha)/NULLIF (sum(clumuha),0) AS mean_cash_rent13,
sum(clu_cash_rent14 * clumuha)/NULLIF (sum(clumuha),0) AS mean_cash_rent14,
214*2.471 AS state_mean_cash_rent11,
252*2.471 AS state_mean_cash_rent12,
270*2.471 AS state_mean_cash_rent13,
260*2.471 AS state_mean_cash_rent14,
sum(preharvest_machinery11 * clumuha)/NULLIF (sum(clumuha),0) AS mean_preharv_mach11,
sum(preharvest_machinery12 * clumuha)/NULLIF (sum(clumuha),0) AS mean_preharv_mach12,
sum(preharvest_machinery13 * clumuha)/NULLIF (sum(clumuha),0) AS mean_preharv_mach13,
sum(preharvest_machinery14 * clumuha)/NULLIF (sum(clumuha),0) AS mean_preharv_mach14,
sum(seed_chem11 * clumuha)/NULLIF (sum(clumuha),0) AS mean_seed_chem11,
sum(seed_chem12 * clumuha)/NULLIF (sum(clumuha),0) AS mean_seed_chem12,
sum(seed_chem13 * clumuha)/NULLIF (sum(clumuha),0) AS mean_seed_chem13,
sum(seed_chem14 * clumuha)/NULLIF (sum(clumuha),0) AS mean_seed_chem14,
sum(labor11 * clumuha)/NULLIF (sum(clumuha),0) AS mean_labor11,
sum(labor12 * clumuha)/NULLIF (sum(clumuha),0) AS mean_labor12,
sum(labor13 * clumuha)/NULLIF (sum(clumuha),0) AS mean_labor13,
sum(labor14 * clumuha)/NULLIF (sum(clumuha),0) AS mean_labor14,
sum(n_cost11 * clumuha)/NULLIF (sum(clumuha),0) AS n_cost11,
sum(n_cost12 * clumuha)/NULLIF (sum(clumuha),0) AS n_cost12,
sum(n_cost13 * clumuha)/NULLIF (sum(clumuha),0) AS n_cost13,
sum(n_cost14 * clumuha)/NULLIF (sum(clumuha),0) AS n_cost14,
sum(p_cost11 * clumuha)/NULLIF (sum(clumuha),0) AS p_cost11,
sum(p_cost12 * clumuha)/NULLIF (sum(clumuha),0) AS p_cost12,
sum(p_cost13 * clumuha)/NULLIF (sum(clumuha),0) AS p_cost13,
sum(p_cost14 * clumuha)/NULLIF (sum(clumuha),0) AS p_cost14,
sum(k_cost11 * clumuha)/NULLIF (sum(clumuha),0) AS k_cost11,
sum(k_cost12 * clumuha)/NULLIF (sum(clumuha),0) AS k_cost12,
sum(k_cost13 * clumuha)/NULLIF (sum(clumuha),0) AS k_cost13,
sum(k_cost14 * clumuha)/NULLIF (sum(clumuha),0) AS k_cost14,
sum(harv_machinery11 * clumuha)/NULLIF (sum(clumuha),0) AS harv_mach11,
sum(harv_machinery12 * clumuha)/NULLIF (sum(clumuha),0) AS harv_mach12,
sum(harv_machinery13 * clumuha)/NULLIF (sum(clumuha),0) AS harv_mach13,
sum(harv_machinery14 * clumuha)/NULLIF (sum(clumuha),0) AS harv_mach14
FROM "02_subset_unprofit_15_percent"
WHERE crop11 = 'CG'
AND crop12 = 'SB'
AND crop13 = 'CG'
AND crop14 = 'SB';

-- SB,CG,SB,CG

DROP TABLE IF EXISTS "02_means_scsc";
CREATE TABLE "02_means_scsc"
AS SELECT
sum(clumuha) AS total_ha,
sum(mean_profit_ha * clumuha)/NULLIF (sum(clumuha),0) AS mean_profit_4yrs,
sum(profit11 * clumuha)/NULLIF (sum(clumuha),0) AS mean_profit11,
sum(profit12 * clumuha)/NULLIF (sum(clumuha),0) AS mean_profit12,
sum(profit13 * clumuha)/NULLIF (sum(clumuha),0) AS mean_profit13,
sum(profit14 * clumuha)/NULLIF (sum(clumuha),0) AS mean_profit14,
sum(yield11 * clumuha)/NULLIF (sum(clumuha),0) AS mean_yield11,
sum(yield12 * clumuha)/NULLIF (sum(clumuha),0) AS mean_yield12,
sum(yield13 * clumuha)/NULLIF (sum(clumuha),0) AS mean_yield13,
sum(yield14 * clumuha)/NULLIF (sum(clumuha),0) AS mean_yield14,
480.18 AS soy_price11,
272.97 AS corn_price12,
491.19 AS soy_price13,
145.53 AS corn_price14,
sum(clu_cash_rent11 * clumuha)/NULLIF (sum(clumuha),0) AS mean_cash_rent11,
sum(clu_cash_rent12 * clumuha)/NULLIF (sum(clumuha),0) AS mean_cash_rent12,
sum(clu_cash_rent13 * clumuha)/NULLIF (sum(clumuha),0) AS mean_cash_rent13,
sum(clu_cash_rent14 * clumuha)/NULLIF (sum(clumuha),0) AS mean_cash_rent14,
214*2.471 AS state_mean_cash_rent11,
252*2.471 AS state_mean_cash_rent12,
270*2.471 AS state_mean_cash_rent13,
260*2.471 AS state_mean_cash_rent14,
sum(preharvest_machinery11 * clumuha)/NULLIF (sum(clumuha),0) AS mean_preharv_mach11,
sum(preharvest_machinery12 * clumuha)/NULLIF (sum(clumuha),0) AS mean_preharv_mach12,
sum(preharvest_machinery13 * clumuha)/NULLIF (sum(clumuha),0) AS mean_preharv_mach13,
sum(preharvest_machinery14 * clumuha)/NULLIF (sum(clumuha),0) AS mean_preharv_mach14,
sum(seed_chem11 * clumuha)/NULLIF (sum(clumuha),0) AS mean_seed_chem11,
sum(seed_chem12 * clumuha)/NULLIF (sum(clumuha),0) AS mean_seed_chem12,
sum(seed_chem13 * clumuha)/NULLIF (sum(clumuha),0) AS mean_seed_chem13,
sum(seed_chem14 * clumuha)/NULLIF (sum(clumuha),0) AS mean_seed_chem14,
sum(labor11 * clumuha)/NULLIF (sum(clumuha),0) AS mean_labor11,
sum(labor12 * clumuha)/NULLIF (sum(clumuha),0) AS mean_labor12,
sum(labor13 * clumuha)/NULLIF (sum(clumuha),0) AS mean_labor13,
sum(labor14 * clumuha)/NULLIF (sum(clumuha),0) AS mean_labor14,
sum(n_cost11 * clumuha)/NULLIF (sum(clumuha),0) AS n_cost11,
sum(n_cost12 * clumuha)/NULLIF (sum(clumuha),0) AS n_cost12,
sum(n_cost13 * clumuha)/NULLIF (sum(clumuha),0) AS n_cost13,
sum(n_cost14 * clumuha)/NULLIF (sum(clumuha),0) AS n_cost14,
sum(p_cost11 * clumuha)/NULLIF (sum(clumuha),0) AS p_cost11,
sum(p_cost12 * clumuha)/NULLIF (sum(clumuha),0) AS p_cost12,
sum(p_cost13 * clumuha)/NULLIF (sum(clumuha),0) AS p_cost13,
sum(p_cost14 * clumuha)/NULLIF (sum(clumuha),0) AS p_cost14,
sum(k_cost11 * clumuha)/NULLIF (sum(clumuha),0) AS k_cost11,
sum(k_cost12 * clumuha)/NULLIF (sum(clumuha),0) AS k_cost12,
sum(k_cost13 * clumuha)/NULLIF (sum(clumuha),0) AS k_cost13,
sum(k_cost14 * clumuha)/NULLIF (sum(clumuha),0) AS k_cost14,
sum(harv_machinery11 * clumuha)/NULLIF (sum(clumuha),0) AS harv_mach11,
sum(harv_machinery12 * clumuha)/NULLIF (sum(clumuha),0) AS harv_mach12,
sum(harv_machinery13 * clumuha)/NULLIF (sum(clumuha),0) AS harv_mach13,
sum(harv_machinery14 * clumuha)/NULLIF (sum(clumuha),0) AS harv_mach14
FROM "02_subset_unprofit_15_percent"
WHERE crop11 = 'SB'
AND crop12 = 'CG'
AND crop13 = 'SB'
AND crop14 = 'CG';

-- SB,CG,CG,CG

DROP TABLE IF EXISTS "02_means_sccc";
CREATE TABLE "02_means_sccc"
AS SELECT
sum(clumuha) AS total_ha,
sum(mean_profit_ha * clumuha)/NULLIF (sum(clumuha),0) AS mean_profit_4yrs,
sum(profit11 * clumuha)/NULLIF (sum(clumuha),0) AS mean_profit11,
sum(profit12 * clumuha)/NULLIF (sum(clumuha),0) AS mean_profit12,
sum(profit13 * clumuha)/NULLIF (sum(clumuha),0) AS mean_profit13,
sum(profit14 * clumuha)/NULLIF (sum(clumuha),0) AS mean_profit14,
sum(yield11 * clumuha)/NULLIF (sum(clumuha),0) AS mean_yield11,
sum(yield12 * clumuha)/NULLIF (sum(clumuha),0) AS mean_yield12,
sum(yield13 * clumuha)/NULLIF (sum(clumuha),0) AS mean_yield13,
sum(yield14 * clumuha)/NULLIF (sum(clumuha),0) AS mean_yield14,
480.18 AS soy_price11,
272.97 AS corn_price12,
177.39 AS corn_price13,
145.53 AS corn_price14,
sum(clu_cash_rent11 * clumuha)/NULLIF (sum(clumuha),0) AS mean_cash_rent11,
sum(clu_cash_rent12 * clumuha)/NULLIF (sum(clumuha),0) AS mean_cash_rent12,
sum(clu_cash_rent13 * clumuha)/NULLIF (sum(clumuha),0) AS mean_cash_rent13,
sum(clu_cash_rent14 * clumuha)/NULLIF (sum(clumuha),0) AS mean_cash_rent14,
214*2.471 AS state_mean_cash_rent11,
252*2.471 AS state_mean_cash_rent12,
270*2.471 AS state_mean_cash_rent13,
260*2.471 AS state_mean_cash_rent14,
sum(preharvest_machinery11 * clumuha)/NULLIF (sum(clumuha),0) AS mean_preharv_mach11,
sum(preharvest_machinery12 * clumuha)/NULLIF (sum(clumuha),0) AS mean_preharv_mach12,
sum(preharvest_machinery13 * clumuha)/NULLIF (sum(clumuha),0) AS mean_preharv_mach13,
sum(preharvest_machinery14 * clumuha)/NULLIF (sum(clumuha),0) AS mean_preharv_mach14,
sum(seed_chem11 * clumuha)/NULLIF (sum(clumuha),0) AS mean_seed_chem11,
sum(seed_chem12 * clumuha)/NULLIF (sum(clumuha),0) AS mean_seed_chem12,
sum(seed_chem13 * clumuha)/NULLIF (sum(clumuha),0) AS mean_seed_chem13,
sum(seed_chem14 * clumuha)/NULLIF (sum(clumuha),0) AS mean_seed_chem14,
sum(labor11 * clumuha)/NULLIF (sum(clumuha),0) AS mean_labor11,
sum(labor12 * clumuha)/NULLIF (sum(clumuha),0) AS mean_labor12,
sum(labor13 * clumuha)/NULLIF (sum(clumuha),0) AS mean_labor13,
sum(labor14 * clumuha)/NULLIF (sum(clumuha),0) AS mean_labor14,
sum(n_cost11 * clumuha)/NULLIF (sum(clumuha),0) AS n_cost11,
sum(n_cost12 * clumuha)/NULLIF (sum(clumuha),0) AS n_cost12,
sum(n_cost13 * clumuha)/NULLIF (sum(clumuha),0) AS n_cost13,
sum(n_cost14 * clumuha)/NULLIF (sum(clumuha),0) AS n_cost14,
sum(p_cost11 * clumuha)/NULLIF (sum(clumuha),0) AS p_cost11,
sum(p_cost12 * clumuha)/NULLIF (sum(clumuha),0) AS p_cost12,
sum(p_cost13 * clumuha)/NULLIF (sum(clumuha),0) AS p_cost13,
sum(p_cost14 * clumuha)/NULLIF (sum(clumuha),0) AS p_cost14,
sum(k_cost11 * clumuha)/NULLIF (sum(clumuha),0) AS k_cost11,
sum(k_cost12 * clumuha)/NULLIF (sum(clumuha),0) AS k_cost12,
sum(k_cost13 * clumuha)/NULLIF (sum(clumuha),0) AS k_cost13,
sum(k_cost14 * clumuha)/NULLIF (sum(clumuha),0) AS k_cost14,
sum(harv_machinery11 * clumuha)/NULLIF (sum(clumuha),0) AS harv_mach11,
sum(harv_machinery12 * clumuha)/NULLIF (sum(clumuha),0) AS harv_mach12,
sum(harv_machinery13 * clumuha)/NULLIF (sum(clumuha),0) AS harv_mach13,
sum(harv_machinery14 * clumuha)/NULLIF (sum(clumuha),0) AS harv_mach14
FROM "02_subset_unprofit_15_percent"
WHERE crop11 = 'SB'
AND crop12 = 'CG'
AND crop13 = 'CG'
AND crop14 = 'CG';

-- CG,SB,CG,CG

DROP TABLE IF EXISTS "02_means_cscc";
CREATE TABLE "02_means_cscc"
AS SELECT
sum(clumuha) AS total_ha,
sum(mean_profit_ha * clumuha)/NULLIF (sum(clumuha),0) AS mean_profit_4yrs,
sum(profit11 * clumuha)/NULLIF (sum(clumuha),0) AS mean_profit11,
sum(profit12 * clumuha)/NULLIF (sum(clumuha),0) AS mean_profit12,
sum(profit13 * clumuha)/NULLIF (sum(clumuha),0) AS mean_profit13,
sum(profit14 * clumuha)/NULLIF (sum(clumuha),0) AS mean_profit14,
sum(yield11 * clumuha)/NULLIF (sum(clumuha),0) AS mean_yield11,
sum(yield12 * clumuha)/NULLIF (sum(clumuha),0) AS mean_yield12,
sum(yield13 * clumuha)/NULLIF (sum(clumuha),0) AS mean_yield13,
sum(yield14 * clumuha)/NULLIF (sum(clumuha),0) AS mean_yield14,
249.67 AS corn_price11,
533.77 AS soy_price12,
177.39 AS corn_price13,
145.53 AS corn_price14,
sum(clu_cash_rent11 * clumuha)/NULLIF (sum(clumuha),0) AS mean_cash_rent11,
sum(clu_cash_rent12 * clumuha)/NULLIF (sum(clumuha),0) AS mean_cash_rent12,
sum(clu_cash_rent13 * clumuha)/NULLIF (sum(clumuha),0) AS mean_cash_rent13,
sum(clu_cash_rent14 * clumuha)/NULLIF (sum(clumuha),0) AS mean_cash_rent14,
214*2.471 AS state_mean_cash_rent11,
252*2.471 AS state_mean_cash_rent12,
270*2.471 AS state_mean_cash_rent13,
260*2.471 AS state_mean_cash_rent14,
sum(preharvest_machinery11 * clumuha)/NULLIF (sum(clumuha),0) AS mean_preharv_mach11,
sum(preharvest_machinery12 * clumuha)/NULLIF (sum(clumuha),0) AS mean_preharv_mach12,
sum(preharvest_machinery13 * clumuha)/NULLIF (sum(clumuha),0) AS mean_preharv_mach13,
sum(preharvest_machinery14 * clumuha)/NULLIF (sum(clumuha),0) AS mean_preharv_mach14,
sum(seed_chem11 * clumuha)/NULLIF (sum(clumuha),0) AS mean_seed_chem11,
sum(seed_chem12 * clumuha)/NULLIF (sum(clumuha),0) AS mean_seed_chem12,
sum(seed_chem13 * clumuha)/NULLIF (sum(clumuha),0) AS mean_seed_chem13,
sum(seed_chem14 * clumuha)/NULLIF (sum(clumuha),0) AS mean_seed_chem14,
sum(labor11 * clumuha)/NULLIF (sum(clumuha),0) AS mean_labor11,
sum(labor12 * clumuha)/NULLIF (sum(clumuha),0) AS mean_labor12,
sum(labor13 * clumuha)/NULLIF (sum(clumuha),0) AS mean_labor13,
sum(labor14 * clumuha)/NULLIF (sum(clumuha),0) AS mean_labor14,
sum(n_cost11 * clumuha)/NULLIF (sum(clumuha),0) AS n_cost11,
sum(n_cost12 * clumuha)/NULLIF (sum(clumuha),0) AS n_cost12,
sum(n_cost13 * clumuha)/NULLIF (sum(clumuha),0) AS n_cost13,
sum(n_cost14 * clumuha)/NULLIF (sum(clumuha),0) AS n_cost14,
sum(p_cost11 * clumuha)/NULLIF (sum(clumuha),0) AS p_cost11,
sum(p_cost12 * clumuha)/NULLIF (sum(clumuha),0) AS p_cost12,
sum(p_cost13 * clumuha)/NULLIF (sum(clumuha),0) AS p_cost13,
sum(p_cost14 * clumuha)/NULLIF (sum(clumuha),0) AS p_cost14,
sum(k_cost11 * clumuha)/NULLIF (sum(clumuha),0) AS k_cost11,
sum(k_cost12 * clumuha)/NULLIF (sum(clumuha),0) AS k_cost12,
sum(k_cost13 * clumuha)/NULLIF (sum(clumuha),0) AS k_cost13,
sum(k_cost14 * clumuha)/NULLIF (sum(clumuha),0) AS k_cost14,
sum(harv_machinery11 * clumuha)/NULLIF (sum(clumuha),0) AS harv_mach11,
sum(harv_machinery12 * clumuha)/NULLIF (sum(clumuha),0) AS harv_mach12,
sum(harv_machinery13 * clumuha)/NULLIF (sum(clumuha),0) AS harv_mach13,
sum(harv_machinery14 * clumuha)/NULLIF (sum(clumuha),0) AS harv_mach14
FROM "02_subset_unprofit_15_percent"
WHERE crop11 = 'CG'
AND crop12 = 'SB'
AND crop13 = 'CG'
AND crop14 = 'CG';



