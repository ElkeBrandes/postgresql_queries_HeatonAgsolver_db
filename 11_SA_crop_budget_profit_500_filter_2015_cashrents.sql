-- filter for profits lower than -500:

DROP TABLE IF EXISTS "profit-120_500_sa";
CREATE TABLE "profit-120_500_sa"
AS SELECT
co_name,
twpid,
clumuacres,
"profit-120_2015" * 2.471 AS profit_sa_budget1_ha
FROM crop_budgets_per_clumu_2015_twp_yields
WHERE "profit-120_2015" * 2.471 <= -500.0;


DROP TABLE IF EXISTS "profit-90_500_sa";
CREATE TABLE "profit-90_500_sa"
AS SELECT
co_name,
twpid,
clumuacres,
"profit-90_2015" * 2.471 AS profit_sa_budget2_ha
FROM crop_budgets_per_clumu_2015_twp_yields
WHERE "profit-90_2015" * 2.471 <= -500.0;

DROP TABLE IF EXISTS "profit-60_500_sa";
CREATE TABLE "profit-60_500_sa"
AS SELECT
co_name,
twpid,
clumuacres,
"profit-60_2015" * 2.471 AS profit_sa_budget3_ha
FROM crop_budgets_per_clumu_2015_twp_yields
WHERE "profit-60_2015" * 2.471 <= -500.0;

DROP TABLE IF EXISTS "profit-30_500_sa";
CREATE TABLE "profit-30_500_sa"
AS SELECT
co_name,
twpid,
clumuacres,
"profit-30_2015" * 2.471 AS profit_sa_budget4_ha
FROM crop_budgets_per_clumu_2015_twp_yields
WHERE "profit-30_2015" * 2.471 <= -500.0;

DROP TABLE IF EXISTS "profit_2015_500_sa";
CREATE TABLE "profit_2015_500_sa"
AS SELECT
co_name,
twpid,
clumuacres,
profit_2015 * 2.471 AS profit_2015_ha
FROM crop_budgets_per_clumu_2015_twp_yields
WHERE profit_2015 * 2.471 <= -500.0;

DROP TABLE IF EXISTS "profit+30_500_sa";
CREATE TABLE "profit+30_500_sa"
AS SELECT
co_name,
twpid,
clumuacres,
"profit+30_2015" * 2.471 AS profit_sa_budget5_ha
FROM crop_budgets_per_clumu_2015_twp_yields
WHERE "profit+30_2015" * 2.471 <= -500.0;

DROP TABLE IF EXISTS "profit+60_500_sa";
CREATE TABLE "profit+60_500_sa"
AS SELECT
co_name,
twpid,
clumuacres,
"profit+60_2015" * 2.471 AS profit_sa_budget6_ha
FROM crop_budgets_per_clumu_2015_twp_yields
WHERE "profit+60_2015" * 2.471 <= -500.0;

DROP TABLE IF EXISTS "profit+90_500_sa";
CREATE TABLE "profit+90_500_sa"
AS SELECT
co_name,
twpid,
clumuacres,
"profit+90_2015" * 2.471 AS profit_sa_budget7_ha
FROM crop_budgets_per_clumu_2015_twp_yields
WHERE "profit+90_2015" * 2.471 <= -500.0;

DROP TABLE IF EXISTS "profit+120_500_sa";
CREATE TABLE "profit+120_500_sa"
AS SELECT
co_name,
twpid,
clumuacres,
"profit+120_2015" * 2.471 AS profit_sa_budget8_ha
FROM crop_budgets_per_clumu_2015_twp_yields
WHERE "profit+120_2015" * 2.471 <= -500.0;
