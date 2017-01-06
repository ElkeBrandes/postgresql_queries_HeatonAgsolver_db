-- filter for profits lower than -250:

DROP TABLE IF EXISTS "profit-120_250_sa";
CREATE TABLE "profit-120_250_sa"
AS SELECT
co_name,
twpid,
clumuacres,
"profit-120_2015" AS profit_sa_budget1_ha
FROM crop_budgets_per_clumu_2015_twp_yields
WHERE "profit-120_2015" <= -250.0;


DROP TABLE IF EXISTS "profit-90_250_sa";
CREATE TABLE "profit-90_250_sa"
AS SELECT
co_name,
twpid,
clumuacres,
"profit-90_2015" AS profit_sa_budget2_ha
FROM crop_budgets_per_clumu_2015_twp_yields
WHERE "profit-90_2015" <= -250.0;

DROP TABLE IF EXISTS "profit-60_250_sa";
CREATE TABLE "profit-60_250_sa"
AS SELECT
co_name,
twpid,
clumuacres,
"profit-60_2015" AS profit_sa_budget3_ha
FROM crop_budgets_per_clumu_2015_twp_yields
WHERE "profit-60_2015" <= -250.0;

DROP TABLE IF EXISTS "profit-30_250_sa";
CREATE TABLE "profit-30_250_sa"
AS SELECT
co_name,
twpid,
clumuacres,
"profit-30_2015" AS profit_sa_budget4_ha
FROM crop_budgets_per_clumu_2015_twp_yields
WHERE "profit-30_2015" <= -250.0;

DROP TABLE IF EXISTS "profit_2015_250_sa";
CREATE TABLE "profit_2015_250_sa"
AS SELECT
co_name,
twpid,
clumuacres,
profit_2015 AS profit_2015_ha
FROM crop_budgets_per_clumu_2015_twp_yields
WHERE profit_2015 <= -250.0;

DROP TABLE IF EXISTS "profit+30_250_sa";
CREATE TABLE "profit+30_250_sa"
AS SELECT
co_name,
twpid,
clumuacres,
"profit+30_2015" AS profit_sa_budget5_ha
FROM crop_budgets_per_clumu_2015_twp_yields
WHERE "profit+30_2015" <= -250.0;

DROP TABLE IF EXISTS "profit+60_250_sa";
CREATE TABLE "profit+60_250_sa"
AS SELECT
co_name,
twpid,
clumuacres,
"profit+60_2015" AS profit_sa_budget6_ha
FROM crop_budgets_per_clumu_2015_twp_yields
WHERE "profit+60_2015" <= -250.0;

DROP TABLE IF EXISTS "profit+90_250_sa";
CREATE TABLE "profit+90_250_sa"
AS SELECT
co_name,
twpid,
clumuacres,
"profit+90_2015" AS profit_sa_budget7_ha
FROM crop_budgets_per_clumu_2015_twp_yields
WHERE "profit+90_2015" <= -250.0;

DROP TABLE IF EXISTS "profit+120_250_sa";
CREATE TABLE "profit+120_250_sa"
AS SELECT
co_name,
twpid,
clumuacres,
"profit+120_2015" AS profit_sa_budget8_ha
FROM crop_budgets_per_clumu_2015_twp_yields
WHERE "profit+120_2015" <= -250.0;
