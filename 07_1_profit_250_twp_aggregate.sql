-- aggregate to township:
/*
DROP TABLE IF EXISTS profit1_250_ap_totals;
CREATE TABLE profit1_250_ap_totals
AS SELECT
twpid,
sum(clumuacres::numeric)/2.471 AS profit1_250_ha
FROM profit1_250_ap
GROUP BY twpid;

DROP TABLE IF EXISTS profit2_250_ap_totals;
CREATE TABLE profit2_250_ap_totals
AS SELECT
twpid,
sum(clumuacres::numeric)/2.471 AS profit2_250_ha
FROM profit2_250_ap
GROUP BY twpid;

DROP TABLE IF EXISTS profit3_250_ap_totals;
CREATE TABLE profit3_250_ap_totals
AS SELECT
twpid,
sum(clumuacres::numeric)/2.471 AS profit3_250_ha
FROM profit3_250_ap
GROUP BY twpid;

DROP TABLE IF EXISTS profit4_250_ap_totals;
CREATE TABLE profit4_250_ap_totals
AS SELECT
twpid,
sum(clumuacres::numeric)/2.471 AS profit4_250_ha
FROM profit4_250_ap
GROUP BY twpid;
*/

DROP TABLE IF EXISTS profit_250_ap_totals;
CREATE TABLE profit_250_ap_totals
AS SELECT
twpid,
sum(clumuacres::numeric)/2.471 AS profit_250_ha
FROM profit_250_ap
GROUP BY twpid;

/*
DROP TABLE IF EXISTS profit_av_250_ap_totals;
CREATE TABLE profit_av_250_ap_totals
AS SELECT
twpid,
sum(clumuacres::numeric)/2.471 AS profit_av_250_ha
FROM profit_av_250_ap
GROUP BY twpid;

-- table with total ha per township in rowcrop:

DROP TABLE IF EXISTS twp_total_ha;
CREATE TABLE twp_total_ha
AS SELECT
twpid,
sum(clumuacres::NUMERIC)/2.471 AS total_ha
FROM crop_budgets_per_clumu_clu_rents_2010_2013 
GROUP BY twpid;
*/
-- Join the tables above:

DROP TABLE IF EXISTS ha_join1;
CREATE TABLE ha_join1
AS SELECT
t1.twpid,
t1.total_ha,
t2.profit_av_250_ha
FROM twp_total_ha t1
LEFT OUTER JOIN profit_av_250_ap_totals t2
ON t1.twpid = t2.twpid;

DROP TABLE IF EXISTS ha_join2;
CREATE TABLE ha_join2
AS SELECT
t1.*,
t2.profit1_250_ha
FROM ha_join1 t1
LEFT OUTER JOIN profit1_250_ap_totals t2
ON t1.twpid = t2.twpid;

DROP TABLE IF EXISTS ha_join3;
CREATE TABLE ha_join3
AS SELECT
t1.*,
t2.profit2_250_ha
FROM ha_join2 t1
LEFT OUTER JOIN profit2_250_ap_totals t2
ON t1.twpid = t2.twpid;

DROP TABLE IF EXISTS ha_join4;
CREATE TABLE ha_join4
AS SELECT
t1.*,
t2.profit3_250_ha
FROM ha_join3 t1
LEFT OUTER JOIN profit3_250_ap_totals t2
ON t1.twpid = t2.twpid;


DROP TABLE IF EXISTS ha_join5;
CREATE TABLE ha_join5
AS SELECT
t1.*,
t2.profit4_250_ha
FROM ha_join4 t1
LEFT OUTER JOIN profit4_250_ap_totals t2
ON t1.twpid = t2.twpid
ORDER BY twpid;

DROP TABLE IF EXISTS profit_250_ap_township;
CREATE TABLE profit_250_ap_township
AS SELECT
t1.*,
t2.profit_250_ha
FROM ha_join5 t1
LEFT OUTER JOIN profit_250_ap_totals t2
ON t1.twpid = t2.twpid
ORDER BY twpid;


UPDATE profit_250_ap_township
SET profit_av_250_ha = 0 WHERE profit_av_250_ha IS  NULL;
UPDATE profit_250_ap_township
SET profit1_250_ha = 0 WHERE profit1_250_ha IS  NULL;
UPDATE profit_250_ap_township
SET profit2_250_ha = 0 WHERE profit2_250_ha IS  NULL;
UPDATE profit_250_ap_township
SET profit3_250_ha = 0 WHERE profit3_250_ha IS  NULL;
UPDATE profit_250_ap_township
SET profit4_250_ha = 0 WHERE profit4_250_ha IS  NULL;

-- replace profit area values with "99999" for those township with < 700 ha in row crop:

UPDATE profit_250_ap_township
SET profit_av_250_ha = null WHERE total_ha < 700.0;
UPDATE profit_250_ap_township
SET profit1_250_ha = null WHERE total_ha < 700.0;
UPDATE profit_250_ap_township
SET profit2_250_ha = null WHERE total_ha < 700.0;
UPDATE profit_250_ap_township
SET profit3_250_ha = null WHERE total_ha < 700.0;
UPDATE profit_250_ap_township
SET profit4_250_ha = null WHERE total_ha < 700.0;


-- join with county to sum up unprofitable area per county:


DROP TABLE IF EXISTS profit_250_ap_township_county;
CREATE TABLE profit_250_ap_township_county
AS SELECT
t2.co_name,
t1.*
FROM profit_250_ap_township AS t1
INNER JOIN counties_twp AS t2
ON t1.twpid::int = t2.twpid
ORDER BY co_name;
