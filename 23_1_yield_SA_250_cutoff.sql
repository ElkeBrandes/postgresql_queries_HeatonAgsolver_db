
-- filter for $-250/ha:
/*
DROP TABLE IF EXISTS "profit_y-30_sa_250";
CREATE TABLE "profit_y-30_sa_250"
AS SELECT
co_name,
twpid,
clumuacres,
"profit_sa_y-30"
FROM crop_budgets_per_clumu_2015_twp_yields
WHERE "profit_sa_y-30" <= -250.0;

DROP TABLE IF EXISTS "profit_y-20_sa_250";
CREATE TABLE "profit_y-20_sa_250"
AS SELECT
co_name,
twpid,
clumuacres,
"profit_sa_y-20"
FROM crop_budgets_per_clumu_2015_twp_yields
WHERE "profit_sa_y-20" <= -250.0;

DROP TABLE IF EXISTS "profit_y-10_sa_250";
CREATE TABLE "profit_y-10_sa_250"
AS SELECT
co_name,
twpid,
clumuacres,
"profit_sa_y-10"
FROM crop_budgets_per_clumu_2015_twp_yields
WHERE "profit_sa_y-10" <= -250.0;

DROP TABLE IF EXISTS "profit_y+10_sa_250";
CREATE TABLE "profit_y+10_sa_250"
AS SELECT
co_name,
twpid,
clumuacres,
"profit_sa_y+10"
FROM crop_budgets_per_clumu_2015_twp_yields
WHERE "profit_sa_y+10" <= -250.0;

DROP TABLE IF EXISTS "profit_y+20_sa_250";
CREATE TABLE "profit_y+20_sa_250"
AS SELECT
co_name,
twpid,
clumuacres,
"profit_sa_y+20"
FROM crop_budgets_per_clumu_2015_twp_yields
WHERE "profit_sa_y+20" <= -250.0;

DROP TABLE IF EXISTS "profit_y+30_sa_250";
CREATE TABLE "profit_y+30_sa_250"
AS SELECT
co_name,
twpid,
clumuacres,
"profit_sa_y+30"
FROM crop_budgets_per_clumu_2015_twp_yields
WHERE "profit_sa_y+30" <= -250.0;


-- aggregate to township:

DROP TABLE IF EXISTS "profit_y-30_sa_250_totals";
CREATE TABLE "profit_y-30_sa_250_totals"
AS SELECT
twpid,
sum(clumuacres::numeric)/2.471 AS "profit_sa_y-30_ha"
FROM "profit_y-30_sa_250"
GROUP BY twpid;

DROP TABLE IF EXISTS "profit_y-20_sa_250_totals";
CREATE TABLE "profit_y-20_sa_250_totals"
AS SELECT
twpid,
sum(clumuacres::numeric)/2.471 AS "profit_sa_y-20_ha"
FROM "profit_y-20_sa_250"
GROUP BY twpid;

DROP TABLE IF EXISTS "profit_y-10_sa_250_totals";
CREATE TABLE "profit_y-10_sa_250_totals"
AS SELECT
twpid,
sum(clumuacres::numeric)/2.471 AS "profit_sa_y-10_ha"
FROM "profit_y-10_sa_250"
GROUP BY twpid;

DROP TABLE IF EXISTS "profit_y+10_sa_250_totals";
CREATE TABLE "profit_y+10_sa_250_totals"
AS SELECT
twpid,
sum(clumuacres::numeric)/2.471 AS "profit_sa_y+10_ha"
FROM "profit_y+10_sa_250"
GROUP BY twpid;

DROP TABLE IF EXISTS "profit_y+20_sa_250_totals";
CREATE TABLE "profit_y+20_sa_250_totals"
AS SELECT
twpid,
sum(clumuacres::numeric)/2.471 AS "profit_sa_y+20_ha"
FROM "profit_y+20_sa_250"
GROUP BY twpid;

DROP TABLE IF EXISTS "profit_y+30_sa_250_totals";
CREATE TABLE "profit_y+30_sa_250_totals"
AS SELECT
twpid,
sum(clumuacres::numeric)/2.471 AS "profit_sa_y+30_ha"
FROM "profit_y+30_sa_250"
GROUP BY twpid;


-- join the tables above:

DROP TABLE IF EXISTS sa_y_join1;
CREATE TABLE sa_y_join1
AS SELECT
t1.*,
t2."profit_sa_y-20_ha"
FROM "profit_y-30_sa_250_totals" t1
LEFT OUTER JOIN "profit_y-20_sa_250_totals" t2
ON t1.twpid = t2.twpid;

DROP TABLE IF EXISTS sa_y_join2;
CREATE TABLE sa_y_join2
AS SELECT
t1.*,
t2."profit_sa_y-10_ha"
FROM sa_y_join1 t1
LEFT OUTER JOIN "profit_y-10_sa_250_totals" t2
ON t1.twpid = t2.twpid;

DROP TABLE IF EXISTS sa_y_join3;
CREATE TABLE sa_y_join3
AS SELECT
t1.*,
t2."profit_sa_y+10_ha"
FROM sa_y_join2 t1
LEFT OUTER JOIN "profit_y+10_sa_250_totals" t2
ON t1.twpid = t2.twpid;

DROP TABLE IF EXISTS sa_y_join4;
CREATE TABLE sa_y_join4
AS SELECT
t1.*,
t2."profit_sa_y+20_ha"
FROM sa_y_join3 t1
LEFT OUTER JOIN "profit_y+20_sa_250_totals" t2
ON t1.twpid = t2.twpid;

DROP TABLE IF EXISTS sa_y_join5;
CREATE TABLE sa_y_join5
AS SELECT
t1.*,
t2."profit_sa_y+30_ha"
FROM sa_y_join4 t1
LEFT OUTER JOIN "profit_y+30_sa_250_totals" t2
ON t1.twpid = t2.twpid;


DROP TABLE IF EXISTS profit_y_250_sa_township;
CREATE TABLE profit_y_250_sa_township
AS SELECT
t1.*,
t2.total_ha
FROM sa_y_join5 t1
LEFT OUTER JOIN twp_total_ha t2
ON t1.twpid = t2.twpid;


-- set values = 0 where they are NULL

UPDATE profit_y_250_sa_township
SET "profit_sa_y-30_ha" = 0 WHERE "profit_sa_y-30_ha" IS  NULL;
UPDATE profit_y_250_sa_township
SET "profit_sa_y-20_ha" = 0 WHERE "profit_sa_y-20_ha" IS  NULL;
UPDATE profit_y_250_sa_township
SET "profit_sa_y-10_ha" = 0 WHERE "profit_sa_y-10_ha" IS  NULL;
UPDATE profit_y_250_sa_township
SET "profit_sa_y+10_ha" = 0 WHERE "profit_sa_y+10_ha" IS  NULL;
UPDATE profit_y_250_sa_township
SET "profit_sa_y+20_ha" = 0 WHERE "profit_sa_y+20_ha" IS  NULL;
UPDATE profit_y_250_sa_township
SET "profit_sa_y+30_ha" = 0 WHERE "profit_sa_y+30_ha" IS  NULL;

DROP TABLE IF EXISTS profit_y_250_sa_township_r;
CREATE TABLE profit_y_250_sa_township_r
AS SELECT * FROM profit_y_250_sa_township;

*/
-- for the map visualization, I changed all the township I don't want to show data for to 99999.

UPDATE profit_y_250_sa_township
SET "profit_sa_y-30_ha" = null WHERE total_ha < 700;
UPDATE profit_y_250_sa_township
SET "profit_sa_y-20_ha" = null WHERE total_ha < 700;
UPDATE profit_y_250_sa_township
SET "profit_sa_y-10_ha" = null WHERE total_ha < 700;
UPDATE profit_y_250_sa_township
SET "profit_sa_y+10_ha" = null WHERE total_ha < 700;
UPDATE profit_y_250_sa_township
SET "profit_sa_y+20_ha" = null WHERE total_ha < 700;
UPDATE profit_y_250_sa_township
SET "profit_sa_y+30_ha" = null WHERE total_ha < 700;
