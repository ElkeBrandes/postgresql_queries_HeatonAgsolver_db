-- yield distribution of corn and soybean in the state, on a CLU-mapunit level:

-- to reduce the number of records, first round yield (in metric units) to two decimals, then aggregate over equal values

/*
DROP TABLE IF EXISTS yield_rounded_2015;
CREATE TABLE yield_rounded_2015
AS SELECT
co_name,
twpid,
cluid_mukey,
clumuacres,
(CASE WHEN ccrop = 'CG' THEN round(yield_2015::NUMERIC*25.4012*0.001*2.471,2) ELSE NULL END) AS round_corn_yield_2015,
(CASE WHEN ccrop = 'SB' THEN round(yield_2015::numeric*27.2155*0.001*2.471,2) ELSE NULL END) AS round_soy_yield_2015
FROM crop_budgets_per_clumu_2015_twp_yields;
*/




DROP TABLE IF EXISTS corn_yield_aggregated_2015;
CREATE TABLE corn_yield_aggregated_2015
AS SELECT
round_corn_yield_2015,
sum(clumuacres::numeric / 2.471) AS corn_yield_2015_ha
FROM yield_rounded_2015
GROUP BY round_corn_yield_2015;

DROP TABLE IF EXISTS soy_yield_aggregated_2015;
CREATE TABLE soy_yield_aggregated_2015
AS SELECT
round_soy_yield_2015,
sum(clumuacres::numeric / 2.471) AS soy_yield_2015_ha
FROM yield_rounded_2015
GROUP BY round_soy_yield_2015;

