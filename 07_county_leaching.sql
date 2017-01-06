-- aggreate leaching to the county level under the four scenarios, calculate sums and change in leaching from status quo in percent 
/*
DROP TABLE IF EXISTS "07_dndc_counties";
CREATE TABLE "07_dndc_counties"
AS SELECT
fips,
sum((ave_no3_leach_ha_cgsb * clumuha) / 1000) as tot_ave_no3_leach_cgsb,
sum((ave_no3_leach_po_7500 * clumuha) / 1000) as tot_ave_no3_leach_7500,
sum((ave_no3_leach_po_10000 * clumuha) / 1000) as tot_ave_no3_leach_10000,
sum((ave_no3_leach_po_12500 * clumuha) / 1000) as tot_ave_no3_leach_12500,
sum(ave_no3_leach_ha_cgsb * clumuha)/sum(clumuha) as ave_no3_leach_cgsb,
sum(ave_no3_leach_po_7500 * clumuha)/sum(clumuha) as ave_no3_leach_7500,
sum(ave_no3_leach_po_10000 * clumuha)/sum(clumuha) as ave_no3_leach_10000,
sum(ave_no3_leach_po_12500 * clumuha)/sum(clumuha) as ave_no3_leach_12500
FROM "05_dndc_clumu_cgsb_swg"
GROUP BY fips;

ALTER TABLE "07_dndc_counties"
ADD COLUMN no3_leach_change_7500 NUMERIC;
ALTER TABLE "07_dndc_counties"
ADD COLUMN no3_leach_change_10000 NUMERIC;
ALTER TABLE "07_dndc_counties"
ADD COLUMN no3_leach_change_12500 NUMERIC;


UPDATE "07_dndc_counties"
SET 
no3_leach_change_7500 = ((tot_ave_no3_leach_cgsb - tot_ave_no3_leach_7500) / tot_ave_no3_leach_cgsb)*100,
no3_leach_change_10000 = ((tot_ave_no3_leach_cgsb - tot_ave_no3_leach_10000) / tot_ave_no3_leach_cgsb)*100,
no3_leach_change_12500 = ((tot_ave_no3_leach_cgsb - tot_ave_no3_leach_12500) / tot_ave_no3_leach_cgsb)*100;

*/
-- calculate the area in switchgrass per county under the PO scenario when all area < -150 $/ha is in swichgrass
/*
DROP TABLE IF EXISTS "07_swg_area_counties_po";
CREATE TABLE "07_swg_area_counties_po"
AS WITH 
swg_table AS(
SELECT
fips,
sum(clumuha) AS area_in_swg
FROM "05_dndc_clumu_cgsb_swg"
WHERE mean_profit_ha < -150
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
*/

ALTER TABLE "07_swg_area_counties_po"
ADD area_in_swg_perc NUMERIC;

UPDATE "07_swg_area_counties_po"
SET area_in_swg_perc = area_in_swg * 100 / total_area;
