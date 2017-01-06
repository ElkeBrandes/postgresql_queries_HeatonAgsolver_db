-- from the two model runs: cg sb 2012 - 2015 and swg 2006-2015, compare the changes in N loss (= NO3 leaching + NH3 volatilization)

--join:
-- cluid_mukey, mukey, clumuha, and mean profit from table "01_clumu_cgsb_profit_2012_2015_mean"
-- ave no3 leaching + ave nh3 volatilization of CGSB (converted to kg/ha) from isu_cgsb_clumu_proc
-- ave no3 leaching + ave nh3 volatilization  of swg (converted to kg/ha) from isu_swg_results_proc
-- convert n loss to metric units

/*
DROP TABLE IF EXISTS "05_dndc_clumu_cgsb_swg_n_loss";
CREATE TABLE "05_dndc_clumu_cgsb_swg_n_loss"
AS WITH 
cgsb_table AS(
SELECT
t1.fips_crent AS fips,
t1.cluid_mukey,
t2.mukey,
t1.clumuha,
t1.mean_profit_ha,
(t2.ave_no3_leach + t2.ave_nh3_vol) * 0.4536 * 2.471 AS ave_n_loss_ha_cgsb
FROM "01_clumu_cgsb_profit_2012_2015_mean" as t1
JOIN isu_cgsb_clumu_proc as t2 on t1.cluid_mukey = t2.cluid_mukey
),
swg_7500_table AS(
SELECT
mukey,
(ave_no3_leach + ave_nh3_vol) * 0.4536 * 2.471 AS ave_n_loss_ha_swg_7500
FROM isu_swg_results_proc WHERE yld_tag = 7500
),
swg_10000_table AS(
SELECT
mukey,
(ave_no3_leach + ave_nh3_vol) * 0.4536 * 2.471 AS ave_n_loss_ha_swg_10000
FROM isu_swg_results_proc WHERE yld_tag = 10000
),
swg_12500_table AS(
SELECT
mukey,
(ave_no3_leach + ave_nh3_vol) * 0.4536 * 2.471 AS ave_n_loss_ha_swg_12500
FROM isu_swg_results_proc WHERE yld_tag = 12500
),
swg_table1 AS(
SELECT
t1.*,
t2.ave_n_loss_ha_swg_7500
FROM cgsb_table AS t1
LEFT JOIN swg_7500_table AS t2 ON t1.mukey = t2.mukey
),
swg_table2 AS (
SELECT
t1.*,
t2.ave_n_loss_ha_swg_10000
FROM swg_table1 AS t1
LEFT JOIN swg_10000_table AS t2 ON t1.mukey = t2.mukey
)
SELECT 
t1.*,
t2.ave_n_loss_ha_swg_12500
FROM swg_table2 as t1
JOIN swg_12500_table as t2 on t1.mukey = t2.mukey;
*/

-- add a column to enter the n loss values for the profit and water quality optimized scenario:
-- ave_n_loss_pwo (all areas where mean profit < -150 and n loss >60 goes into swg)

/*
ALTER TABLE "05_dndc_clumu_cgsb_swg_n_loss"
ADD COLUMN ave_n_loss_7500 NUMERIC;
ALTER TABLE "05_dndc_clumu_cgsb_swg_n_loss"
ADD COLUMN ave_n_loss_10000 NUMERIC;
ALTER TABLE "05_dndc_clumu_cgsb_swg_n_loss"
ADD COLUMN ave_n_loss_12500 NUMERIC;


UPDATE "05_dndc_clumu_cgsb_swg_n_loss"
SET 
ave_n_loss_7500 = CASE WHEN mean_profit_ha < -150 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_7500 ELSE ave_n_loss_ha_cgsb END,
ave_n_loss_10000 = CASE WHEN mean_profit_ha < -150 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_10000 ELSE ave_n_loss_ha_cgsb END,
ave_n_loss_12500 = CASE WHEN mean_profit_ha < -150 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_12500 ELSE ave_n_loss_ha_cgsb END;


-- test for errors in the data set:
select sum(clumuha) from "05_dndc_clumu_cgsb_swg_n_loss" where ave_n_loss_ha_cgsb is null;
-- result: 22866 ha

select sum(clumuha) from "05_dndc_clumu_cgsb_swg_n_loss" where mean_profit_ha is not null;
-- result: 9370307 ha
select sum(clumuha) from "05_dndc_clumu_cgsb_swg_n_loss";
-- result: 9374362 ha
-- test for area below/above cut offs:
select sum(clumuha) from "05_dndc_clumu_cgsb_swg_n_loss" where mean_profit_ha < -150 and ave_n_loss_ha_cgsb >=60;
-- 994142
*/

-- take sums for Iowa (in Mg) for the BAU and different yield scenarios:
/*
DROP TABLE IF EXISTS "05_dndc_n_loss_sums_iowa_scenarios";
CREATE TABLE "05_dndc_n_loss_sums_iowa_scenarios"
AS SELECT
(sum(ave_n_loss_ha_cgsb * clumuha)) / 1000  as sum_ave_n_loss_cgsb,
(sum(ave_n_loss_7500 * clumuha)) / 1000  as sum_ave_n_loss_7500,
(sum(ave_n_loss_10000 * clumuha)) / 1000  as sum_ave_n_loss_10000,
(sum(ave_n_loss_12500 * clumuha)) / 1000  as sum_ave_n_loss_12500
FROM "05_dndc_clumu_cgsb_swg_n_loss";
*/
-- calculate change in N loss per clumu in the medium yielding scenario, when all areas losing > 150 US$/ha and > 60 kg N / ha are 
-- converted to switchgrass

-- create new column and calculate the difference in N loss
-- change is negative when a loss reduction occurs. 

ALTER TABLE "05_dndc_clumu_cgsb_swg_n_loss"
ADD COLUMN ave_n_loss_change_10000 NUMERIC;
ALTER TABLE "05_dndc_clumu_cgsb_swg_n_loss"
ADD COLUMN ave_n_loss_change_perc_10000 NUMERIC;

UPDATE "05_dndc_clumu_cgsb_swg_n_loss"
SET 
ave_n_loss_change_10000 = ave_n_loss_10000 - ave_n_loss_ha_cgsb,
ave_n_loss_change_perc_10000 = round(100*(ave_n_loss_10000 - ave_n_loss_ha_cgsb)/ave_n_loss_ha_cgsb,1);



