-- for the base line and each profitability cut off scenario,
-- take sums for Iowa (in Mg):

DROP TABLE IF EXISTS "08_dndc_n_loss_sums_iowa_dispr_benefits";
CREATE TABLE "08_dndc_n_loss_sums_iowa_dispr_benefits"
AS SELECT
(sum(ave_n_loss_ha_cgsb * clumuha)) / 1000  as corn_soybeans,
(sum((CASE WHEN mean_profit_ha < -500 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_7500  
ELSE ave_n_loss_ha_cgsb END) * clumuha)) / 1000 as swg_7500_1,
(sum((CASE WHEN mean_profit_ha < -400 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_7500  
ELSE ave_n_loss_ha_cgsb END) * clumuha)) / 1000 as swg_7500_2,
(sum((CASE WHEN mean_profit_ha < -300 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_7500  
ELSE ave_n_loss_ha_cgsb END) * clumuha)) / 1000 as swg_7500_3,
(sum((CASE WHEN mean_profit_ha < -200 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_7500  
ELSE ave_n_loss_ha_cgsb END) * clumuha)) / 1000 as swg_7500_4,
(sum((CASE WHEN mean_profit_ha < -150 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_7500  
ELSE ave_n_loss_ha_cgsb END) * clumuha)) / 1000 as swg_7500_5,
(sum((CASE WHEN mean_profit_ha < -100 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_7500  
ELSE ave_n_loss_ha_cgsb END) * clumuha)) / 1000 as swg_7500_6,
(sum((CASE WHEN mean_profit_ha < -50 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_7500  
ELSE ave_n_loss_ha_cgsb END) * clumuha)) / 1000 as swg_7500_7,
(sum((CASE WHEN mean_profit_ha < 0 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_7500  
ELSE ave_n_loss_ha_cgsb END) * clumuha)) / 1000 as swg_7500_8,
(sum((CASE WHEN mean_profit_ha < 50 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_7500  
ELSE ave_n_loss_ha_cgsb END) * clumuha)) / 1000 as swg_7500_9,
(sum((CASE WHEN mean_profit_ha < 100 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_7500  
ELSE ave_n_loss_ha_cgsb END) * clumuha)) / 1000 as swg_7500_10,
(sum((CASE WHEN mean_profit_ha < 150 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_7500  
ELSE ave_n_loss_ha_cgsb END) * clumuha)) / 1000 as swg_7500_11,
(sum((CASE WHEN mean_profit_ha < -500 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_10000  
ELSE ave_n_loss_ha_cgsb END) * clumuha)) / 1000 as swg_10000_1,
(sum((CASE WHEN mean_profit_ha < -400 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_10000  
ELSE ave_n_loss_ha_cgsb END) * clumuha)) / 1000 as swg_10000_2,
(sum((CASE WHEN mean_profit_ha < -300 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_10000  
ELSE ave_n_loss_ha_cgsb END) * clumuha)) / 1000 as swg_10000_3,
(sum((CASE WHEN mean_profit_ha < -200 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_10000  
ELSE ave_n_loss_ha_cgsb END) * clumuha)) / 1000 as swg_10000_4,
(sum((CASE WHEN mean_profit_ha < -150 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_10000  
ELSE ave_n_loss_ha_cgsb END) * clumuha)) / 1000 as swg_10000_5,
(sum((CASE WHEN mean_profit_ha < -100 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_10000  
ELSE ave_n_loss_ha_cgsb END) * clumuha)) / 1000 as swg_10000_6,
(sum((CASE WHEN mean_profit_ha < -50 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_10000  
ELSE ave_n_loss_ha_cgsb END) * clumuha)) / 1000 as swg_10000_7,
(sum((CASE WHEN mean_profit_ha < 0 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_10000  
ELSE ave_n_loss_ha_cgsb END) * clumuha)) / 1000 as swg_10000_8,
(sum((CASE WHEN mean_profit_ha < 50 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_10000  
ELSE ave_n_loss_ha_cgsb END) * clumuha)) / 1000 as swg_10000_9,
(sum((CASE WHEN mean_profit_ha < 100 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_10000  
ELSE ave_n_loss_ha_cgsb END) * clumuha)) / 1000 as swg_10000_10,
(sum((CASE WHEN mean_profit_ha < 150 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_10000  
ELSE ave_n_loss_ha_cgsb END) * clumuha)) / 1000 as swg_10000_11,
(sum((CASE WHEN mean_profit_ha < -500 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_12500  
ELSE ave_n_loss_ha_cgsb END) * clumuha)) / 1000 as swg_12500_1,
(sum((CASE WHEN mean_profit_ha < -400 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_12500  
ELSE ave_n_loss_ha_cgsb END) * clumuha)) / 1000 as swg_12500_2,
(sum((CASE WHEN mean_profit_ha < -300 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_12500  
ELSE ave_n_loss_ha_cgsb END) * clumuha)) / 1000 as swg_12500_3,
(sum((CASE WHEN mean_profit_ha < -200 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_12500  
ELSE ave_n_loss_ha_cgsb END) * clumuha)) / 1000 as swg_12500_4,
(sum((CASE WHEN mean_profit_ha < -150 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_12500  
ELSE ave_n_loss_ha_cgsb END) * clumuha)) / 1000 as swg_12500_5,
(sum((CASE WHEN mean_profit_ha < -100 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_12500  
ELSE ave_n_loss_ha_cgsb END) * clumuha)) / 1000 as swg_12500_6,
(sum((CASE WHEN mean_profit_ha < -50 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_12500  
ELSE ave_n_loss_ha_cgsb END) * clumuha)) / 1000 as swg_12500_7,
(sum((CASE WHEN mean_profit_ha < 0 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_12500  
ELSE ave_n_loss_ha_cgsb END) * clumuha)) / 1000 as swg_12500_8,
(sum((CASE WHEN mean_profit_ha < 50 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_12500  
ELSE ave_n_loss_ha_cgsb END) * clumuha)) / 1000 as swg_12500_9,
(sum((CASE WHEN mean_profit_ha < 100 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_12500  
ELSE ave_n_loss_ha_cgsb END) * clumuha)) / 1000 as swg_12500_10,
(sum((CASE WHEN mean_profit_ha < 150 AND ave_n_loss_ha_cgsb > 60 THEN ave_n_loss_ha_swg_12500  
ELSE ave_n_loss_ha_cgsb END) * clumuha)) / 1000 as swg_12500_11
FROM "05_dndc_clumu_cgsb_swg_n_loss";

