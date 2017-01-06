-- transform clumu_cgsb_profit_2011_2014_single_crop into a table that includes the profits in 2012 and 2014 as separate columns 
-- convert english to metric units


DROP TABLE IF EXISTS cgsb_profit_surface_2012_2014;
CREATE TABLE cgsb_profit_surface_2012_2014
AS WITH
table12 AS (
SELECT
fips,
cluid_mukey,
round(profit_cg::NUMERIC * 2.471,0) AS profit_cg_2012,
round(profit_sb::NUMERIC * 2.471,0) AS profit_sb_2012
FROM clumu_cgsb_profit_2011_2014_single_crop
WHERE year = 2012),
table14 AS (
SELECT
cluid_mukey,
round(profit_cg::NUMERIC * 2.471,0) AS profit_cg_2014,
round(profit_sb::NUMERIC * 2.471,0) AS profit_sb_2014
FROM clumu_cgsb_profit_2011_2014_single_crop
WHERE year = 2014)
SELECT
t1.*,
t2.profit_cg_2014,
t2.profit_sb_2014
FROM table12 as t1
LEFT JOIN table14 as t2
ON t1.cluid_mukey = t2.cluid_mukey;

