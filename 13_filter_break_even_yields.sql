-- filter out the yields needed to break even and the difference between breakeven yield and actual yields
DROP TABLE IF EXISTS "profit-120_500_sa";
CREATE TABLE "profit-120_500_sa"
AS SELECT
co_name,
twpid,
clumuacres,
yield_even,
yield-yield_even
FROM profit_per_clumu_2015_sa
WHERE profit_2015 * 2.417 <= 0;

-- filter out the yields needed to reach a profit of -500 $/ha and the difference between that yield and actual yields
DROP TABLE IF EXISTS "profit-120_500_sa";
CREATE TABLE "profit-120_500_sa"
AS SELECT
co_name,
twpid,
clumuacres,
"yield_-500",
"yield-yield_-500"
FROM profit_per_clumu_2015_sa
WHERE profit_2015 * 2.417 <= -500;