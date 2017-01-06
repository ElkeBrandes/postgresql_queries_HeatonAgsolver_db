-- this query is using the 2011 - 2014 profitability data set
-- analysis was done for the poster at the EUBCE 2016 in Amsterdam
-- the aim was to get a generalized idea of net benefits of converting row crop to switchgrass, averaged over the state of Iowa.
-- filter out polygons with each year's profit < 0:
/*
DROP TABLE IF EXISTS "02_subset_unprofit_all_years";
CREATE TABLE "02_subset_unprofit_all_years"
AS SELECT 
*
FROM "02_clumu_cgsb_profit_switch2"
WHERE profit11 < 0 AND profit12 < 0 AND profit13 < 0 AND profit14 < 0;

-- check total area of the subset:
SELECT sum(clumuha) FROM "02_subset_unprofit_all_years";
--240469.36
SELECT sum(clumuha) FROM "02_subset_unprofit_all_years" WHERE crop11 = 'CG' AND crop12 = 'CG' AND crop13 = 'CG' AND crop14 = 'CG';
-- 23935.38
SELECT sum(clumuha) FROM "02_subset_unprofit_all_years" WHERE crop11 = 'CG' AND crop12 = 'SB' AND crop13 = 'CG' AND crop14 = 'SB';
-- 62581.32
SELECT sum(clumuha) FROM "02_subset_unprofit_all_years" WHERE crop11 = 'SB' AND crop12 = 'CG' AND crop13 = 'SB' AND crop14 = 'CG';
-- 83774.36
SELECT sum(clumuha) FROM "02_subset_unprofit_all_years" WHERE crop11 = 'SB' AND crop12 = 'CG' AND crop13 = 'CG' AND crop14 = 'CG';
-- 9253.35
SELECT sum(clumuha) FROM "02_subset_unprofit_all_years" WHERE crop11 = 'CG' AND crop12 = 'SB' AND crop13 = 'CG' AND crop14 = 'CG';
-- 10103.85
SELECT sum(clumuha) FROM "02_subset_unprofit_all_years" WHERE crop11 = 'CG' AND crop12 = 'CG' AND crop13 = 'SB' AND crop14 = 'CG';
-- 15115.30
SELECT sum(clumuha) FROM "02_subset_unprofit_all_years" WHERE crop11 = 'CG' AND crop12 = 'CG' AND crop13 = 'CG' AND crop14 = 'SB';
-- 5784.31
SELECT sum(clumuha) FROM "02_subset_unprofit_all_years" WHERE crop11 = 'SB' AND crop12 = 'CG' AND crop13 = 'CG' AND crop14 = 'SB';
-- 7240.82
SELECT sum(clumuha) FROM "02_subset_unprofit_all_years" WHERE crop11 = 'CG' AND crop12 = 'CG' AND crop13 = 'SB' AND crop14 = 'SB';
-- 807.88

SELECT sum(clumuha) FROM "02_subset_unprofit_all_years" WHERE crop11 = 'CG' AND crop12 = 'SB' AND crop13 = 'SB' AND crop14 = 'SB';
-- 2355.23
SELECT sum(clumuha) FROM "02_subset_unprofit_all_years" WHERE crop11 = 'SB' AND crop12 = 'SB' AND crop13 = 'CG' AND crop14 = 'CG';
-- 993.61
*/

-- calculate area weighted means of each of the costs/revenues for each rotation

-- CG,CG,CG,CG

DROP TABLE IF EXISTS "02_means_cccc_2";
CREATE TABLE "02_means_cccc_2"
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
FROM "02_subset_unprofit_all_years"
WHERE crop11 = 'CG'
AND crop12 = 'CG'
AND crop13 = 'CG'
AND crop14 = 'CG';

-- CG,SB,CG,SB

DROP TABLE IF EXISTS "02_means_cscs_2";
CREATE TABLE "02_means_cscs_2"
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
FROM "02_subset_unprofit_all_years"
WHERE crop11 = 'CG'
AND crop12 = 'SB'
AND crop13 = 'CG'
AND crop14 = 'SB';

-- SB,CG,SB,CG

DROP TABLE IF EXISTS "02_means_scsc_2";
CREATE TABLE "02_means_scsc_2"
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
FROM "02_subset_unprofit_all_years"
WHERE crop11 = 'SB'
AND crop12 = 'CG'
AND crop13 = 'SB'
AND crop14 = 'CG';

-- CG,SB,CG,CG

DROP TABLE IF EXISTS "02_means_cscc_2";
CREATE TABLE "02_means_cscc_2"
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
FROM "02_subset_unprofit_all_years"
WHERE crop11 = 'CG'
AND crop12 = 'SB'
AND crop13 = 'CG'
AND crop14 = 'CG';

-- CG,CG,SB,CG

DROP TABLE IF EXISTS "02_means_ccsc_2";
CREATE TABLE "02_means_ccsc_2"
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
FROM "02_subset_unprofit_all_years"
WHERE crop11 = 'CG'
AND crop12 = 'CG'
AND crop13 = 'SB'
AND crop14 = 'CG';

