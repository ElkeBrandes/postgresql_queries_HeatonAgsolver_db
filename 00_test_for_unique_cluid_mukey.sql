-- test whethere there is one record per year for each cluid_mukey
-- count(cluid_mukey) should always be 4

DROP TABLE IF EXISTS "00_cluid_mukey_test";
CREATE TABLE "00_cluid_mukey_test"
AS SELECT
cluid_mukey,
count(cluid_mukey) AS clumucount
FROM clumu_cgsb_profit_2011_2014
GROUP BY cluid_mukey;