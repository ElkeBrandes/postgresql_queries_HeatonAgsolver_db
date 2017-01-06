-- 1. create a table with separate corn and soybean crop budgets, while filtering out clu-map units with zero yields in all years:
/*
DROP TABLE IF EXISTS corn_soy_profit;
CREATE TABLE corn_soy_profit
AS SELECT 
co_name
, twpid
, cluid
, mukey
, clumuacres
, crop1
, (CASE WHEN crop1 = 'CG' THEN clumuacres ELSE NULL END) AS corn1_clumuacres
, (CASE WHEN crop1 = 'CG' THEN profit1 ELSE NULL END) AS corn_profit1 
, (CASE WHEN crop1 = 'SB' THEN clumuacres ELSE NULL END) AS soy1_clumuacres
, (CASE WHEN crop1 = 'SB' THEN profit1 ELSE NULL END) AS soy_profit1 
, crop2
, (CASE WHEN crop2 = 'CG' THEN clumuacres ELSE NULL END) AS corn2_clumuacres
, (CASE WHEN crop2 = 'CG' THEN profit2 ELSE NULL END) AS corn_profit2 
, (CASE WHEN crop2 = 'SB' THEN clumuacres ELSE NULL END) AS soy2_clumuacres
, (CASE WHEN crop2 = 'SB' THEN profit2 ELSE NULL END) AS soy_profit2
, crop3
, (CASE WHEN crop3 = 'CG' THEN clumuacres ELSE NULL END) AS corn3_clumuacres
, (CASE WHEN crop3 = 'CG' THEN profit3 ELSE NULL END) AS corn_profit3 
, (CASE WHEN crop3 = 'SB' THEN clumuacres ELSE NULL END) AS soy3_clumuacres
, (CASE WHEN crop3 = 'SB' THEN profit3 ELSE NULL END) AS soy_profit3 
, crop4
, (CASE WHEN crop4 = 'CG' THEN clumuacres ELSE NULL END) AS corn4_clumuacres
, (CASE WHEN crop4 = 'CG' THEN profit4 ELSE NULL END) AS corn_profit4
, (CASE WHEN crop4 = 'SB' THEN clumuacres ELSE NULL END) AS soy4_clumuacres
, (CASE WHEN crop4 = 'SB' THEN profit4 ELSE NULL END) AS soy_profit4 
FROM results_w_profit_roi_actual_price
WHERE "yield1" > '0' AND "yield2" > '0' AND "yield3" > '0' AND "yield4" > '0'
ORDER BY co_name, cluid;
*/
-- 1.a) calculate weighted averages of crop budgets per township:

DROP TABLE IF EXISTS twp_corn_soy_profit;
CREATE TABLE twp_corn_soy_profit
AS SELECT
twpid
, sum(corn_profit1::numeric * corn1_clumuacres::numeric)/sum(corn1_clumuacres::numeric) AS twp_corn_profit1
, sum(soy_profit1::numeric * soy1_clumuacres::numeric)/sum(soy1_clumuacres::numeric)  AS twp_soy_profit1
, sum(corn_profit2::numeric * corn2_clumuacres::numeric)/sum(corn2_clumuacres::numeric)  AS twp_corn_profit2
, sum(soy_profit2::numeric * soy2_clumuacres::numeric)/sum(soy2_clumuacres::numeric)  AS twp_soy_profit2
, sum(corn_profit3::numeric * corn3_clumuacres::numeric)/sum(corn3_clumuacres::numeric)  AS twp_corn_profit3
, sum(soy_profit3::numeric * soy3_clumuacres::numeric)/sum(soy3_clumuacres::numeric)  AS twp_soy_profit3
, sum(corn_profit4::numeric * corn4_clumuacres::numeric)/sum(corn4_clumuacres::numeric)  AS twp_corn_profit4
, sum(soy_profit4::numeric * soy4_clumuacres::numeric)/sum(soy4_clumuacres::numeric)  AS twp_soy_profit4
FROM corn_soy_profit
GROUP BY twpid;

