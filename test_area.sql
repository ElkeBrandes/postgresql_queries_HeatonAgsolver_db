-- test on sum of clumuacres per township:
/*
DROP TABLE IF EXISTS twp_test;
CREATE TABLE twp_test
AS SELECT
twpid,
sum(clumuacres::numeric) AS twp_acres
FROM results_w_profit_roi_actual_price
GROUP BY twpid
ORDER BY twpid;
*/
/*
DROP TABLE IF EXISTS clu_test;
CREATE TABLE clu_test
AS SELECT * FROM results_w_profit_cb_sa WHERE clu_cashrent IS NULL
ORDER BY cluid;

SELECT DISTINCT cluid FROM clu_test
ORDER BY cluid;
*/
/*
DROP TABLE IF EXISTS twpid_1038;
CREATE TABLE twpid_1038
AS SELECT * FROM clu_rents_twp_county WHERE twpid = '1038' ORDER BY co_name 


SELECT SUM(cluacres)/2.471 FROM twpid_1038
*/
-- test how large the area is with yield = 0 in each year:

/*
DROP TABLE IF EXISTS area_zero_yield;
CREATE TABLE area_zero_yield
AS SELECT 
sum(clumuacres::numeric / 2.471) AS zero_yield_ha
FROM results_w_profit_roi_actual_price
WHERE "yield1" = '0' AND "yield2" = '0' AND "yield3" = '0' AND "yield4" = '0';
*/

-- size of database:

-- SELECT pg_database_size(current_database());
/*
SELECT sum(profit1_500_ha) FROM profit_500_ap_township WHERE profit1_500_ha <99999;
SELECT sum(profit2_500_ha) FROM profit_500_ap_township WHERE profit2_500_ha <99999;
SELECT sum(profit3_500_ha) FROM profit_500_ap_township WHERE profit3_500_ha <99999;
SELECT sum(profit4_500_ha) FROM profit_500_ap_township WHERE profit4_500_ha <99999;
*/
-- SELECT sum(clumuacres::numeric)/2.471 FROM crop_budgets_per_clumu_clu_rents_2010_2013 WHERE yield1::numeric > 0
/*
SELECT sum(clumuacres::numeric)/2.471
FROM profit_per_clumu_2015_sa
WHERE profit_2015 <= -500.0;

SELECT sum(clumuacres::numeric)/2.471
FROM profit_rounded_2015
WHERE round_corn_profit_2015 <= -500.0 OR round_soy_profit_2015 <= -500;
*/

/*
SELECT sum(clumuacres::numeric)/2.471
FROM profit_per_clumu_2015_sa
WHERE profit_2015 <= 0;

SELECT sum(profit_2015_ha)/2.471
FROM profit_500_sa_township_2015_cashrents_r;
*/
-- calculate weighted average yield in 2015 for corn and soybean:
/*
DROP TABLE IF EXISTS "2015_av_corn_yield";
CREATE TABLE "2015_av_corn_yield"
AS SELECT 
sum(yield_2015*clumuacres::numeric)/sum(clumuacres::numeric) as av_corn_yield

FROM crop_budgets_per_clumu_2015_twp_yields
WHERE ccrop = 'CG';

DROP TABLE IF EXISTS "2015_av_soy_yield";
CREATE TABLE "2015_av_soy_yield"
AS SELECT 
sum(yield_2015*clumuacres::numeric)/sum(clumuacres::numeric) as av_soy_yield
FROM crop_budgets_per_clumu_2015_twp_yields
WHERE ccrop = 'SB';
*/
/*
SELECT sum(profit1_250_ha) from profit_250_ap_township_county;
SELECT sum(profit2_250_ha) from profit_250_ap_township_county;
SELECT sum(profit3_250_ha) from profit_250_ap_township_county;
SELECT sum(profit4_250_ha) from profit_250_ap_township_county;

SELECT sum(profit4_250_ha) from profit_250_ap_township_county WHERE co_name = 'CARROLL';
SELECT sum(profit4_250_ha) from profit_250_ap_township_county WHERE co_name = 'HAMILTON';
SELECT sum(profit4_250_ha) from profit_250_ap_township_county WHERE co_name = 'STORY';
*/
/*
SELECT sum(profit_2015_ha) from profit_250_sa_township_2015_cashrents_r;
SELECT sum(total_ha) from profit_250_sa_township_2015_cashrents_r;
*/
