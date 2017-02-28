-- I have imported sand fraction and pH by horizon and component that I have queried from the SSURGO DATABASE.
-- now I will filter and aggregate the data to get a value for each mapunit, according to its major component.

-- add a column to the ssurgo data table to calculate the horizon depth until 15 cm deap
-- this depth will be used as weight when averaging over more than one horizon
/*
ALTER TABLE ssurgo_ia_soil_ph_sand_frac
ADD COLUMN hzdep_10 INT;

UPDATE ssurgo_ia_soil_ph_sand_frac
SET hzdep_10 = 
CASE 
WHEN hzdepb_r <=10 THEN hzdepb_r - hzdept_r 
WHEN hzdepb_r >10 AND hzdept_r <=10 THEN 10 - hzdept_r
ELSE  NULL END;

DROP TABLE IF EXISTS "05_ssurgo_aggregated";
CREATE TABLE "05_ssurgo_aggregated"
AS WITH
agg_table AS (
SELECT
fips,
mukey,
cokey,
comppct_r,
round(sum(sandtotal_r::NUMERIC * hzdep_10)/sum(hzdep_10),1) AS avg_sandtotal_r,
round(sum(ph1to1h2o_r::NUMERIC * hzdep_10)/sum(hzdep_10),1) AS avg_ph1to1h2o_r,
round(sum(ph01mcacl2_r::NUMERIC * hzdep_10)/sum(hzdep_10),1) AS avg_ph01mcacl2_r
FROM ssurgo_ia_soil_ph_sand_frac
WHERE hzdep_10 IS NOT NULL  -- filter for upper 10 cm
GROUP BY cokey, mukey, fips, comppct_r
ORDER BY cokey, mukey
),
max_table AS (
SELECT
mukey,
max(comppct_r) AS comppct_r_max
FROM agg_table
GROUP BY mukey
),
avg_table AS (
SELECT
t2.fips,
t1.mukey,
t2.cokey,
t1.comppct_r_max,
t2.avg_sandtotal_r,
t2.avg_ph1to1h2o_r,
t2.avg_ph01mcacl2_r
FROM max_table AS t1
INNER JOIN agg_table AS t2 ON t1.mukey = t2.mukey AND t1.comppct_r_max = t2.comppct_r
)
SELECT
fips,
mukey,
comppct_r_max,
avg(avg_sandtotal_r) as avg_sandtotal_r,
avg(avg_ph1to1h2o_r) as avg_ph1to1h2o_r,
avg(avg_ph01mcacl2_r) as avg_ph01mcacl2_r
FROM avg_table
GROUP BY mukey, comppct_r_max, fips;


-- check for multiple mukey records:

SELECT count(*) FROM "05_ssurgo_aggregated";
SELECT count(distinct mukey) FROM "05_ssurgo_aggregated";

*/
-- select the low leaching areas from the DNDC result table and 
-- join the soil data to the DNDC outcome via mukey

DROP TABLE IF EXISTS "05_leaching_soil";
CREATE TABLE "05_leaching_soil"
AS WITH 
low_table AS (
SELECT 
fips,
cluid_mukey,
mukey,
clumuha,
mean_profit_ha,
ave_no3_leach_ha_cgsb
FROM "05_dndc_clumu_cgsb_swg"
)
SELECT
t1.*,
t2.avg_Sandtotal_r,
t2.avg_ph1to1h2o_r,
t2.avg_ph01mcacl2_r
FROM low_table AS t1
LEFT JOIN "05_ssurgo_aggregated" AS t2 ON t1.mukey = t2.mukey;



