/*
-- create new table with subfield data only for Hamilton County (IA079)
DROP TABLE IF EXISTS "04_clumu_cgsb_profit_2011_2014_mean_IA079";
CREATE TABLE "04_clumu_cgsb_profit_2011_2014_mean_IA079"
AS SELECT
*
FROM "01_clumu_cgsb_profit_2011_2014_mean"
WHERE fips = 'IA079';
*/
/*
-- create new table with subfield data only for Carroll County (IA027)
DROP TABLE IF EXISTS "04_clumu_cgsb_profit_2011_2014_mean_IA027";
CREATE TABLE "04_clumu_cgsb_profit_2011_2014_mean_IA027"
AS SELECT
*
FROM "01_clumu_cgsb_profit_2011_2014_mean"
WHERE fips = 'IA027';
*/
-- create a new table with 2015 profit data only for Carrol County:

DROP TABLE IF EXISTS "04_clumu_cgsb_profit_2015_IA027";
CREATE TABLE "04_clumu_cgsb_profit_2015_IA027"
AS SELECT
fips,
cluid,
mukey,
profit_csr,
profit_csr2
FROM clumu_cgsb_profit_2012_2015
WHERE fips = 'IA027' AND year = '2015';