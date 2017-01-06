-- aggregate to county:
/*
DROP TABLE IF EXISTS profit1_500_ap_totals_c;
CREATE TABLE profit1_500_ap_totals_c
AS SELECT
fips,
sum(clumuacres::numeric)/2.471 AS profit1_500_ha
FROM profit1_500_ap
GROUP BY fips;

DROP TABLE IF EXISTS profit2_500_ap_totals_c;
CREATE TABLE profit2_500_ap_totals_c
AS SELECT
fips,
sum(clumuacres::numeric)/2.471 AS profit2_500_ha
FROM profit2_500_ap
GROUP BY fips;

DROP TABLE IF EXISTS profit3_500_ap_totals_c;
CREATE TABLE profit3_500_ap_totals_c
AS SELECT
fips,
sum(clumuacres::numeric)/2.471 AS profit3_500_ha
FROM profit3_500_ap
GROUP BY fips;

DROP TABLE IF EXISTS profit4_500_ap_totals_c;
CREATE TABLE profit4_500_ap_totals_c
AS SELECT
fips,
sum(clumuacres::numeric)/2.471 AS profit4_500_ha
FROM profit4_500_ap
GROUP BY fips;


DROP TABLE IF EXISTS profit_500_ap_totals_c;
CREATE TABLE profit_500_ap_totals_c
AS SELECT
fips,
sum(clumuacres::numeric)/2.471 AS profit_500_ha
FROM profit_500_ap
GROUP BY fips;


DROP TABLE IF EXISTS profit_av_500_ap_totals_c;
CREATE TABLE profit_av_500_ap_totals_c
AS SELECT
fips,
sum(clumuacres::numeric)/2.471 AS profit_av_500_ha
FROM profit_av_500_ap
GROUP BY fips;

-- table with total ha per county in rowcrop:

DROP TABLE IF EXISTS twp_total_ha_c;
CREATE TABLE twp_total_ha_c
AS SELECT
fips,
sum(clumuacres::NUMERIC)/2.471 AS total_ha
FROM crop_budgets_per_clumu_clu_rents_2010_2013 
GROUP BY fips;
*/
-- Join the tables above:
/*
DROP TABLE IF EXISTS ha_join1_c;
CREATE TABLE ha_join1_c
AS SELECT
t1.fips,
t1.total_ha,
t2.profit_av_500_ha
FROM twp_total_ha_c t1
LEFT OUTER JOIN profit_av_500_ap_totals_c t2
ON t1.fips = t2.fips;

DROP TABLE IF EXISTS ha_join2_c;
CREATE TABLE ha_join2_c
AS SELECT
t1.*,
t2.profit1_500_ha
FROM ha_join1_c t1
LEFT OUTER JOIN profit1_500_ap_totals_c t2
ON t1.fips = t2.fips;

DROP TABLE IF EXISTS ha_join3_c;
CREATE TABLE ha_join3_c
AS SELECT
t1.*,
t2.profit2_500_ha
FROM ha_join2_c t1
LEFT OUTER JOIN profit2_500_ap_totals_c t2
ON t1.fips = t2.fips;

DROP TABLE IF EXISTS ha_join4_c;
CREATE TABLE ha_join4_c
AS SELECT
t1.*,
t2.profit3_500_ha
FROM ha_join3_c t1
LEFT OUTER JOIN profit3_500_ap_totals_c t2
ON t1.fips = t2.fips;

DROP TABLE IF EXISTS ha_join5_c;
CREATE TABLE ha_join5_c
AS SELECT
t1.*,
t2.profit4_500_ha
FROM ha_join4_c t1
LEFT OUTER JOIN profit4_500_ap_totals_c t2
ON t1.fips = t2.fips
ORDER BY fips;

-- add a column with the county names:

DROP TABLE IF EXISTS profit_500_ap_county;
CREATE TABLE profit_500_ap_county
AS SELECT
t2.county_name,
t1.*
FROM ha_join5_c t1
LEFT OUTER JOIN county t2
ON t1.fips = t2.fips
ORDER BY fips;
*/
/*
UPDATE profit_500_ap_township
SET profit_av_500_ha = 0 WHERE profit_av_500_ha IS  NULL;
UPDATE profit_500_ap_township
SET profit1_500_ha = 0 WHERE profit1_500_ha IS  NULL;
UPDATE profit_500_ap_township
SET profit2_500_ha = 0 WHERE profit2_500_ha IS  NULL;
UPDATE profit_500_ap_township
SET profit3_500_ha = 0 WHERE profit3_500_ha IS  NULL;
UPDATE profit_500_ap_township
SET profit4_500_ha = 0 WHERE profit4_500_ha IS  NULL;
*/
