-- create new columns in table 05_dndc_clumu_cgsb_swg for each profitability cut off and each scenario

ALTER TABLE "05_dndc_clumu_cgsb_swg_n_loss"
ADD COLUMN ave_n_loss_7500_1 NUMERIC;
ALTER TABLE "05_dndc_clumu_cgsb_swg_n_loss"
ADD COLUMN ave_n_loss_7500_2 NUMERIC;
ALTER TABLE "05_dndc_clumu_cgsb_swg_n_loss"
ADD COLUMN ave_n_loss_7500_3 NUMERIC;
ALTER TABLE "05_dndc_clumu_cgsb_swg_n_loss"
ADD COLUMN ave_n_loss_7500_4 NUMERIC;
ALTER TABLE "05_dndc_clumu_cgsb_swg_n_loss"
ADD COLUMN ave_n_loss_7500_5 NUMERIC;
ALTER TABLE "05_dndc_clumu_cgsb_swg_n_loss"
ADD COLUMN ave_n_loss_7500_6 NUMERIC;
ALTER TABLE "05_dndc_clumu_cgsb_swg_n_loss"
ADD COLUMN ave_n_loss_7500_7 NUMERIC;
ALTER TABLE "05_dndc_clumu_cgsb_swg_n_loss"
ADD COLUMN ave_n_loss_7500_8 NUMERIC;
ALTER TABLE "05_dndc_clumu_cgsb_swg_n_loss"
ADD COLUMN ave_n_loss_7500_9 NUMERIC;
ALTER TABLE "05_dndc_clumu_cgsb_swg_n_loss"
ADD COLUMN ave_n_loss_7500_10 NUMERIC;
ALTER TABLE "05_dndc_clumu_cgsb_swg_n_loss"
ADD COLUMN ave_n_loss_7500_11 NUMERIC;
ALTER TABLE "05_dndc_clumu_cgsb_swg_n_loss"
ADD COLUMN ave_n_loss_10000_1 NUMERIC;
ALTER TABLE "05_dndc_clumu_cgsb_swg_n_loss"
ADD COLUMN ave_n_loss_10000_2 NUMERIC;
ALTER TABLE "05_dndc_clumu_cgsb_swg_n_loss"
ADD COLUMN ave_n_loss_10000_3 NUMERIC;
ALTER TABLE "05_dndc_clumu_cgsb_swg_n_loss"
ADD COLUMN ave_n_loss_10000_4 NUMERIC;
ALTER TABLE "05_dndc_clumu_cgsb_swg_n_loss"
ADD COLUMN ave_n_loss_10000_5 NUMERIC;
ALTER TABLE "05_dndc_clumu_cgsb_swg_n_loss"
ADD COLUMN ave_n_loss_10000_6 NUMERIC;
ALTER TABLE "05_dndc_clumu_cgsb_swg_n_loss"
ADD COLUMN ave_n_loss_10000_7 NUMERIC;
ALTER TABLE "05_dndc_clumu_cgsb_swg_n_loss"
ADD COLUMN ave_n_loss_10000_8 NUMERIC;
ALTER TABLE "05_dndc_clumu_cgsb_swg_n_loss"
ADD COLUMN ave_n_loss_10000_9 NUMERIC;
ALTER TABLE "05_dndc_clumu_cgsb_swg_n_loss"
ADD COLUMN ave_n_loss_10000_10 NUMERIC;
ALTER TABLE "05_dndc_clumu_cgsb_swg_n_loss"
ADD COLUMN ave_n_loss_10000_11 NUMERIC;
ALTER TABLE "05_dndc_clumu_cgsb_swg_n_loss"
ADD COLUMN ave_n_loss_12500_1 NUMERIC;
ALTER TABLE "05_dndc_clumu_cgsb_swg_n_loss"
ADD COLUMN ave_n_loss_12500_2 NUMERIC;
ALTER TABLE "05_dndc_clumu_cgsb_swg_n_loss"
ADD COLUMN ave_n_loss_12500_3 NUMERIC;
ALTER TABLE "05_dndc_clumu_cgsb_swg_n_loss"
ADD COLUMN ave_n_loss_12500_4 NUMERIC;
ALTER TABLE "05_dndc_clumu_cgsb_swg_n_loss"
ADD COLUMN ave_n_loss_12500_5 NUMERIC;
ALTER TABLE "05_dndc_clumu_cgsb_swg_n_loss"
ADD COLUMN ave_n_loss_12500_6 NUMERIC;
ALTER TABLE "05_dndc_clumu_cgsb_swg_n_loss"
ADD COLUMN ave_n_loss_12500_7 NUMERIC;
ALTER TABLE "05_dndc_clumu_cgsb_swg_n_loss"
ADD COLUMN ave_n_loss_12500_8 NUMERIC;
ALTER TABLE "05_dndc_clumu_cgsb_swg_n_loss"
ADD COLUMN ave_n_loss_12500_9 NUMERIC;
ALTER TABLE "05_dndc_clumu_cgsb_swg_n_loss"
ADD COLUMN ave_n_loss_12500_10 NUMERIC;
ALTER TABLE "05_dndc_clumu_cgsb_swg_n_loss"
ADD COLUMN ave_n_loss_12500_11 NUMERIC;

-- populate the columns with data according to the scenarios

UPDATE "05_dndc_clumu_cgsb_swg_n_loss"
SET 
ave_n_loss_7500_1 = CASE WHEN mean_profit_ha < -500 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_7500  ELSE ave_n_loss_ha_cgsb END,
ave_n_loss_7500_2 = CASE WHEN mean_profit_ha < -400 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_7500  ELSE ave_n_loss_ha_cgsb END,
ave_n_loss_7500_3 = CASE WHEN mean_profit_ha < -300 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_7500  ELSE ave_n_loss_ha_cgsb END,
ave_n_loss_7500_4 = CASE WHEN mean_profit_ha < -200 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_7500  ELSE ave_n_loss_ha_cgsb END,
ave_n_loss_7500_5 = CASE WHEN mean_profit_ha < -150 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_7500  ELSE ave_n_loss_ha_cgsb END,
ave_n_loss_7500_6 = CASE WHEN mean_profit_ha < -100 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_7500  ELSE ave_n_loss_ha_cgsb END,
ave_n_loss_7500_7 = CASE WHEN mean_profit_ha < -50 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_7500  ELSE ave_n_loss_ha_cgsb END,
ave_n_loss_7500_8 = CASE WHEN mean_profit_ha < 0 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_7500  ELSE ave_n_loss_ha_cgsb END,
ave_n_loss_7500_9 = CASE WHEN mean_profit_ha < 50 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_7500  ELSE ave_n_loss_ha_cgsb END,
ave_n_loss_7500_10 = CASE WHEN mean_profit_ha < 100 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_7500  ELSE ave_n_loss_ha_cgsb END,
ave_n_loss_7500_11 = CASE WHEN mean_profit_ha < 150 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_7500  ELSE ave_n_loss_ha_cgsb END,
ave_n_loss_10000_1 = CASE WHEN mean_profit_ha < -500 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_10000  ELSE ave_n_loss_ha_cgsb END,
ave_n_loss_10000_2 = CASE WHEN mean_profit_ha < -400 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_10000  ELSE ave_n_loss_ha_cgsb END,
ave_n_loss_10000_3 = CASE WHEN mean_profit_ha < -300 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_10000  ELSE ave_n_loss_ha_cgsb END,
ave_n_loss_10000_4 = CASE WHEN mean_profit_ha < -200 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_10000  ELSE ave_n_loss_ha_cgsb END,
ave_n_loss_10000_5 = CASE WHEN mean_profit_ha < -150 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_10000  ELSE ave_n_loss_ha_cgsb END,
ave_n_loss_10000_6 = CASE WHEN mean_profit_ha < -100 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_10000  ELSE ave_n_loss_ha_cgsb END,
ave_n_loss_10000_7 = CASE WHEN mean_profit_ha < -50 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_10000  ELSE ave_n_loss_ha_cgsb END,
ave_n_loss_10000_8 = CASE WHEN mean_profit_ha < 0 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_10000  ELSE ave_n_loss_ha_cgsb END,
ave_n_loss_10000_9 = CASE WHEN mean_profit_ha < 50 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_10000  ELSE ave_n_loss_ha_cgsb END,
ave_n_loss_10000_10 = CASE WHEN mean_profit_ha < 100 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_10000  ELSE ave_n_loss_ha_cgsb END,
ave_n_loss_10000_11 = CASE WHEN mean_profit_ha < 150 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_10000  ELSE ave_n_loss_ha_cgsb END,
ave_n_loss_12500_1 = CASE WHEN mean_profit_ha < -500 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_12500  ELSE ave_n_loss_ha_cgsb END,
ave_n_loss_12500_2 = CASE WHEN mean_profit_ha < -400 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_12500  ELSE ave_n_loss_ha_cgsb END,
ave_n_loss_12500_3 = CASE WHEN mean_profit_ha < -300 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_12500  ELSE ave_n_loss_ha_cgsb END,
ave_n_loss_12500_4 = CASE WHEN mean_profit_ha < -200 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_12500  ELSE ave_n_loss_ha_cgsb END,
ave_n_loss_12500_5 = CASE WHEN mean_profit_ha < -150 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_12500  ELSE ave_n_loss_ha_cgsb END,
ave_n_loss_12500_6 = CASE WHEN mean_profit_ha < -100 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_12500  ELSE ave_n_loss_ha_cgsb END,
ave_n_loss_12500_7 = CASE WHEN mean_profit_ha < -50 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_12500  ELSE ave_n_loss_ha_cgsb END,
ave_n_loss_12500_8 = CASE WHEN mean_profit_ha < 0 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_12500  ELSE ave_n_loss_ha_cgsb END,
ave_n_loss_12500_9 = CASE WHEN mean_profit_ha < 50 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_12500  ELSE ave_n_loss_ha_cgsb END,
ave_n_loss_12500_10 = CASE WHEN mean_profit_ha < 100 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_12500  ELSE ave_n_loss_ha_cgsb END,
ave_n_loss_12500_11 = CASE WHEN mean_profit_ha < 150 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_12500  ELSE ave_n_loss_ha_cgsb END;

-- take sums for Iowa (in Mg) for the BAU and swg integration scenarios:

DROP TABLE IF EXISTS "08_dndc_n_loss_sums_iowa_dispr_benefits";
CREATE TABLE "08_dndc_n_loss_sums_iowa_dispr_benefits"
AS SELECT
(sum(ave_n_loss_ha_cgsb * clumuha)) / 1000  as corn_soybeans,
(sum(ave_n_loss_7500_1 * clumuha)) / 1000  as swg_7500_1,
(sum(ave_n_loss_7500_2 * clumuha)) / 1000  as swg_7500_2,
(sum(ave_n_loss_7500_3 * clumuha)) / 1000  as swg_7500_3,
(sum(ave_n_loss_7500_4 * clumuha)) / 1000  as swg_7500_4,
(sum(ave_n_loss_7500_5 * clumuha)) / 1000  as swg_7500_5,
(sum(ave_n_loss_7500_6 * clumuha)) / 1000  as swg_7500_6,
(sum(ave_n_loss_7500_7 * clumuha)) / 1000  as swg_7500_7,
(sum(ave_n_loss_7500_8 * clumuha)) / 1000  as swg_7500_8,
(sum(ave_n_loss_7500_9 * clumuha)) / 1000  as swg_7500_9,
(sum(ave_n_loss_7500_10 * clumuha)) / 1000  as swg_7500_10,
(sum(ave_n_loss_7500_11 * clumuha)) / 1000  as swg_7500_11,
(sum(ave_n_loss_10000_1 * clumuha)) / 1000  as swg_10000_1,
(sum(ave_n_loss_10000_2 * clumuha)) / 1000  as swg_10000_2,
(sum(ave_n_loss_10000_3 * clumuha)) / 1000  as swg_10000_3,
(sum(ave_n_loss_10000_4 * clumuha)) / 1000  as swg_10000_4,
(sum(ave_n_loss_10000_5 * clumuha)) / 1000  as swg_10000_5,
(sum(ave_n_loss_10000_6 * clumuha)) / 1000  as swg_10000_6,
(sum(ave_n_loss_10000_7 * clumuha)) / 1000  as swg_10000_7,
(sum(ave_n_loss_10000_8 * clumuha)) / 1000  as swg_10000_8,
(sum(ave_n_loss_10000_9 * clumuha)) / 1000  as swg_10000_9,
(sum(ave_n_loss_10000_10 * clumuha)) / 1000  as swg_10000_10,
(sum(ave_n_loss_10000_11 * clumuha)) / 1000  as swg_10000_11,
(sum(ave_n_loss_12500_1 * clumuha)) / 1000  as swg_12500_1,
(sum(ave_n_loss_12500_2 * clumuha)) / 1000  as swg_12500_2,
(sum(ave_n_loss_12500_3 * clumuha)) / 1000  as swg_12500_3,
(sum(ave_n_loss_12500_4 * clumuha)) / 1000  as swg_12500_4,
(sum(ave_n_loss_12500_5 * clumuha)) / 1000  as swg_12500_5,
(sum(ave_n_loss_12500_6 * clumuha)) / 1000  as swg_12500_6,
(sum(ave_n_loss_12500_7 * clumuha)) / 1000  as swg_12500_7,
(sum(ave_n_loss_12500_8 * clumuha)) / 1000  as swg_12500_8,
(sum(ave_n_loss_12500_9 * clumuha)) / 1000  as swg_12500_9,
(sum(ave_n_loss_12500_10 * clumuha)) / 1000  as swg_12500_10,
(sum(ave_n_loss_12500_11 * clumuha)) / 1000  as swg_12500_11
FROM "05_dndc_clumu_cgsb_swg_n_loss";

