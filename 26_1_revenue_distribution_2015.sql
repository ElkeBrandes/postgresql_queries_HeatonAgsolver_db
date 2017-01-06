-- create a new table revenue_rounded, taking yields from heaton_results


DROP TABLE IF EXISTS revenue_rounded_2015;
CREATE TABLE revenue_rounded_2015
AS SELECT 
cluid || mukey AS cluid_mukey,
clumuacres,
ccrop,
yield_2015
FROM crop_budgets_per_clumu_2015_twp_yields;


alter table revenue_rounded_2015
add column corn_rev_2015 float4,
add column soy_rev_2015 float4;


-- calculate corn and soybean revenue by multiplying yield with price for each year

-- 2015:
update revenue_rounded_2015
set corn_rev_2015 = round((yield_2015::NUMERIC * 3.5) * 2.471,0)
where ccrop = 'CG';

update revenue_rounded_2015
set soy_rev_2015 = round((yield_2015::NUMERIC * 9.00) * 2.471,0)
where ccrop = 'SB';


-- aggregate to same yield values

DROP TABLE IF EXISTS corn_rev_aggregated_2015;
CREATE TABLE corn_rev_aggregated_2015
AS SELECT
corn_rev_2015,
sum(clumuacres::numeric / 2.471) AS corn_rev_2015_ha
FROM revenue_rounded_2015
GROUP BY corn_rev_2015;

DROP TABLE IF EXISTS soy_rev_aggregated_2015;
CREATE TABLE soy_rev_aggregated_2015
AS SELECT
soy_rev_2015,
sum(clumuacres::numeric / 2.471) AS soy_rev_2015_ha
FROM revenue_rounded_2015
GROUP BY soy_rev_2015;

