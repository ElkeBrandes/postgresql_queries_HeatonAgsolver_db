
-- distribution of NO3 leaching in the state, on a CLU-mukey level 
-- calculations on N loss are below

-- the table "05_dndc_clumu_cgsb_swg" includes clumuha and NO3 leaching for corn/bean and swg. 
--add two columns with the rounded values 

/*
ALTER TABLE "05_dndc_clumu_cgsb_swg"
ADD COLUMN ave_no3_leach_cgsb_round NUMERIC,
ADD COLUMN ave_no3_leach_swg_7500_round NUMERIC,
ADD COLUMN ave_no3_leach_swg_10000_round NUMERIC,
ADD COLUMN ave_no3_leach_swg_12500_round NUMERIC;

UPDATE "05_dndc_clumu_cgsb_swg"
SET 
ave_no3_leach_cgsb_round = ROUND(ave_no3_leach_ha_cgsb,0),
ave_no3_leach_swg_7500_round = ROUND(ave_no3_leach_ha_swg_7500,0),
ave_no3_leach_swg_10000_round = ROUND(ave_no3_leach_ha_swg_10000,0),
ave_no3_leach_swg_12500_round = ROUND(ave_no3_leach_ha_swg_12500,0);

-- aggregate over the same leaching values



DROP TABLE IF EXISTS "06_cgsb_ave_no3_leach_rounded_aggr";
CREATE TABLE "06_cgsb_ave_no3_leach_rounded_aggr"
AS SELECT
ave_no3_leach_cgsb_round,
sum(clumuha) AS area_ha
FROM "05_dndc_clumu_cgsb_swg"
GROUP BY ave_no3_leach_cgsb_round;


DROP TABLE IF EXISTS "06_swg_7500_ave_no3_leach_rounded_aggr";
CREATE TABLE "06_swg_7500_ave_no3_leach_rounded_aggr"
AS SELECT
ave_no3_leach_swg_7500_round,
sum(clumuha) AS area_ha
FROM "05_dndc_clumu_cgsb_swg"
GROUP BY ave_no3_leach_swg_7500_round;

DROP TABLE IF EXISTS "06_swg_10000_ave_no3_leach_rounded_aggr";
CREATE TABLE "06_swg_10000_ave_no3_leach_rounded_aggr"
AS SELECT
ave_no3_leach_swg_10000_round,
sum(clumuha) AS area_ha
FROM "05_dndc_clumu_cgsb_swg"
GROUP BY ave_no3_leach_swg_10000_round;

DROP TABLE IF EXISTS "06_swg_12500_ave_no3_leach_rounded_aggr";
CREATE TABLE "06_swg_12500_ave_no3_leach_rounded_aggr"
AS SELECT
ave_no3_leach_swg_12500_round,
sum(clumuha) AS area_ha
FROM "05_dndc_clumu_cgsb_swg"
GROUP BY ave_no3_leach_swg_12500_round;
*/
-- profit optimized scenario:

-- distribution of no3 leaching on CGSB fields of unprofitable areas:
-- create a new column and filter for those areas
/*
ALTER TABLE "05_dndc_clumu_iowa_cgsb_swg_2011_2014"
ADD COLUMN ave_no3_leach_cs_round_unprofit NUMERIC;
UPDATE "05_dndc_clumu_iowa_cgsb_swg_2011_2014"
SET ave_no3_leach_cs_round_unprofit = ave_no3_leach_cs_round WHERE mean_profit_ha < 0;

-- aggregate to the same leaching values for the data subset

DROP TABLE IF EXISTS "06_cgsb_ave_no3_leach_rounded_aggr_unprofit";
CREATE TABLE "06_cgsb_ave_no3_leach_rounded_aggr_unprofit"
AS SELECT
ave_no3_leach_cs_round_unprofit,
sum(clumuha) AS area_ha
FROM "05_dndc_clumu_iowa_cgsb_swg_2011_2014"
GROUP BY ave_no3_leach_cs_round_unprofit;

-- distribution of no3 leaching on swg fields of unprofitable areas:
-- create a new column and filter for those areas

ALTER TABLE "05_dndc_clumu_iowa_cgsb_swg_2011_2014"
ADD COLUMN ave_no3_leach_swg_round_unprofit NUMERIC;
UPDATE "05_dndc_clumu_iowa_cgsb_swg_2011_2014"
SET ave_no3_leach_swg_round_unprofit = ave_no3_leach_swg_round WHERE mean_profit_ha < 0;

-- aggregate to the same leaching values for the data subset

DROP TABLE IF EXISTS "06_swg_ave_no3_leach_rounded_aggr_unprofit";
CREATE TABLE "06_swg_ave_no3_leach_rounded_aggr_unprofit"
AS SELECT
ave_no3_leach_swg_round_unprofit,
sum(clumuha) AS area_ha
FROM "05_dndc_clumu_iowa_cgsb_swg_2011_2014"
GROUP BY ave_no3_leach_swg_round_unprofit;
*/
-- water quality optimized scenario:

-- distribution of no3 leaching on CGSB fields of unprofitable areas:
-- create a new column and filter for those areas
/*
ALTER TABLE "05_dndc_clumu_iowa_cgsb_swg_2011_2014"
ADD COLUMN ave_no3_leach_cs_round_highleach NUMERIC;
UPDATE "05_dndc_clumu_iowa_cgsb_swg_2011_2014"
SET ave_no3_leach_cs_round_highleach = ave_no3_leach_cs_round WHERE ave_no3_leach_cs > 62;

-- aggregate to the same leaching values for the data subset

DROP TABLE IF EXISTS "06_cgsb_ave_no3_leach_rounded_aggr_highleach";
CREATE TABLE "06_cgsb_ave_no3_leach_rounded_aggr_highleach"
AS SELECT
ave_no3_leach_cs_round_highleach,
sum(clumuha) AS area_ha
FROM "05_dndc_clumu_iowa_cgsb_swg_2011_2014"
GROUP BY ave_no3_leach_cs_round_highleach;
*/
-- distribution of no3 leaching on swg fields of unprofitable areas:
-- create a new column and filter for those areas
/*
ALTER TABLE "05_dndc_clumu_iowa_cgsb_swg_2011_2014"
ADD COLUMN ave_no3_leach_swg_round_highleach NUMERIC;
UPDATE "05_dndc_clumu_iowa_cgsb_swg_2011_2014"
SET ave_no3_leach_swg_round_hichleach = ave_no3_leach_swg_round WHERE mean_profit_ha < 0;

-- aggregate to the same leaching values for the data subset

DROP TABLE IF EXISTS "06_swg_ave_no3_leach_rounded_aggr_unprofit";
CREATE TABLE "06_swg_ave_no3_leach_rounded_aggr_unprofit"
AS SELECT
ave_no3_leach_swg_round_unprofit,
sum(clumuha) AS area_ha
FROM "05_dndc_clumu_iowa_cgsb_swg_2011_2014"
GROUP BY ave_no3_leach_swg_round_unprofit;
*/

-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------

-- distribution of N loss in the state, on a CLU-mukey level

-- the table "05_dndc_clumu_cgsb_swg_n_loss" includes clumuha and N loss for corn/bean and swg. 
--add four columns with the rounded values 


ALTER TABLE "05_dndc_clumu_cgsb_swg_n_loss"
ADD COLUMN ave_n_loss_cgsb_round NUMERIC,
ADD COLUMN ave_n_loss_swg_7500_round NUMERIC,
ADD COLUMN ave_n_loss_swg_10000_round NUMERIC,
ADD COLUMN ave_n_loss_swg_12500_round NUMERIC;

UPDATE "05_dndc_clumu_cgsb_swg_n_loss"
SET 
ave_n_loss_cgsb_round = ROUND(ave_n_loss_ha_cgsb,0),
ave_n_loss_swg_7500_round = ROUND(ave_n_loss_ha_swg_7500,0),
ave_n_loss_swg_10000_round = ROUND(ave_n_loss_ha_swg_10000,0),
ave_n_loss_swg_12500_round = ROUND(ave_n_loss_ha_swg_12500,0);

-- aggregate over the same leaching values

DROP TABLE IF EXISTS "06_cgsb_ave_n_loss_rounded_aggr";
CREATE TABLE "06_cgsb_ave_n_loss_rounded_aggr"
AS SELECT
ave_n_loss_cgsb_round,
sum(clumuha) AS area_ha
FROM "05_dndc_clumu_cgsb_swg_n_loss"
GROUP BY ave_n_loss_cgsb_round;


DROP TABLE IF EXISTS "06_swg_7500_ave_n_loss_rounded_aggr";
CREATE TABLE "06_swg_7500_ave_n_loss_rounded_aggr"
AS SELECT
ave_n_loss_swg_7500_round,
sum(clumuha) AS area_ha
FROM "05_dndc_clumu_cgsb_swg_n_loss"
GROUP BY ave_n_loss_swg_7500_round;

DROP TABLE IF EXISTS "06_swg_10000_ave_n_loss_rounded_aggr";
CREATE TABLE "06_swg_10000_ave_n_loss_rounded_aggr"
AS SELECT
ave_n_loss_swg_10000_round,
sum(clumuha) AS area_ha
FROM "05_dndc_clumu_cgsb_swg_n_loss"
GROUP BY ave_n_loss_swg_10000_round;

DROP TABLE IF EXISTS "06_swg_12500_ave_n_loss_rounded_aggr";
CREATE TABLE "06_swg_12500_ave_n_loss_rounded_aggr"
AS SELECT
ave_n_loss_swg_12500_round,
sum(clumuha) AS area_ha
FROM "05_dndc_clumu_cgsb_swg_n_loss"
GROUP BY ave_n_loss_swg_12500_round;

-- profit optimized scenario:

-- distribution of no3 leaching on CGSB fields of unprofitable areas:
-- create a new column and filter for those areas
/*
ALTER TABLE "05_dndc_clumu_iowa_cgsb_swg_2011_2014"
ADD COLUMN ave_no3_leach_cs_round_unprofit NUMERIC;
UPDATE "05_dndc_clumu_iowa_cgsb_swg_2011_2014"
SET ave_no3_leach_cs_round_unprofit = ave_no3_leach_cs_round WHERE mean_profit_ha < 0;

-- aggregate to the same leaching values for the data subset

DROP TABLE IF EXISTS "06_cgsb_ave_no3_leach_rounded_aggr_unprofit";
CREATE TABLE "06_cgsb_ave_no3_leach_rounded_aggr_unprofit"
AS SELECT
ave_no3_leach_cs_round_unprofit,
sum(clumuha) AS area_ha
FROM "05_dndc_clumu_iowa_cgsb_swg_2011_2014"
GROUP BY ave_no3_leach_cs_round_unprofit;



-- distribution of n loss on swg fields of unprofitable areas:
-- create a new column and filter for those areas

ALTER TABLE "05_dndc_clumu_iowa_cgsb_swg_2011_2014"
ADD COLUMN ave_no3_leach_swg_round_unprofit NUMERIC;
UPDATE "05_dndc_clumu_iowa_cgsb_swg_2011_2014"
SET ave_no3_leach_swg_round_unprofit = ave_no3_leach_swg_round WHERE mean_profit_ha < 0;

-- aggregate to the same leaching values for the data subset

DROP TABLE IF EXISTS "06_swg_ave_no3_leach_rounded_aggr_unprofit";
CREATE TABLE "06_swg_ave_no3_leach_rounded_aggr_unprofit"
AS SELECT
ave_no3_leach_swg_round_unprofit,
sum(clumuha) AS area_ha
FROM "05_dndc_clumu_iowa_cgsb_swg_2011_2014"
GROUP BY ave_no3_leach_swg_round_unprofit;
*/
-- water quality optimized scenario:

-- distribution of no3 leaching on CGSB fields of unprofitable areas:
-- create a new column and filter for those areas
/*
ALTER TABLE "05_dndc_clumu_iowa_cgsb_swg_2011_2014"
ADD COLUMN ave_no3_leach_cs_round_highleach NUMERIC;
UPDATE "05_dndc_clumu_iowa_cgsb_swg_2011_2014"
SET ave_no3_leach_cs_round_highleach = ave_no3_leach_cs_round WHERE ave_no3_leach_cs > 62;

-- aggregate to the same leaching values for the data subset

DROP TABLE IF EXISTS "06_cgsb_ave_no3_leach_rounded_aggr_highleach";
CREATE TABLE "06_cgsb_ave_no3_leach_rounded_aggr_highleach"
AS SELECT
ave_no3_leach_cs_round_highleach,
sum(clumuha) AS area_ha
FROM "05_dndc_clumu_iowa_cgsb_swg_2011_2014"
GROUP BY ave_no3_leach_cs_round_highleach;
*/
-- distribution of no3 leaching on swg fields of unprofitable areas:
-- create a new column and filter for those areas
/*
ALTER TABLE "05_dndc_clumu_iowa_cgsb_swg_2011_2014"
ADD COLUMN ave_no3_leach_swg_round_highleach NUMERIC;
UPDATE "05_dndc_clumu_iowa_cgsb_swg_2011_2014"
SET ave_no3_leach_swg_round_hichleach = ave_no3_leach_swg_round WHERE mean_profit_ha < 0;

-- aggregate to the same leaching values for the data subset

DROP TABLE IF EXISTS "06_swg_ave_no3_leach_rounded_aggr_unprofit";
CREATE TABLE "06_swg_ave_no3_leach_rounded_aggr_unprofit"
AS SELECT
ave_no3_leach_swg_round_unprofit,
sum(clumuha) AS area_ha
FROM "05_dndc_clumu_iowa_cgsb_swg_2011_2014"
GROUP BY ave_no3_leach_swg_round_unprofit;

*/