

-- 1. create a table with separate corn and soybean yields (in metric units), while filtering out clu-map units with zero yields in all years:
/*
DROP TABLE IF EXISTS corn_soy_yields_2015;
CREATE TABLE corn_soy_yields_2015
AS SELECT 
co_name
, twpid
, cluid_mukey
, clumuacres
, ccrop
, (CASE WHEN ccrop = 'CG' THEN clumuacres ELSE NULL END) AS corn_2015_clumuacres
, (CASE WHEN ccrop = 'CG' THEN yield_2015::NUMERIC*25.4012*0.001*2.471 ELSE NULL END) AS corn_yield_2015 
, (CASE WHEN ccrop = 'SB' THEN clumuacres ELSE NULL END) AS soy_2015_clumuacres
, (CASE WHEN ccrop = 'SB' THEN yield_2015::NUMERIC*27.2155*0.001*2.471 ELSE NULL END) AS soy_yield_2015
FROM crop_budgets_per_clumu_2015_twp_yields
WHERE "yield_2015" > '0'
ORDER BY co_name, cluid;
*/

-- 1.a) calculate weighted averages of absolute yields per township:

DROP TABLE IF EXISTS twp_yields_2015;
CREATE TABLE twp_yields_2015
AS SELECT
twpid
, sum(corn_yield_2015::numeric * corn_2015_clumuacres::numeric)/sum(corn_2015_clumuacres::numeric) AS twp_corn_yield_2015
, sum(soy_yield_2015::numeric * soy_2015_clumuacres::numeric)/sum(soy_2015_clumuacres::numeric)  AS twp_soy_yield_2015
FROM corn_soy_yields_2015
GROUP BY twpid;


DROP TABLE IF EXISTS twp_yields_2015_area;
CREATE TABLE twp_yields_2015_area
AS SELECT
t1.*,
t2.total_ha
FROM twp_yields_2015 AS t1
JOIN profit_250_ap_township AS t2 ON t1.twpid = t2.twpid;


-- filter out townships with < 700 ha in row crops

UPDATE twp_yields_2015_area
SET twp_corn_yield_2015 = NULL WHERE total_ha < 700.0;
UPDATE twp_yields_2015_area
SET twp_soy_yield_2015 = NULL WHERE total_ha < 700.0;

