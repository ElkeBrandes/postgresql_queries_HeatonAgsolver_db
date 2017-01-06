-- add columns with changed prices: plus minus 30% from 2015 prices, in 10% steps

/*
alter table crop_budgets_per_clumu_2015_twp_yields
add column "profit_sa_p_0.10" float4,
add column "profit_sa_p_0.14" float4,
add column "profit_sa_p_0.18" float4,
add column "profit_sa_p_0.22" float4,
add column "profit_sa_p_0.26" float4,
add column "profit_sa_p_0.30" float4;
*/
-- calculate profits with adjusted corn and soybean prices
-- 2015 yields

update crop_budgets_per_clumu_2015_twp_yields
set "profit_sa_p_0.10" = (( NULLIF(yield_2015::NUMERIC,0) * 2.49 ) - ( clu_adj_rent_2015 + "budget_2015")) * 2.471
where ccrop = 'CG';

update crop_budgets_per_clumu_2015_twp_yields
set "profit_sa_p_0.10" = (( NULLIF(yield_2015::NUMERIC,0)* 7.37 ) - ( clu_adj_rent_2015 + "budget_2015")) * 2.471
where ccrop = 'SB';

update crop_budgets_per_clumu_2015_twp_yields
set "profit_sa_p_0.14" = (( NULLIF(yield_2015::NUMERIC,0) * 3.50 ) - ( clu_adj_rent_2015 + "budget_2015")) * 2.471
where ccrop = 'CG';

update crop_budgets_per_clumu_2015_twp_yields
set "profit_sa_p_0.14" = (( NULLIF(yield_2015::NUMERIC,0)* 9.00 ) - ( clu_adj_rent_2015 + "budget_2015")) * 2.471
where ccrop = 'SB';

update crop_budgets_per_clumu_2015_twp_yields
set "profit_sa_p_0.18" = (( NULLIF(yield_2015::NUMERIC,0) * 4.51 ) - ( clu_adj_rent_2015 + "budget_2015")) * 2.471
where ccrop = 'CG';

update crop_budgets_per_clumu_2015_twp_yields
set "profit_sa_p_0.18" = (( NULLIF(yield_2015::NUMERIC,0)* 10.63) - ( clu_adj_rent_2015 + "budget_2015")) * 2.471
where ccrop = 'SB';

update crop_budgets_per_clumu_2015_twp_yields
set "profit_sa_p_0.22" = (( NULLIF(yield_2015::NUMERIC,0) * 5.52 ) - ( clu_adj_rent_2015 + "budget_2015")) * 2.471
where ccrop = 'CG';

update crop_budgets_per_clumu_2015_twp_yields
set "profit_sa_p_0.22" = (( NULLIF(yield_2015::NUMERIC,0)* 12.26 ) - ( clu_adj_rent_2015 + "budget_2015")) * 2.471
where ccrop = 'SB';

update crop_budgets_per_clumu_2015_twp_yields
set "profit_sa_p_0.26" = (( NULLIF(yield_2015::NUMERIC,0) * 6.63 ) - ( clu_adj_rent_2015 + "budget_2015")) * 2.471
where ccrop = 'CG';

update crop_budgets_per_clumu_2015_twp_yields
set "profit_sa_p_0.26" = (( NULLIF(yield_2015::NUMERIC,0)* 13.89 ) - ( clu_adj_rent_2015 + "budget_2015")) * 2.471
where ccrop = 'SB';

update crop_budgets_per_clumu_2015_twp_yields
set "profit_sa_p_0.30" = (( NULLIF(yield_2015::NUMERIC,0) * 7.64 ) - ( clu_adj_rent_2015 + "budget_2015")) * 2.471
where ccrop = 'CG';

update crop_budgets_per_clumu_2015_twp_yields
set "profit_sa_p_0.30" = (( NULLIF(yield_2015::NUMERIC,0)* 15.52 ) - ( clu_adj_rent_2015 + "budget_2015")) * 2.471
where ccrop = 'SB';


-- filter for $-500/ha:
/*
DROP TABLE IF EXISTS "profit_p_0.10_sa";
CREATE TABLE "profit_p_0.10_sa"
AS SELECT
co_name,
twpid,
clumuacres,
"profit_sa_p_0.10"
FROM crop_budgets_per_clumu_2015_twp_yields
WHERE "profit_sa_p_0.10" <= -500.0;

DROP TABLE IF EXISTS "profit_p_0.14_sa";
CREATE TABLE "profit_p_0.14_sa"
AS SELECT
co_name,
twpid,
clumuacres,
"profit_sa_p_0.14"
FROM crop_budgets_per_clumu_2015_twp_yields
WHERE "profit_sa_p_0.14" <= -500.0;

DROP TABLE IF EXISTS "profit_p_0.18_sa";
CREATE TABLE "profit_p_0.18_sa"
AS SELECT
co_name,
twpid,
clumuacres,
"profit_sa_p_0.18"
FROM crop_budgets_per_clumu_2015_twp_yields
WHERE "profit_sa_p_0.18" <= -500.0;

DROP TABLE IF EXISTS "profit_p_0.22_sa";
CREATE TABLE "profit_p_0.22_sa"
AS SELECT
co_name,
twpid,
clumuacres,
"profit_sa_p_0.22"
FROM crop_budgets_per_clumu_2015_twp_yields
WHERE "profit_sa_p_0.22" <= -500.0;

DROP TABLE IF EXISTS "profit_p_0.26_sa";
CREATE TABLE "profit_p_0.26_sa"
AS SELECT
co_name,
twpid,
clumuacres,
"profit_sa_p_0.26"
FROM crop_budgets_per_clumu_2015_twp_yields
WHERE "profit_sa_p_0.26" <= -500.0;

DROP TABLE IF EXISTS "profit_p_0.30_sa";
CREATE TABLE "profit_p_0.30_sa"
AS SELECT
co_name,
twpid,
clumuacres,
"profit_sa_p_0.30"
FROM crop_budgets_per_clumu_2015_twp_yields
WHERE "profit_sa_p_0.30" <= -500.0;
*/
-- aggregate to township:
/*
DROP TABLE IF EXISTS "profit_p_0.10_sa_totals";
CREATE TABLE "profit_p_0.10_sa_totals"
AS SELECT
twpid,
sum(clumuacres::numeric)/2.471 AS "profit_sa_p_0.10_ha"
FROM "profit_p_0.10_sa"
GROUP BY twpid;

DROP TABLE IF EXISTS "profit_p_0.14_sa_totals";
CREATE TABLE "profit_p_0.14_sa_totals"
AS SELECT
twpid,
sum(clumuacres::numeric)/2.471 AS "profit_sa_p_0.14_ha"
FROM "profit_p_0.14_sa"
GROUP BY twpid;

DROP TABLE IF EXISTS "profit_p_0.18_sa_totals";
CREATE TABLE "profit_p_0.18_sa_totals"
AS SELECT
twpid,
sum(clumuacres::numeric)/2.471 AS "profit_sa_p_0.18_ha"
FROM "profit_p_0.18_sa"
GROUP BY twpid;

DROP TABLE IF EXISTS "profit_p_0.22_sa_totals";
CREATE TABLE "profit_p_0.22_sa_totals"
AS SELECT
twpid,
sum(clumuacres::numeric)/2.471 AS "profit_sa_p_0.22_ha"
FROM "profit_p_0.22_sa"
GROUP BY twpid;

DROP TABLE IF EXISTS "profit_p_0.26_sa_totals";
CREATE TABLE "profit_p_0.26_sa_totals"
AS SELECT
twpid,
sum(clumuacres::numeric)/2.471 AS "profit_sa_p_0.26_ha"
FROM "profit_p_0.26_sa"
GROUP BY twpid;

DROP TABLE IF EXISTS "profit_p_0.30_sa_totals";
CREATE TABLE "profit_p_0.30_sa_totals"
AS SELECT
twpid,
sum(clumuacres::numeric)/2.471 AS "profit_sa_p_0.30_ha"
FROM "profit_p_0.30_sa"
GROUP BY twpid;
*/

-- join the tables above:



DROP TABLE IF EXISTS sa_p_join1;
CREATE TABLE sa_p_join1
AS SELECT
t1.*,
t2."profit_sa_p_0.14_ha"
FROM "profit_p_0.10_sa_totals" t1
LEFT OUTER JOIN "profit_p_0.14_sa_totals" t2
ON t1.twpid = t2.twpid;

DROP TABLE IF EXISTS sa_p_join2;
CREATE TABLE sa_p_join2
AS SELECT
t1.*,
t2."profit_sa_p_0.18_ha"
FROM "sa_p_join1" t1
LEFT OUTER JOIN "profit_p_0.18_sa_totals" t2
ON t1.twpid = t2.twpid;

DROP TABLE IF EXISTS sa_p_join3;
CREATE TABLE sa_p_join3
AS SELECT
t1.*,
t2."profit_sa_p_0.22_ha"
FROM "sa_p_join2" t1
LEFT OUTER JOIN "profit_p_0.22_sa_totals" t2
ON t1.twpid = t2.twpid;

DROP TABLE IF EXISTS sa_p_join4;
CREATE TABLE sa_p_join4
AS SELECT
t1.*,
t2."profit_sa_p_0.26_ha"
FROM "sa_p_join3" t1
LEFT OUTER JOIN "profit_p_0.26_sa_totals" t2
ON t1.twpid = t2.twpid;

DROP TABLE IF EXISTS profit_p_500_sa_township;
CREATE TABLE profit_p_500_sa_township
AS SELECT
t1.*,
t2."profit_sa_p_0.30_ha"
FROM "sa_p_join4" t1
LEFT OUTER JOIN "profit_p_0.30_sa_totals" t2
ON t1.twpid = t2.twpid;


-- set values = 0 where they are NULL

UPDATE profit_p_500_sa_township
SET "profit_sa_p_0.10_ha" = 0 WHERE "profit_sa_p_0.10_ha" IS  NULL;
UPDATE profit_p_500_sa_township
SET "profit_sa_p_0.14_ha" = 0 WHERE "profit_sa_p_0.14_ha" IS  NULL;
UPDATE profit_p_500_sa_township
SET "profit_sa_p_0.18_ha" = 0 WHERE "profit_sa_p_0.18_ha" IS  NULL;
UPDATE profit_p_500_sa_township
SET "profit_sa_p_0.22_ha" = 0 WHERE "profit_sa_p_0.22_ha" IS  NULL;
UPDATE profit_p_500_sa_township
SET "profit_sa_p_0.26_ha" = 0 WHERE "profit_sa_p_0.26_ha" IS  NULL;
UPDATE profit_p_500_sa_township
SET "profit_sa_p_0.30_ha" = 0 WHERE "profit_sa_p_0.30_ha" IS  NULL;
