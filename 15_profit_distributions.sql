-- profit distribution of corn and soybean in the state, on a CLU-mapunit level, 2010 - 2013:

-- to reduce the number of records, first round profit to the nearest $, then aggregate over the same amounts

/*
DROP TABLE IF EXISTS profit_rounded;
CREATE TABLE profit_rounded
AS SELECT
fips,
twpid,
cluid_mukey,
clumuacres,
(CASE WHEN crop1 = 'CG' THEN round(profit1::numeric,0) ELSE NULL END) AS round_corn_profit1,
(CASE WHEN crop1 = 'SB' THEN round(profit1::numeric,0) ELSE NULL END) AS round_soy_profit1,
(CASE WHEN crop2 = 'CG' THEN round(profit2::numeric,0) ELSE NULL END) AS round_corn_profit2,
(CASE WHEN crop2 = 'SB' THEN round(profit2::numeric,0) ELSE NULL END) AS round_soy_profit2,
(CASE WHEN crop3 = 'CG' THEN round(profit3::numeric,0) ELSE NULL END) AS round_corn_profit3,
(CASE WHEN crop3 = 'SB' THEN round(profit3::numeric,0) ELSE NULL END) AS round_soy_profit3,
(CASE WHEN crop4 = 'CG' THEN round(profit4::numeric,0) ELSE NULL END) AS round_corn_profit4,
(CASE WHEN crop4 = 'SB' THEN round(profit4::numeric,0) ELSE NULL END) AS round_soy_profit4
FROM crop_budgets_per_clumu_clu_rents_2010_2013;



DROP TABLE IF EXISTS corn_profit_rounded_aggregated1;
CREATE TABLE corn_profit_rounded_aggregated1
AS SELECT
round_corn_profit1,
sum(clumuacres::numeric / 2.471) AS round_corn_profit1_ha
FROM profit_rounded
GROUP BY round_corn_profit1;

DROP TABLE IF EXISTS soy_profit_rounded_aggregated1;
CREATE TABLE soy_profit_rounded_aggregated1
AS SELECT
round_soy_profit1,
sum(clumuacres::numeric / 2.471) AS round_soy_profit1_ha
FROM profit_rounded
GROUP BY round_soy_profit1;

DROP TABLE IF EXISTS corn_profit_rounded_aggregated2;
CREATE TABLE corn_profit_rounded_aggregated2
AS SELECT
round_corn_profit2,
sum(clumuacres::numeric / 2.471) AS round_corn_profit2_ha
FROM profit_rounded
GROUP BY round_corn_profit2;

DROP TABLE IF EXISTS soy_profit_rounded_aggregated2;
CREATE TABLE soy_profit_rounded_aggregated2
AS SELECT
round_soy_profit2,
sum(clumuacres::numeric / 2.471) AS round_soy_profit2_ha
FROM profit_rounded
GROUP BY round_soy_profit2;

DROP TABLE IF EXISTS corn_profit_rounded_aggregated3;
CREATE TABLE corn_profit_rounded_aggregated3
AS SELECT
round_corn_profit3,
sum(clumuacres::numeric / 2.471) AS round_corn_profit3_ha
FROM profit_rounded
GROUP BY round_corn_profit3;

DROP TABLE IF EXISTS soy_profit_rounded_aggregated3;
CREATE TABLE soy_profit_rounded_aggregated3
AS SELECT
round_soy_profit3,
sum(clumuacres::numeric / 2.471) AS round_soy_profit3_ha
FROM profit_rounded
GROUP BY round_soy_profit3;

DROP TABLE IF EXISTS corn_profit_rounded_aggregated4;
CREATE TABLE corn_profit_rounded_aggregated4
AS SELECT
round_corn_profit4,
sum(clumuacres::numeric / 2.471) AS round_corn_profit4_ha
FROM profit_rounded
GROUP BY round_corn_profit4;

DROP TABLE IF EXISTS soy_profit_rounded_aggregated4;
CREATE TABLE soy_profit_rounded_aggregated4
AS SELECT
round_soy_profit4,
sum(clumuacres::numeric / 2.471) AS round_soy_profit4_ha
FROM profit_rounded
GROUP BY round_soy_profit4;

*/
-- profit distribution of corn and soybean in the state, on a CLU-mapunit level, 2015:
-- based on zero-profit cash rent calculation:
/*
DROP TABLE IF EXISTS profit_rounded_2015;
CREATE TABLE profit_rounded_2015
AS SELECT
fips,
twpid,
cluid,
mukey,
clumuacres,
(CASE WHEN ccrop = 'CG' THEN round(profit_2015::numeric,0) ELSE NULL END) AS round_corn_profit_2015,
(CASE WHEN ccrop = 'SB' THEN round(profit_2015::numeric,0) ELSE NULL END) AS round_soy_profit_2015
FROM profit_per_clumu_2015_sa;


DROP TABLE IF EXISTS corn_profit_rounded_aggregated_2015;
CREATE TABLE corn_profit_rounded_aggregated_2015
AS SELECT
round_corn_profit_2015,
sum(clumuacres::numeric / 2.471) AS round_corn_profit_2015_ha
FROM profit_rounded_2015
GROUP BY round_corn_profit_2015;


DROP TABLE IF EXISTS soy_profit_rounded_aggregated_2015;
CREATE TABLE soy_profit_rounded_aggregated_2015
AS SELECT
round_soy_profit_2015,
sum(clumuacres::numeric / 2.471) AS round_soy_profit_2015_ha
FROM profit_rounded_2015
GROUP BY round_soy_profit_2015;
*/
-- profit distribution of corn and soybean in the state, on a CLU-mapunit level, 2015:
-- with 2015 cash rents:

DROP TABLE IF EXISTS profit_rounded_2015_c;
CREATE TABLE profit_rounded_2015_c
AS SELECT
fips,
twpid,
cluid,
mukey,
clumuacres,
(CASE WHEN ccrop = 'CG' THEN round(profit_2015::numeric,0) ELSE NULL END) AS round_corn_profit_2015,
(CASE WHEN ccrop = 'SB' THEN round(profit_2015::numeric,0) ELSE NULL END) AS round_soy_profit_2015
FROM crop_budgets_per_clumu_2015_twp_yields;


DROP TABLE IF EXISTS corn_profit_rounded_aggregated_2015_c;
CREATE TABLE corn_profit_rounded_aggregated_2015_c
AS SELECT
round_corn_profit_2015 * 2.471 AS round_corn_profit_2015,
sum(clumuacres::numeric / 2.471) AS round_corn_profit_2015_ha
FROM profit_rounded_2015_c
GROUP BY round_corn_profit_2015;


DROP TABLE IF EXISTS soy_profit_rounded_aggregated_2015_c;
CREATE TABLE soy_profit_rounded_aggregated_2015_c
AS SELECT
round_soy_profit_2015 * 2.471 AS round_soy_profit_2015,
sum(clumuacres::numeric / 2.471) AS round_soy_profit_2015_ha
FROM profit_rounded_2015_c
GROUP BY round_soy_profit_2015;
