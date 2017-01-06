-- in this script I create a table that includes the NASS reported county average yields and the 
-- ISU survey reported county average cash rents, averaged over the time 2012-2015, and their relation. 
-- The aim is to understand strong county effects of the mean profitability data 2012-2015. 

-- in the table cash_rent_county_means, create a new column and calculate the mean values 2012-2015
/*
ALTER TABLE cash_rent_county_means
ADD COLUMN avg_rent_2012_2015 NUMERIC;

UPDATE cash_rent_county_means
SET avg_rent_2012_2015 = round(2.471 *(county_mean_rent_2012 + county_mean_rent_2013 + county_mean_rent_2014 + county_mean_rent_2015)/4, 2);
*/

DROP TABLE IF EXISTS "09_county_mean_yields_cashrents_2012_2015";
CREATE TABLE "09_county_mean_yields_cashrents_2012_2015"
AS WITH 
yield_cg_table AS (
SELECT
fips,
round(avg(("Value"::NUMERIC/ 39.368) * 2471),0) AS cg_yield
FROM nass_cgsb_yields_2011_2015
WHERE "Commodity" = 'CG'
GROUP BY fips
),
 yield_sb_table AS (
SELECT
fips,
round(avg(("Value"::NUMERIC/ 36.7437) * 2471),0) AS sb_yield
FROM nass_cgsb_yields_2011_2015
WHERE "Commodity" = 'SB'
GROUP BY fips
)
SELECT
t1.fips,
t1.cg_yield,
t2.sb_yield,
t3.avg_rent_2012_2015
FROM yield_cg_table AS t1
INNER JOIN yield_sb_table AS t2 ON t1.fips = t2.fips
INNER JOIN cash_rent_county_means AS t3 ON t1.fips = t3.fips;

