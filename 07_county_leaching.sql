-- aggreate leaching to the county level under the four scenarios, 
-- per county: calculate sums, averages, and change in leaching from status quo in percent 

DROP TABLE IF EXISTS "07_dndc_counties";
CREATE TABLE "07_dndc_counties"
AS SELECT
fips,
sum((ave_no3_leach_ha_cgsb * clumuha) / 1000) as tot_no3_leach_cgsb,
sum((ave_no3_leach_swg_int_7500 * clumuha) / 1000) as tot_no3_leach_7500,
sum((ave_no3_leach_swg_int_10000_1 * clumuha) / 1000) as tot_no3_leach_10000_1,
sum((ave_no3_leach_swg_int_10000_2 * clumuha) / 1000) as tot_no3_leach_10000_2,
sum((ave_no3_leach_swg_int_12500 * clumuha) / 1000) as tot_no3_leach_12500,
sum(ave_no3_leach_ha_cgsb * clumuha)/sum(clumuha) as ave_no3_leach_cgsb,
sum(no3_leach12_ha_cgsb * clumuha)/sum(clumuha) as ave_no3_leach12_cgsb,
sum(no3_leach13_ha_cgsb * clumuha)/sum(clumuha) as ave_no3_leach13_cgsb,
sum(no3_leach14_ha_cgsb * clumuha)/sum(clumuha) as ave_no3_leach14_cgsb,
sum(no3_leach15_ha_cgsb * clumuha)/sum(clumuha) as ave_no3_leach15_cgsb,
sum(ave_no3_leach_swg_int_7500 * clumuha)/sum(clumuha) as ave_no3_leach_7500,
sum(ave_no3_leach_swg_int_10000_1 * clumuha)/sum(clumuha) as ave_no3_leach_10000_1,
sum(ave_no3_leach_swg_int_10000_2 * clumuha)/sum(clumuha) as ave_no3_leach_10000_2,
sum(ave_no3_leach_swg_int_12500 * clumuha)/sum(clumuha) as ave_no3_leach_12500,
sum(ave_nh3_vol_ha_cgsb * clumuha)/sum(clumuha) as ave_nh3_vol_cgsb
FROM "05_dndc_clumu_cgsb_swg"
GROUP BY fips;

ALTER TABLE "07_dndc_counties"
ADD COLUMN no3_leach_change_7500 NUMERIC,
ADD COLUMN no3_leach_change_10000_1 NUMERIC,
ADD COLUMN no3_leach_change_10000_2 NUMERIC,
ADD COLUMN no3_leach_change_12500 NUMERIC;


UPDATE "07_dndc_counties"
SET 
no3_leach_change_7500 = ((tot_no3_leach_cgsb - tot_no3_leach_7500) / tot_no3_leach_cgsb)*100,
no3_leach_change_10000_1 = ((tot_no3_leach_cgsb - tot_no3_leach_10000_1) / tot_no3_leach_cgsb)*100,
no3_leach_change_10000_2 = ((tot_no3_leach_cgsb - tot_no3_leach_10000_2) / tot_no3_leach_cgsb)*100,
no3_leach_change_12500 = ((tot_no3_leach_cgsb - tot_no3_leach_12500) / tot_no3_leach_cgsb)*100;


-- calculate the area in switchgrass per county under the tweak scenario when all area with profit < -100 $/ha 
-- and leaching > 50 kg N / ha is in switchgrass
/*
DROP TABLE IF EXISTS "07_swg_area_counties_tweak";
CREATE TABLE "07_swg_area_counties_tweak"
AS WITH 
swg_table AS(
SELECT
fips,
sum(clumuha) AS area_in_swg
FROM "05_dndc_clumu_cgsb_swg"
WHERE mean_profit_ha < -100 AND ave_no3_leach_ha_cgsb > 50
GROUP BY fips
),
total_table AS(
SELECT 
fips,
sum(clumuha) AS total_area
FROM "05_dndc_clumu_cgsb_swg"
GROUP BY fips
)
SELECT
t1.*,
t2.total_area
FROM swg_table AS t1
LEFT JOIN total_table AS t2 ON t1.fips = t2.fips;


ALTER TABLE "07_swg_area_counties_tweak"
ADD area_in_swg_perc NUMERIC;

UPDATE "07_swg_area_counties_tweak"
SET area_in_swg_perc = area_in_swg * 100 / total_area;

*/


