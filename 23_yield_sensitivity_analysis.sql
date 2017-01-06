

-- add columns with changed yields: plus minus 30% from 2015 yields, in 10% steps

/*
alter table crop_budgets_per_clumu_2015_twp_yields
add column "profit_sa_y-30" float4,
add column "profit_sa_y-20" float4,
add column "profit_sa_y-10" float4,
add column "profit_sa_y+10" float4,
add column "profit_sa_y+20" float4,
add column "profit_sa_y+30" float4;
*/
-- calculate profits with adjusted yields
/*
update crop_budgets_per_clumu_2015_twp_yields
set "profit_sa_y-30" = (( NULLIF(yield_2015::NUMERIC,0)* 0.7 * 3.5 ) - ( clu_adj_rent_2015 + "budget_2015")) * 2.471
where ccrop = 'CG';

update crop_budgets_per_clumu_2015_twp_yields
set "profit_sa_y-30" = (( NULLIF(yield_2015::NUMERIC,0)*0.7 * 9 ) - ( clu_adj_rent_2015 + "budget_2015")) * 2.471
where ccrop = 'SB';

update crop_budgets_per_clumu_2015_twp_yields
set "profit_sa_y-20" = (( NULLIF(yield_2015::NUMERIC,0)* 0.8 * 3.5 ) - ( clu_adj_rent_2015 + "budget_2015")) * 2.471
where ccrop = 'CG';

update crop_budgets_per_clumu_2015_twp_yields
set "profit_sa_y-20" = (( NULLIF(yield_2015::NUMERIC,0)*0.8 * 9 ) - ( clu_adj_rent_2015 + "budget_2015")) * 2.471
where ccrop = 'SB';

update crop_budgets_per_clumu_2015_twp_yields
set "profit_sa_y-10" = (( NULLIF(yield_2015::NUMERIC,0)* 0.9 * 3.5 ) - ( clu_adj_rent_2015 + "budget_2015")) * 2.471
where ccrop = 'CG';

update crop_budgets_per_clumu_2015_twp_yields
set "profit_sa_y-10" = (( NULLIF(yield_2015::NUMERIC,0)*0.9 * 9 ) - ( clu_adj_rent_2015 + "budget_2015")) * 2.471
where ccrop = 'SB';

update crop_budgets_per_clumu_2015_twp_yields
set "profit_sa_y+10" = (( NULLIF(yield_2015::NUMERIC,0)* 1.1 * 3.5 ) - ( clu_adj_rent_2015 + "budget_2015")) * 2.471
where ccrop = 'CG';

update crop_budgets_per_clumu_2015_twp_yields
set "profit_sa_y+10" = (( NULLIF(yield_2015::NUMERIC,0)*1.1 * 9 ) - ( clu_adj_rent_2015 + "budget_2015")) * 2.471
where ccrop = 'SB';

update crop_budgets_per_clumu_2015_twp_yields
set "profit_sa_y+20" = (( NULLIF(yield_2015::NUMERIC,0)* 1.2 * 3.5 ) - ( clu_adj_rent_2015 + "budget_2015")) * 2.471
where ccrop = 'CG';

update crop_budgets_per_clumu_2015_twp_yields
set "profit_sa_y+20" = (( NULLIF(yield_2015::NUMERIC,0)*1.2 * 9 ) - ( clu_adj_rent_2015 + "budget_2015")) * 2.471
where ccrop = 'SB';

update crop_budgets_per_clumu_2015_twp_yields
set "profit_sa_y+30" = (( NULLIF(yield_2015::NUMERIC,0)* 1.3 * 3.5 ) - ( clu_adj_rent_2015 + "budget_2015")) * 2.471
where ccrop = 'CG';

update crop_budgets_per_clumu_2015_twp_yields
set "profit_sa_y+30" = (( NULLIF(yield_2015::NUMERIC,0)*1.3 * 9 ) - ( clu_adj_rent_2015 + "budget_2015")) * 2.471
where ccrop = 'SB';
*/

-- filter for $-500/ha:
/*
DROP TABLE IF EXISTS "profit_y-30_sa";
CREATE TABLE "profit_y-30_sa"
AS SELECT
co_name,
twpid,
clumuacres,
"profit_sa_y-30"
FROM crop_budgets_per_clumu_2015_twp_yields
WHERE "profit_sa_y-30" <= -500.0;

DROP TABLE IF EXISTS "profit_y-20_sa";
CREATE TABLE "profit_y-20_sa"
AS SELECT
co_name,
twpid,
clumuacres,
"profit_sa_y-20"
FROM crop_budgets_per_clumu_2015_twp_yields
WHERE "profit_sa_y-20" <= -500.0;

DROP TABLE IF EXISTS "profit_y-10_sa";
CREATE TABLE "profit_y-10_sa"
AS SELECT
co_name,
twpid,
clumuacres,
"profit_sa_y-10"
FROM crop_budgets_per_clumu_2015_twp_yields
WHERE "profit_sa_y-10" <= -500.0;

DROP TABLE IF EXISTS "profit_y+10_sa";
CREATE TABLE "profit_y+10_sa"
AS SELECT
co_name,
twpid,
clumuacres,
"profit_sa_y+10"
FROM crop_budgets_per_clumu_2015_twp_yields
WHERE "profit_sa_y+10" <= -500.0;

DROP TABLE IF EXISTS "profit_y+20_sa";
CREATE TABLE "profit_y+20_sa"
AS SELECT
co_name,
twpid,
clumuacres,
"profit_sa_y+20"
FROM crop_budgets_per_clumu_2015_twp_yields
WHERE "profit_sa_y+20" <= -500.0;

DROP TABLE IF EXISTS "profit_y+30_sa";
CREATE TABLE "profit_y+30_sa"
AS SELECT
co_name,
twpid,
clumuacres,
"profit_sa_y+30"
FROM crop_budgets_per_clumu_2015_twp_yields
WHERE "profit_sa_y+30" <= -500.0;
*/

-- aggregate to township:
/*
DROP TABLE IF EXISTS "profit_y-30_sa_totals";
CREATE TABLE "profit_y-30_sa_totals"
AS SELECT
twpid,
sum(clumuacres::numeric)/2.471 AS "profit_sa_y-30_ha"
FROM "profit_y-30_sa"
GROUP BY twpid;

DROP TABLE IF EXISTS "profit_y-20_sa_totals";
CREATE TABLE "profit_y-20_sa_totals"
AS SELECT
twpid,
sum(clumuacres::numeric)/2.471 AS "profit_sa_y-20_ha"
FROM "profit_y-20_sa"
GROUP BY twpid;

DROP TABLE IF EXISTS "profit_y-10_sa_totals";
CREATE TABLE "profit_y-10_sa_totals"
AS SELECT
twpid,
sum(clumuacres::numeric)/2.471 AS "profit_sa_y-10_ha"
FROM "profit_y-10_sa"
GROUP BY twpid;

DROP TABLE IF EXISTS "profit_y+10_sa_totals";
CREATE TABLE "profit_y+10_sa_totals"
AS SELECT
twpid,
sum(clumuacres::numeric)/2.471 AS "profit_sa_y+10_ha"
FROM "profit_y+10_sa"
GROUP BY twpid;

DROP TABLE IF EXISTS "profit_y+20_sa_totals";
CREATE TABLE "profit_y+20_sa_totals"
AS SELECT
twpid,
sum(clumuacres::numeric)/2.471 AS "profit_sa_y+20_ha"
FROM "profit_y+20_sa"
GROUP BY twpid;

DROP TABLE IF EXISTS "profit_y+30_sa_totals";
CREATE TABLE "profit_y+30_sa_totals"
AS SELECT
twpid,
sum(clumuacres::numeric)/2.471 AS "profit_sa_y+30_ha"
FROM "profit_y+30_sa"
GROUP BY twpid;
*/

-- join the tables above:
/*
DROP TABLE IF EXISTS sa_y_join1;
CREATE TABLE sa_y_join1
AS SELECT
t1.*,
t2."profit_sa_y-20_ha"
FROM "profit_y-30_sa_totals" t1
LEFT OUTER JOIN "profit_y-20_sa_totals" t2
ON t1.twpid = t2.twpid;

DROP TABLE IF EXISTS sa_y_join2;
CREATE TABLE sa_y_join2
AS SELECT
t1.*,
t2."profit_sa_y-10_ha"
FROM sa_y_join1 t1
LEFT OUTER JOIN "profit_y-10_sa_totals" t2
ON t1.twpid = t2.twpid;

DROP TABLE IF EXISTS sa_y_join3;
CREATE TABLE sa_y_join3
AS SELECT
t1.*,
t2."profit_sa_y+10_ha"
FROM sa_y_join2 t1
LEFT OUTER JOIN "profit_y+10_sa_totals" t2
ON t1.twpid = t2.twpid;

DROP TABLE IF EXISTS sa_y_join4;
CREATE TABLE sa_y_join4
AS SELECT
t1.*,
t2."profit_sa_y+20_ha"
FROM sa_y_join3 t1
LEFT OUTER JOIN "profit_y+20_sa_totals" t2
ON t1.twpid = t2.twpid;

DROP TABLE IF EXISTS profit_y_500_sa_township;
CREATE TABLE profit_y_500_sa_township
AS SELECT
t1.*,
t2."profit_sa_y+30_ha"
FROM sa_y_join4 t1
LEFT OUTER JOIN "profit_y+30_sa_totals" t2
ON t1.twpid = t2.twpid;
*/

-- set values = 0 where they are NULL

UPDATE profit_y_500_sa_township
SET "profit_sa_y-30_ha" = 0 WHERE "profit_sa_y-30_ha" IS  NULL;
UPDATE profit_y_500_sa_township
SET "profit_sa_y-20_ha" = 0 WHERE "profit_sa_y-20_ha" IS  NULL;
UPDATE profit_y_500_sa_township
SET "profit_sa_y-10_ha" = 0 WHERE "profit_sa_y-10_ha" IS  NULL;
UPDATE profit_y_500_sa_township
SET "profit_sa_y+10_ha" = 0 WHERE "profit_sa_y+10_ha" IS  NULL;
UPDATE profit_y_500_sa_township
SET "profit_sa_y+20_ha" = 0 WHERE "profit_sa_y+20_ha" IS  NULL;
UPDATE profit_y_500_sa_township
SET "profit_sa_y+30_ha" = 0 WHERE "profit_sa_y+30_ha" IS  NULL;

DROP TABLE IF EXISTS profit_y_500_sa_township_r;
CREATE TABLE profit_y_500_sa_township_r
AS SELECT * FROM profit_y_500_sa_township;


-- for the map visualization, I changed all the township I don't want to show data for to 99999.
/*
UPDATE profit_y_500_sa_township
SET "profit_sa_y-30_ha" = 99999 WHERE total_ha < 700;
UPDATE profit_y_500_sa_township
SET "profit_sa_y-20_ha" = 99999 WHERE total_ha < 700;
UPDATE profit_y_500_sa_township
SET "profit_sa_y-10_ha" = 99999 WHERE total_ha < 700;
UPDATE profit_y_500_sa_township
SET "profit_sa_y+10_ha" = 99999 WHERE total_ha < 700;
UPDATE profit_y_500_sa_township
SET "profit_sa_y+20_ha" = 99999 WHERE total_ha < 700;
UPDATE profit_y_500_sa_township
SET "profit_sa_y+30_ha" = 99999 WHERE total_ha < 700;
*/