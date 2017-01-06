-- SELECT * FROM clu_rents_twp
-- WHERE cluacres < 25.0

-- import table with the county names and average cash rents:
/*
CREATE TABLE county_av_cash_rent_2014 (county_name TEXT, county_av_rent NUMERIC);
-- import the CSV file



DROP TABLE IF EXISTS clu_rents_twp_25_acres;
CREATE TABLE clu_rents_twp_25_acres
AS SELECT 
t1.co_name
, t1.twpid
, t1.cluid
, t1.cluacres
, t1.clu_cashrent
, t2.county_av_rent
FROM clu_rents_twp_county AS t1 
INNER JOIN county_av_cash_rent_2014 AS t2 ON lower(t1.co_name) = lower(t2.county_name)
ORDER BY cluid;

UPDATE clu_rents_twp_25_acres
SET clu_cashrent = county_av_rent
WHERE cluacres::numeric < 25.0;

-- aggregate rents to township level to create a QGIS map:


DROP TABLE IF EXISTS clu_rents_twp_agg_25_acres;
CREATE TABLE clu_rents_twp_agg_25_acres
AS SELECT
twpid
, (sum(clu_cashrent::NUMERIC * cluacres::NUMERIC)/sum(cluacres::NUMERIC))*2.471 AS twp_cashrent_ha
FROM clu_rents_twp_25_acres
GROUP BY twpid
ORDER BY twpid;
*/

-- aggregate rents to county level to compare with average county yields taken from the survey (not the same due to the later correction of small CLUs)

DROP TABLE IF EXISTS clu_rents_co_agg_25_acres;
CREATE TABLE clu_rents_co_agg_25_acres
AS SELECT
co_name
, (sum(clu_cashrent::NUMERIC * cluacres::NUMERIC)/sum(cluacres::NUMERIC)) AS co_cashrent_ac
FROM clu_rents_twp_25_acres
GROUP BY co_name
ORDER BY co_name;