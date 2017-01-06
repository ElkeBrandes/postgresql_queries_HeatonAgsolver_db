-- re-calculate profits 2015 including pre harvest machinery costs
-- join 2015 yields per mapunit with the rest of the data needed from heaton_results

DROP TABLE IF EXISTS crop_budgets_per_clumu_2015_y;
CREATE TABLE crop_budgets_per_clumu_2015_y AS
	SELECT
		t1.fips,
		t2.cluid,
		t1.mukey,
		t2.musym,
    t2.clumuacres,
		t1.adjyld AS yield_2015,
		t2.crop4 as ccrop,
		t2.crop3 as pcrop
	FROM county_adj_yields_2015 t1
	INNER JOIN heaton_results t2 
	ON t1.fips = t2.fips
	AND t1.mukey = t2.mukey
AND t1.crop = t2.crop4;


-- add county name and twp ID
-- (then, crop_budgets_per_clumu_2015 is no longer needed and can be exported for backup)
/*
DROP TABLE IF EXISTS crop_budgets_per_clumu_2015_y_twp;
CREATE TABLE crop_budgets_per_clumu_2015_y_twp
AS SELECT
t2.co_name,
t2.twpid,
t1.*
FROM crop_budgets_per_clumu_2015_y AS t1
INNER JOIN clu_rents_twp_county AS t2 ON t1.cluid = t2.cluid;


--add budget column
alter table crop_budgets_per_clumu_2015_y_twp
add column "budget_2015" float4;


--add crop budget components
--based on current crop and prev crop

update crop_budgets_per_clumu_2015_y_twp t1
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
*/