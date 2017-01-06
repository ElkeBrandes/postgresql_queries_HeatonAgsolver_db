-- yield distribution of corn and soybean in the state, on a CLU-mapunit level:

-- to reduce the number of records, first round yield to two decimals, then aggregate over equal values
/*

DROP TABLE IF EXISTS yield_rounded;
CREATE TABLE yield_rounded
AS SELECT
co_name,
twpid,
cluid_mukey,
clumuacres,
(CASE WHEN crop1 = 'CG' THEN round(corn_yield1,2) ELSE NULL END) AS round_corn_yield1,
(CASE WHEN crop1 = 'SB' THEN round(soy_yield1,2) ELSE NULL END) AS round_soy_yield1,
(CASE WHEN crop2 = 'CG' THEN round(corn_yield2,2) ELSE NULL END) AS round_corn_yield2,
(CASE WHEN crop2 = 'SB' THEN round(soy_yield2,2) ELSE NULL END) AS round_soy_yield2,
(CASE WHEN crop3 = 'CG' THEN round(corn_yield3,2) ELSE NULL END) AS round_corn_yield3,
(CASE WHEN crop3 = 'SB' THEN round(soy_yield3,2) ELSE NULL END) AS round_soy_yield3,
(CASE WHEN crop4 = 'CG' THEN round(corn_yield4,2) ELSE NULL END) AS round_corn_yield4,
(CASE WHEN crop4 = 'SB' THEN round(soy_yield4,2) ELSE NULL END) AS round_soy_yield4
FROM corn_soy_yields;

*/



DROP TABLE IF EXISTS corn_yield_aggregated1;
CREATE TABLE corn_yield_aggregated1
AS SELECT
round_corn_yield1,
sum(clumuacres::numeric / 2.471) AS corn_yield1_ha
FROM yield_rounded
GROUP BY round_corn_yield1;

DROP TABLE IF EXISTS soy_yield_aggregated1;
CREATE TABLE soy_yield_aggregated1
AS SELECT
round_soy_yield1,
sum(clumuacres::numeric / 2.471) AS soy_yield1_ha
FROM yield_rounded
GROUP BY round_soy_yield1;

DROP TABLE IF EXISTS corn_yield_aggregated2;
CREATE TABLE corn_yield_aggregated2
AS SELECT
round_corn_yield2,
sum(clumuacres::numeric / 2.471) AS corn_yield2_ha
FROM yield_rounded
GROUP BY round_corn_yield2;

DROP TABLE IF EXISTS soy_yield_aggregated2;
CREATE TABLE soy_yield_aggregated2
AS SELECT
round_soy_yield2,
sum(clumuacres::numeric / 2.471) AS soy_yield2_ha
FROM yield_rounded
GROUP BY round_soy_yield2;

DROP TABLE IF EXISTS corn_yield_aggregated3;
CREATE TABLE corn_yield_aggregated3
AS SELECT
round_corn_yield3,
sum(clumuacres::numeric / 2.471) AS corn_yield3_ha
FROM yield_rounded
GROUP BY round_corn_yield3;

DROP TABLE IF EXISTS soy_yield_aggregated3;
CREATE TABLE soy_yield_aggregated3
AS SELECT
round_soy_yield3,
sum(clumuacres::numeric / 2.471) AS soy_yield3_ha
FROM yield_rounded
GROUP BY round_soy_yield3;

DROP TABLE IF EXISTS corn_yield_aggregated4;
CREATE TABLE corn_yield_aggregated4
AS SELECT
round_corn_yield4,
sum(clumuacres::numeric / 2.471) AS corn_yield4_ha
FROM yield_rounded
GROUP BY round_corn_yield4;

DROP TABLE IF EXISTS soy_yield_aggregated4;
CREATE TABLE soy_yield_aggregated4
AS SELECT
round_soy_yield4,
sum(clumuacres::numeric / 2.471) AS soy_yield4_ha
FROM yield_rounded
GROUP BY round_soy_yield4;
