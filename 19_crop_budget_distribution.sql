-- crop budget distribution in the state, on a CLU level:

-- to reduce the number of records, first round crop budgets to the nearest $, then aggregate over the same amounts
/*

DROP TABLE IF EXISTS crop_budget_rounded;
CREATE TABLE crop_budget_rounded
AS SELECT
fips,
twpid,
cluid_mukey,
clumuacres,
(CASE WHEN crop1 = 'CG' AND crop4 = 'CG' THEN round((budget_2010::numeric*2.471),0) ELSE NULL END) AS cfc_round_crop_budget_2010,
(CASE WHEN crop1 = 'CG' AND crop4 = 'SB' THEN round((budget_2010::numeric*2.471),0) ELSE NULL END) AS cfs_round_crop_budget_2010,
(CASE WHEN crop1 = 'SB' THEN round((budget_2010::numeric*2.471),0) ELSE NULL END) AS s_round_crop_budget_2010,

(CASE WHEN crop2 = 'CG' AND crop1 = 'CG' THEN round((budget_2011::numeric*2.471),0) ELSE NULL END) AS cfc_round_crop_budget_2011,
(CASE WHEN crop2 = 'CG' AND crop1 = 'SB' THEN round((budget_2011::numeric*2.471),0) ELSE NULL END) AS cfs_round_crop_budget_2011,
(CASE WHEN crop2 = 'SB' THEN round((budget_2011::numeric*2.471),0) ELSE NULL END) AS s_round_crop_budget_2011,

(CASE WHEN crop3 = 'CG' AND crop2 = 'CG' THEN round((budget_2012::numeric*2.471),0) ELSE NULL END) AS cfc_round_crop_budget_2012,
(CASE WHEN crop3 = 'CG' AND crop2 = 'SB' THEN round((budget_2012::numeric*2.471),0) ELSE NULL END) AS cfs_round_crop_budget_2012,
(CASE WHEN crop3 = 'SB' THEN round((budget_2012::numeric*2.471),0) ELSE NULL END) AS s_round_crop_budget_2012,

(CASE WHEN crop4 = 'CG' AND crop3 = 'CG' THEN round((budget_2013::numeric*2.471),0) ELSE NULL END) AS cfc_round_crop_budget_2013,
(CASE WHEN crop4 = 'CG' AND crop3 = 'SB' THEN round((budget_2013::numeric*2.471),0) ELSE NULL END) AS cfs_round_crop_budget_2013,
(CASE WHEN crop4 = 'SB' THEN round((budget_2013::numeric*2.471),0) ELSE NULL END) AS s_round_crop_budget_2013
FROM crop_budgets_per_clumu_clu_rents_2010_2013;
*/
-- 2010:
/*
DROP TABLE IF EXISTS cfc_crop_budget_rounded_aggregated_2010;
CREATE TABLE cfc_crop_budget_rounded_aggregated_2010
AS SELECT
cfc_round_crop_budget_2010,
sum(clumuacres::numeric / 2.471) AS cfc_round_crop_budget_2010_ha
FROM crop_budget_rounded
GROUP BY cfc_round_crop_budget_2010;
*/
DROP TABLE IF EXISTS cfs_crop_budget_rounded_aggregated_2010;
CREATE TABLE cfs_crop_budget_rounded_aggregated_2010
AS SELECT
cfs_round_crop_budget_2010,
sum(clumuacres::numeric / 2.471) AS cfs_round_crop_budget_2010_ha
FROM crop_budget_rounded
GROUP BY cfs_round_crop_budget_2010;

DROP TABLE IF EXISTS s_crop_budget_rounded_aggregated_2010;
CREATE TABLE s_crop_budget_rounded_aggregated_2010
AS SELECT
s_round_crop_budget_2010,
sum(clumuacres::numeric / 2.471) AS s_round_crop_budget_2010_ha
FROM crop_budget_rounded
GROUP BY s_round_crop_budget_2010;

-- 2011:
DROP TABLE IF EXISTS cfc_crop_budget_rounded_aggregated_2011;
CREATE TABLE cfc_crop_budget_rounded_aggregated_2011
AS SELECT
cfc_round_crop_budget_2011,
sum(clumuacres::numeric / 2.471) AS cfc_round_crop_budget_2011_ha
FROM crop_budget_rounded
GROUP BY cfc_round_crop_budget_2011;

DROP TABLE IF EXISTS cfs_crop_budget_rounded_aggregated_2011;
CREATE TABLE cfs_crop_budget_rounded_aggregated_2011
AS SELECT
cfs_round_crop_budget_2011,
sum(clumuacres::numeric / 2.471) AS cfs_round_crop_budget_2011_ha
FROM crop_budget_rounded
GROUP BY cfs_round_crop_budget_2011;

DROP TABLE IF EXISTS s_crop_budget_rounded_aggregated_2011;
CREATE TABLE s_crop_budget_rounded_aggregated_2011
AS SELECT
s_round_crop_budget_2011,
sum(clumuacres::numeric / 2.471) AS s_round_crop_budget_2011_ha
FROM crop_budget_rounded
GROUP BY s_round_crop_budget_2011;

-- 2012:
DROP TABLE IF EXISTS cfc_crop_budget_rounded_aggregated_2012;
CREATE TABLE cfc_crop_budget_rounded_aggregated_2012
AS SELECT
cfc_round_crop_budget_2012,
sum(clumuacres::numeric / 2.471) AS cfc_round_crop_budget_2012_ha
FROM crop_budget_rounded
GROUP BY cfc_round_crop_budget_2012;

DROP TABLE IF EXISTS cfs_crop_budget_rounded_aggregated_2012;
CREATE TABLE cfs_crop_budget_rounded_aggregated_2012
AS SELECT
cfs_round_crop_budget_2012,
sum(clumuacres::numeric / 2.471) AS cfs_round_crop_budget_2012_ha
FROM crop_budget_rounded
GROUP BY cfs_round_crop_budget_2012;

DROP TABLE IF EXISTS s_crop_budget_rounded_aggregated_2012;
CREATE TABLE s_crop_budget_rounded_aggregated_2012
AS SELECT
s_round_crop_budget_2012,
sum(clumuacres::numeric / 2.471) AS s_round_crop_budget_2012_ha
FROM crop_budget_rounded
GROUP BY s_round_crop_budget_2012;

-- 2013:
DROP TABLE IF EXISTS cfc_crop_budget_rounded_aggregated_2013;
CREATE TABLE cfc_crop_budget_rounded_aggregated_2013
AS SELECT
cfc_round_crop_budget_2013,
sum(clumuacres::numeric / 2.471) AS cfc_round_crop_budget_2013_ha
FROM crop_budget_rounded
GROUP BY cfc_round_crop_budget_2013;

DROP TABLE IF EXISTS cfs_crop_budget_rounded_aggregated_2013;
CREATE TABLE cfs_crop_budget_rounded_aggregated_2013
AS SELECT
cfs_round_crop_budget_2013,
sum(clumuacres::numeric / 2.471) AS cfs_round_crop_budget_2013_ha
FROM crop_budget_rounded
GROUP BY cfs_round_crop_budget_2013;

DROP TABLE IF EXISTS s_crop_budget_rounded_aggregated_2013;
CREATE TABLE s_crop_budget_rounded_aggregated_2013
AS SELECT
s_round_crop_budget_2013,
sum(clumuacres::numeric / 2.471) AS s_round_crop_budget_2013_ha
FROM crop_budget_rounded
GROUP BY s_round_crop_budget_2013;

