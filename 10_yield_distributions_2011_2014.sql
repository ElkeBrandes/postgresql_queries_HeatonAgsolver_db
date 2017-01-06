-- yield distribution of corn and soybean in the state, on a CLU-mapunit level:

-- to reduce the number of records, first round yield to two decimals, then aggregate over equal values


DROP TABLE IF EXISTS "09_yields_rounded_2011_2014";
CREATE TABLE "09_yields_rounded_2011_2014"
AS SELECT
fips,
cluid_mukey11 as cluid_mukey,
clumuha,
(CASE WHEN crop11 = 'CG' THEN round(yield11,2) ELSE NULL END) AS round_corn_yield11,
(CASE WHEN crop11 = 'SB' THEN round(yield11,2) ELSE NULL END) AS round_soy_yield11,
(CASE WHEN crop12 = 'CG' THEN round(yield12,2) ELSE NULL END) AS round_corn_yield12,
(CASE WHEN crop12 = 'SB' THEN round(yield12,2) ELSE NULL END) AS round_soy_yield12,
(CASE WHEN crop13 = 'CG' THEN round(yield13,2) ELSE NULL END) AS round_corn_yield13,
(CASE WHEN crop13 = 'SB' THEN round(yield13,2) ELSE NULL END) AS round_soy_yield13,
(CASE WHEN crop14 = 'CG' THEN round(yield14,2) ELSE NULL END) AS round_corn_yield14,
(CASE WHEN crop14 = 'SB' THEN round(yield14,2) ELSE NULL END) AS round_soy_yield14
FROM "09_yields_2011_2014";



DROP TABLE IF EXISTS corn_yield_aggregated11;
CREATE TABLE corn_yield_aggregated11
AS SELECT
round_corn_yield11,
sum(clumuha) AS corn_yield11_ha
FROM "09_yields_rounded_2011_2014"
GROUP BY round_corn_yield11;

DROP TABLE IF EXISTS soy_yield_aggregated11;
CREATE TABLE soy_yield_aggregated11
AS SELECT
round_soy_yield11,
sum(clumuha) AS soy_yield11_ha
FROM "09_yields_rounded_2011_2014"
GROUP BY round_soy_yield11;

DROP TABLE IF EXISTS corn_yield_aggregated12;
CREATE TABLE corn_yield_aggregated12
AS SELECT
round_corn_yield12,
sum(clumuha) AS corn_yield12_ha
FROM "09_yields_rounded_2011_2014"
GROUP BY round_corn_yield12;

DROP TABLE IF EXISTS soy_yield_aggregated12;
CREATE TABLE soy_yield_aggregated12
AS SELECT
round_soy_yield12,
sum(clumuha) AS soy_yield12_ha
FROM "09_yields_rounded_2011_2014"
GROUP BY round_soy_yield12;

DROP TABLE IF EXISTS corn_yield_aggregated13;
CREATE TABLE corn_yield_aggregated13
AS SELECT
round_corn_yield13,
sum(clumuha) AS corn_yield13_ha
FROM "09_yields_rounded_2011_2014"
GROUP BY round_corn_yield13;

DROP TABLE IF EXISTS soy_yield_aggregated13;
CREATE TABLE soy_yield_aggregated13
AS SELECT
round_soy_yield13,
sum(clumuha) AS soy_yield13_ha
FROM "09_yields_rounded_2011_2014"
GROUP BY round_soy_yield13;

DROP TABLE IF EXISTS corn_yield_aggregated14;
CREATE TABLE corn_yield_aggregated14
AS SELECT
round_corn_yield14,
sum(clumuha) AS corn_yield14_ha
FROM "09_yields_rounded_2011_2014"
GROUP BY round_corn_yield14;

DROP TABLE IF EXISTS soy_yield_aggregated14;
CREATE TABLE soy_yield_aggregated14
AS SELECT
round_soy_yield14,
sum(clumuha) AS soy_yield14_ha
FROM "09_yields_rounded_2011_2014"
GROUP BY round_soy_yield14;

