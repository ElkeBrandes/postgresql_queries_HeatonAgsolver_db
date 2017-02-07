-- calculate crop budgets based on components listed in table crop_budgets_fert_preharvest_and_harvest. 
-- in this table, preharvest costs were added.


--delete columns based on the old calculations that did not include preharvest costs
alter table crop_budgets_per_clumu_clu_rents_2010_2013
drop column if exists "budget_preharv_2010",
drop column if exists "budget_preharv_2011",
drop column if exists "budget_preharv_2012",
drop column if exists "budget_preharv_2013";

-- add empty columns 
alter table crop_budgets_per_clumu_clu_rents_2010_2013
add column "budget_preharv_2010" float,
add column "budget_preharv_2011" float,
add column "budget_preharv_2012" float,
add column "budget_preharv_2013" float;


--2010
update crop_budgets_per_clumu_clu_rents_2010_2013 t1
set "budget_preharv_2010" =
(
	SELECT
		"preharvest ($/acre)"
		+ "seed and chem ($/acre)"
		+ "harvest machinery ($/bu)" * yield1::numeric
		+ "labor ($/acre)"
		+ "N ($/acre)"
		+ "P ($/acre)"
		+ "K ($/acre)"
	from crop_budgets_fert_preharvest_and_harvest
	where ( ccrop = t1.crop1 and pcrop = t1.crop4 and "year" = t1.year1 )
)::NUMERIC;


--2011
update crop_budgets_per_clumu_clu_rents_2010_2013 t1
set "budget_preharv_2011" =
(
	SELECT
		"preharvest ($/acre)"
		+ "seed and chem ($/acre)"
		+ "harvest machinery ($/bu)" * yield2::numeric
		+ "labor ($/acre)"
		+ "N ($/acre)"
		+ "P ($/acre)"
		+ "K ($/acre)"
	from crop_budgets_fert_preharvest_and_harvest
	where ( ccrop = t1.crop2 and pcrop = t1.crop1 and "year" = t1.year2 )
)::NUMERIC;

--2012
update crop_budgets_per_clumu_clu_rents_2010_2013 t1
set "budget_preharv_2012" =
(
	SELECT
			"preharvest ($/acre)"
		+ "seed and chem ($/acre)"
		+ "harvest machinery ($/bu)" * yield3::numeric
		+ "labor ($/acre)"
		+ "N ($/acre)"
		+ "P ($/acre)"
		+ "K ($/acre)"
	from crop_budgets_fert_preharvest_and_harvest
	where ( ccrop = t1.crop3 and pcrop = t1.crop2 and "year" = t1.year3 )
)::NUMERIC;

--2013
update crop_budgets_per_clumu_clu_rents_2010_2013 t1
set "budget_preharv_2013" =
(
	SELECT
		"preharvest ($/acre)"
		+ "seed and chem ($/acre)"
		+ "harvest machinery ($/bu)" * yield4::numeric
		+ "labor ($/acre)"
		+ "N ($/acre)"
		+ "P ($/acre)"
		+ "K ($/acre)"
	from crop_budgets_fert_preharvest_and_harvest
	where ( ccrop = t1.crop4 and pcrop = t1.crop3 and "year" = t1.year4 )
)::NUMERIC;
