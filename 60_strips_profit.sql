-- export data from table clumu_cgsb_profit_2011_2014, selecting 2012 and 2014 subfield profit 
-- for Pocahontas County (IA076) only, for a test on a HUC 12 watershed.

DROP TABLE IF EXISTS "60_profit_2012_2014_IA151";
CREATE TABLE "60_profit_2012_2014_IA151"
AS 
WITH table_2012 AS 
(
SELECT 
cluid_mukey AS cluid_mukey12,
round(profit,0) AS profit12
FROM clumu_cgsb_profit_2011_2014
WHERE year = '2012'
)
SELECT 
t1.cluid_mukey,
t2.profit12,
round(t1.profit,0) AS profit14
FROM clumu_cgsb_profit_2011_2014 AS t1
RIGHT JOIN table_2012 AS t2 ON t1.cluid_mukey = t2.cluid_mukey12
WHERE year = '2014' AND fips = 'IA151';

