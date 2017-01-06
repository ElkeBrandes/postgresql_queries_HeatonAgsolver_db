-- aggregate to township:
/*
DROP TABLE IF EXISTS "profit-120_250_sa_totals";
CREATE TABLE "profit-120_250_sa_totals"
AS SELECT
twpid,
sum(clumuacres::numeric)/2.471 AS "profit-120_2015_ha"
FROM "profit-120_250_sa"
GROUP BY twpid;

DROP TABLE IF EXISTS "profit-90_250_sa_totals";
CREATE TABLE "profit-90_250_sa_totals"
AS SELECT
twpid,
sum(clumuacres::numeric)/2.471 AS "profit-90_2015_ha"
FROM "profit-90_250_sa"
GROUP BY twpid;

DROP TABLE IF EXISTS "profit-60_250_sa_totals";
CREATE TABLE "profit-60_250_sa_totals"
AS SELECT
twpid,
sum(clumuacres::numeric)/2.471 AS "profit-60_2015_ha"
FROM "profit-60_250_sa"
GROUP BY twpid;

DROP TABLE IF EXISTS "profit-30_250_sa_totals";
CREATE TABLE "profit-30_250_sa_totals"
AS SELECT
twpid,
sum(clumuacres::numeric)/2.471 AS "profit-30_2015_ha"
FROM "profit-30_250_sa"
GROUP BY twpid;

DROP TABLE IF EXISTS "profit_2015_250_sa_totals";
CREATE TABLE "profit_2015_250_sa_totals"
AS SELECT
twpid,
sum(clumuacres::numeric)/2.471 AS "profit_2015_ha"
FROM "profit_2015_250_sa"
GROUP BY twpid;

DROP TABLE IF EXISTS "profit+30_250_sa_totals";
CREATE TABLE "profit+30_250_sa_totals"
AS SELECT
twpid,
sum(clumuacres::numeric)/2.471 AS "profit+30_2015_ha"
FROM "profit+30_250_sa"
GROUP BY twpid;

DROP TABLE IF EXISTS "profit+60_250_sa_totals";
CREATE TABLE "profit+60_250_sa_totals"
AS SELECT
twpid,
sum(clumuacres::numeric)/2.471 AS "profit+60_2015_ha"
FROM "profit+60_250_sa"
GROUP BY twpid;

DROP TABLE IF EXISTS "profit+90_250_sa_totals";
CREATE TABLE "profit+90_250_sa_totals"
AS SELECT
twpid,
sum(clumuacres::numeric)/2.471 AS "profit+90_2015_ha"
FROM "profit+90_250_sa"
GROUP BY twpid;

DROP TABLE IF EXISTS "profit+120_250_sa_totals";
CREATE TABLE "profit+120_250_sa_totals"
AS SELECT
twpid,
sum(clumuacres::numeric)/2.471 AS "profit+120_2015_ha"
FROM "profit+120_250_sa"
GROUP BY twpid;


-- table with total ha per township in rowcrop:

DROP TABLE IF EXISTS twp_total_ha;
CREATE TABLE twp_total_ha
AS SELECT
twpid,
sum(clumuacres::NUMERIC)/2.471 AS total_ha
FROM crop_budgets_per_clumu_2015_twp_yields
GROUP BY twpid;

-- Join the tables above:

DROP TABLE IF EXISTS sa_join1;
CREATE TABLE sa_join1
AS SELECT
t1.twpid,
t1.total_ha,
t2."profit-120_2015_ha"
FROM twp_total_ha t1
LEFT OUTER JOIN "profit-120_250_sa_totals" t2
ON t1.twpid = t2.twpid;

DROP TABLE IF EXISTS sa_join2;
CREATE TABLE sa_join2
AS SELECT
t1.*,
t2."profit-90_2015_ha"
FROM sa_join1 t1
LEFT OUTER JOIN "profit-90_250_sa_totals" t2
ON t1.twpid = t2.twpid;

DROP TABLE IF EXISTS sa_join3;
CREATE TABLE sa_join3
AS SELECT
t1.*,
t2."profit-60_2015_ha"
FROM sa_join2 t1
LEFT OUTER JOIN "profit-60_250_sa_totals" t2
ON t1.twpid = t2.twpid;

DROP TABLE IF EXISTS sa_join4;
CREATE TABLE sa_join4
AS SELECT
t1.*,
t2."profit-30_2015_ha"
FROM sa_join3 t1
LEFT OUTER JOIN "profit-30_250_sa_totals" t2
ON t1.twpid = t2.twpid;

DROP TABLE IF EXISTS sa_join5;
CREATE TABLE sa_join5
AS SELECT
t1.*,
t2."profit_2015_ha"
FROM sa_join4 t1
LEFT OUTER JOIN "profit_2015_250_sa_totals" t2
ON t1.twpid = t2.twpid;

DROP TABLE IF EXISTS sa_join6;
CREATE TABLE sa_join6
AS SELECT
t1.*,
t2."profit+30_2015_ha"
FROM sa_join5 t1
LEFT OUTER JOIN "profit+30_250_sa_totals" t2
ON t1.twpid = t2.twpid;

DROP TABLE IF EXISTS sa_join7;
CREATE TABLE sa_join7
AS SELECT
t1.*,
t2."profit+60_2015_ha"
FROM sa_join6 t1
LEFT OUTER JOIN "profit+60_250_sa_totals" t2
ON t1.twpid = t2.twpid;

DROP TABLE IF EXISTS sa_join8;
CREATE TABLE sa_join8
AS SELECT
t1.*,
t2."profit+90_2015_ha"
FROM sa_join7 t1
LEFT OUTER JOIN "profit+90_250_sa_totals" t2
ON t1.twpid = t2.twpid;

DROP TABLE IF EXISTS profit_250_sa_township_2015_cashrents;
CREATE TABLE profit_250_sa_township_2015_cashrents
AS SELECT
t1.*,
t2."profit+120_2015_ha"
FROM sa_join8 t1
LEFT OUTER JOIN "profit+120_250_sa_totals" t2
ON t1.twpid = t2.twpid;




UPDATE profit_250_sa_township_2015_cashrents
SET "profit-120_2015_ha" = 0 WHERE "profit-120_2015_ha" IS  NULL;
UPDATE profit_250_sa_township_2015_cashrents
SET "profit-90_2015_ha" = 0 WHERE "profit-90_2015_ha" IS  NULL;
UPDATE profit_250_sa_township_2015_cashrents
SET "profit-60_2015_ha" = 0 WHERE "profit-60_2015_ha" IS  NULL;
UPDATE profit_250_sa_township_2015_cashrents
SET "profit-30_2015_ha" = 0 WHERE "profit-30_2015_ha" IS  NULL;
UPDATE profit_250_sa_township_2015_cashrents
SET profit_2015_ha = 0 WHERE profit_2015_ha IS  NULL;
UPDATE profit_250_sa_township_2015_cashrents
SET "profit+30_2015_ha" = 0 WHERE "profit+30_2015_ha" IS  NULL;
UPDATE profit_250_sa_township_2015_cashrents
SET "profit+60_2015_ha" = 0 WHERE "profit+60_2015_ha" IS  NULL;
UPDATE profit_250_sa_township_2015_cashrents
SET "profit+90_2015_ha" = 0 WHERE "profit+90_2015_ha" IS  NULL;
UPDATE profit_250_sa_township_2015_cashrents
SET "profit+120_2015_ha" = 0 WHERE "profit+120_2015_ha" IS  NULL;


-- for summing the ha up for Iowa in R, I need all data including the
-- townships with < 700 ha row crop land



DROP TABLE IF EXISTS profit_250_sa_township_2015_cashrents_r;
CREATE TABLE profit_250_sa_township_2015_cashrents_r
AS SELECT * FROM profit_250_sa_township_2015_cashrents;


-- for the map visualization, I changed all the township I don't want to show data for to 99999.

UPDATE profit_250_sa_township_2015_cashrents
SET "profit-120_2015_ha" = null WHERE total_ha < 700;
UPDATE profit_250_sa_township_2015_cashrents
SET "profit-90_2015_ha" = 99999 WHERE total_ha < 700;
UPDATE profit_250_sa_township_2015_cashrents
SET "profit-60_2015_ha" = 99999 WHERE total_ha < 700;
UPDATE profit_250_sa_township_2015_cashrents
SET "profit-30_2015_ha" = 99999 WHERE total_ha < 700;
UPDATE profit_250_sa_township_2015_cashrents
SET "profit_2015_ha" = 99999 WHERE total_ha < 700;
UPDATE profit_250_sa_township_2015_cashrents
SET "profit+30_2015_ha" = 99999 WHERE total_ha < 700;
UPDATE profit_250_sa_township_2015_cashrents
SET "profit+60_2015_ha" = 99999 WHERE total_ha < 700;
UPDATE profit_250_sa_township_2015_cashrents
SET "profit+90_2015_ha" = 99999 WHERE total_ha < 700;
UPDATE profit_250_sa_township_2015_cashrents
SET "profit+120_2015_ha" = 99999 WHERE total_ha < 700;
*/

UPDATE profit_250_sa_township_2015_cashrents
SET "profit-120_2015_ha" = null WHERE "profit-120_2015_ha" = 99999;
UPDATE profit_250_sa_township_2015_cashrents
SET "profit-90_2015_ha" = null WHERE "profit-90_2015_ha" = 99999;
UPDATE profit_250_sa_township_2015_cashrents
SET "profit-60_2015_ha" = null WHERE "profit-60_2015_ha" = 99999 ;
UPDATE profit_250_sa_township_2015_cashrents
SET "profit-30_2015_ha" = null WHERE "profit-30_2015_ha" = 99999;
UPDATE profit_250_sa_township_2015_cashrents
SET "profit_2015_ha" = null WHERE "profit_2015_ha" = 99999;
UPDATE profit_250_sa_township_2015_cashrents
SET "profit+30_2015_ha" = null WHERE "profit+30_2015_ha" = 99999;
UPDATE profit_250_sa_township_2015_cashrents
SET "profit+60_2015_ha" = null WHERE "profit+60_2015_ha" = 99999;
UPDATE profit_250_sa_township_2015_cashrents
SET "profit+90_2015_ha" = null WHERE "profit+90_2015_ha" = 99999;
UPDATE profit_250_sa_township_2015_cashrents
SET "profit+120_2015_ha" = null WHERE "profit+120_2015_ha" = 99999;
