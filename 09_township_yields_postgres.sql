

-- 1. create a table with separate corn and soybean yields (in metric units), while filtering out clu-map units with zero yields in all years:

DROP TABLE IF EXISTS corn_soy_yields;
CREATE TABLE corn_soy_yields
AS SELECT 
co_name
, twpid
, cluid_mukey
, clumuacres
, crop1
, (CASE WHEN crop1 = 'CG' THEN clumuacres ELSE NULL END) AS corn1_clumuacres
, (CASE WHEN crop1 = 'CG' THEN yield1::NUMERIC*25.4012*0.001*2.471 ELSE NULL END) AS corn_yield1 
, (CASE WHEN crop1 = 'SB' THEN clumuacres ELSE NULL END) AS soy1_clumuacres
, (CASE WHEN crop1 = 'SB' THEN yield1::NUMERIC*27.2155*0.001*2.471 ELSE NULL END) AS soy_yield1 
, crop2
, (CASE WHEN crop2 = 'CG' THEN clumuacres ELSE NULL END) AS corn2_clumuacres
, (CASE WHEN crop2 = 'CG' THEN yield2::NUMERIC*25.4012*0.001*2.471 ELSE NULL END) AS corn_yield2 
, (CASE WHEN crop2 = 'SB' THEN clumuacres ELSE NULL END) AS soy2_clumuacres
, (CASE WHEN crop2 = 'SB' THEN round(yield2::NUMERIC*27.2155*0.001*2.471,2) ELSE NULL END) AS soy_yield2
, crop3
, (CASE WHEN crop3 = 'CG' THEN clumuacres ELSE NULL END) AS corn3_clumuacres
, (CASE WHEN crop3 = 'CG' THEN round(yield3::NUMERIC*25.4012*0.001*2.471,2) ELSE NULL END) AS corn_yield3 
, (CASE WHEN crop3 = 'SB' THEN clumuacres ELSE NULL END) AS soy3_clumuacres
, (CASE WHEN crop3 = 'SB' THEN round(yield3::NUMERIC*27.2155*0.001*2.471,2) ELSE NULL END) AS soy_yield3 
, crop4
, (CASE WHEN crop4 = 'CG' THEN clumuacres ELSE NULL END) AS corn4_clumuacres
, (CASE WHEN crop4 = 'CG' THEN round(yield4::NUMERIC*25.4012*0.001*2.471,2) ELSE NULL END) AS corn_yield4
, (CASE WHEN crop4 = 'SB' THEN clumuacres ELSE NULL END) AS soy4_clumuacres
, (CASE WHEN crop4 = 'SB' THEN round(yield4::NUMERIC*27.2155*0.001*2.471,2) ELSE NULL END) AS soy_yield4 
FROM results_w_profit_roi_actual_price
WHERE "yield1" > '0' AND "yield2" > '0' AND "yield3" > '0' AND "yield4" > '0'
ORDER BY co_name, cluid;


-- 1.a) calculate weighted averages of absolute yields per township:
/*
DROP TABLE IF EXISTS twp_yields;
CREATE TABLE twp_yields
AS SELECT
twpid
, sum(corn_yield1::numeric * corn1_clumuacres::numeric)/sum(corn1_clumuacres::numeric) AS twp_corn_yield1
, sum(soy_yield1::numeric * soy1_clumuacres::numeric)/sum(soy1_clumuacres::numeric)  AS twp_soy_yield1
, sum(corn_yield2::numeric * corn2_clumuacres::numeric)/sum(corn2_clumuacres::numeric)  AS twp_corn_yield2
, sum(soy_yield2::numeric * soy2_clumuacres::numeric)/sum(soy2_clumuacres::numeric)  AS twp_soy_yield2
, sum(corn_yield3::numeric * corn3_clumuacres::numeric)/sum(corn3_clumuacres::numeric)  AS twp_corn_yield3
, sum(soy_yield3::numeric * soy3_clumuacres::numeric)/sum(soy3_clumuacres::numeric)  AS twp_soy_yield3
, sum(corn_yield4::numeric * corn4_clumuacres::numeric)/sum(corn4_clumuacres::numeric)  AS twp_corn_yield4
, sum(soy_yield4::numeric * soy4_clumuacres::numeric)/sum(soy4_clumuacres::numeric)  AS twp_soy_yield4
FROM corn_soy_yields
GROUP BY twpid;


DROP TABLE IF EXISTS twp_yields_area;
CREATE TABLE twp_yields_area
AS SELECT
t1.*,
t2.total_ha
FROM twp_yields AS t1
JOIN profit_500_ap_township AS t2 ON t1.twpid = t2.twpid;
*/

-- filter out townships with < 700 ha in row crops
/*
UPDATE twp_yields_area
SET twp_corn_yield1 = 99999 WHERE total_ha < 700.0;
UPDATE twp_yields_area
SET twp_soy_yield1 = 99999 WHERE total_ha < 700.0;
UPDATE twp_yields_area
SET twp_corn_yield2 = 99999 WHERE total_ha < 700.0;
UPDATE twp_yields_area
SET twp_soy_yield2 = 99999 WHERE total_ha < 700.0;
UPDATE twp_yields_area
SET twp_corn_yield3 = 99999 WHERE total_ha < 700.0;
UPDATE twp_yields_area
SET twp_soy_yield3 = 99999 WHERE total_ha < 700.0;
UPDATE twp_yields_area
SET twp_corn_yield4 = 99999 WHERE total_ha < 700.0;
UPDATE twp_yields_area
SET twp_soy_yield4 = 99999 WHERE total_ha < 700.0;
*/
