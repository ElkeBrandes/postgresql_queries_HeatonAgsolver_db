-- cash rents distribution in the state, on a CLU level:

-- to reduce the number of records, first round cash rents to the nearest $, then aggregate over the same amounts


DROP TABLE IF EXISTS crop_budget_rounded_2015;
CREATE TABLE crop_budget_rounded_2015
AS SELECT
fips,
twpid,
cluid_mukey,
clumuacres,
(CASE WHEN ccrop = 'CG' AND pcrop = 'CG' THEN round((budget_2015::numeric*2.471),0) ELSE NULL END) AS cfc_round_crop_budget_2015,
(CASE WHEN ccrop = 'CG' AND pcrop = 'SB' THEN round((budget_2015::numeric*2.471),0) ELSE NULL END) AS cfs_round_crop_budget_2015,
(CASE WHEN ccrop = 'SB' THEN round((budget_2015::numeric*2.471),0) ELSE NULL END) AS s_round_crop_budget_2015
FROM crop_budgets_per_clumu_2015_twp_yields;

-- 2015:

DROP TABLE IF EXISTS cfc_crop_budget_rounded_aggregated_2015;
CREATE TABLE cfc_crop_budget_rounded_aggregated_2015
AS SELECT
cfc_round_crop_budget_2015,
sum(clumuacres::numeric / 2.471) AS cfc_round_crop_budget_2015_ha
FROM crop_budget_rounded_2015
GROUP BY cfc_round_crop_budget_2015;

DROP TABLE IF EXISTS cfs_crop_budget_rounded_aggregated_2015;
CREATE TABLE cfs_crop_budget_rounded_aggregated_2015
AS SELECT
cfs_round_crop_budget_2015,
sum(clumuacres::numeric / 2.471) AS cfs_round_crop_budget_2015_ha
FROM crop_budget_rounded_2015
GROUP BY cfs_round_crop_budget_2015;

DROP TABLE IF EXISTS s_crop_budget_rounded_aggregated_2015;
CREATE TABLE s_crop_budget_rounded_aggregated_2015
AS SELECT
s_round_crop_budget_2015,
sum(clumuacres::numeric / 2.471) AS s_round_crop_budget_2015_ha
FROM crop_budget_rounded_2015
GROUP BY s_round_crop_budget_2015;
