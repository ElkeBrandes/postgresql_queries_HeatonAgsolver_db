-- in one step: join rent 2015 data (on mu level) and other data from heaton_results,
-- and calculate CLU cash rent averages and add that column into the new table


DROP TABLE IF EXISTS crop_budgets_per_clumu_2015;
CREATE TABLE crop_budgets_per_clumu_2015 AS
WITH mutable AS (
	SELECT
		t1.fips,
		t2.cluid,
		t2.clumuacres,
		t1.mukey,
		t1.muacres,
		t1.adj_rent_2015,
		t2.crop4 as ccrop,
		t2.crop3 as pcrop
	FROM adj_cash_rents_ia_mu_cgsb_2010_2015 t1
	INNER JOIN heaton_results t2 
	ON t1.fips = t2.fips
	AND t1.mukey = t2.mukey
),
clutable AS (
	SELECT
		fips,
		cluid,
		NULLIF (SUM(clumuacres :: NUMERIC), 0) AS cluacres,
		SUM ( adj_rent_2015 * clumuacres :: NUMERIC ) / NULLIF (SUM(clumuacres :: NUMERIC), 0) AS clu_adj_rent_2015
	FROM mutable
	GROUP BY
		cluid,
		fips
)
SELECT
	t1.fips,
	t1.ccrop,
	t1.pcrop,
	t1.mukey,
	t1.clumuacres,
	t1.adj_rent_2015,
	t2.cluid,
	t2.cluacres,
	t2.clu_adj_rent_2015
FROM mutable t1
INNER JOIN clutable t2 
ON t1.fips = t2.fips
AND t1.cluid = t2.cluid;


-- add county name and twp ID
-- (then, crop_budgets_per_clumu_2015 is no longer needed and can be exported for backup)
/*
DROP TABLE IF EXISTS crop_budgets_per_clumu_2015_twp;
CREATE TABLE crop_budgets_per_clumu_2015_twp
AS SELECT
t2.co_name,
t2.twpid,
t1.*
FROM crop_budgets_per_clumu_2015 AS t1
LEFT OUTER JOIN clu_rents_twp_county AS t2 ON t1.cluid = t2.cluid;
*/
-- add 2015 yields:

DROP TABLE IF EXISTS crop_budgets_per_clumu_2015_twp_yields;
CREATE TABLE crop_budgets_per_clumu_2015_twp_yields AS
	SELECT
		t1.*,
		t2.adjyld AS yield_2015
	FROM crop_budgets_per_clumu_2015_twp t1
	INNER JOIN county_adj_yields_2015 t2 
	ON t1.fips = t2.fips
AND t1.mukey = t2.mukey
AND t1.ccrop = t2.crop;



--add budget column
alter table crop_budgets_per_clumu_2015_twp_yields
add column "budget_2015" float4;


--add crop budget components
--based on current crop and prev crop

update crop_budgets_per_clumu_2015_twp_yields t1
set "budget_2015" =
(
	SELECT
		"seed and chem ($/acre)"
		+ "harvest machinery ($/bu)" * yield_2015::numeric
		+ "labor ($/acre)"
		+ "N ($/acre)"
		+ "P ($/acre)"
		+ "K ($/acre)"
	from crop_budgets_fert_and_harvest
	where ( ccrop = t1.ccrop and pcrop = t1.pcrop and "year" = '2015' )
)::NUMERIC;
