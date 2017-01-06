-- calculate crop budgets based on components listed in table crop_budgets_fert_and_harvest. 
-- in the table crop_budgets_fert_and_harvest, seed and chem refers to seed, pesticides, 
-- herbicides, lime, miscellaneous, and interest rates

/*
--create columns
alter table crop_budgets_per_clumu_2010_2013
drop column if exists "budget_2010",
drop column if exists "budget_2011",
drop column if exists "budget_2012",
drop column if exists "budget_2013";

alter table crop_budgets_per_clumu_2010_2013
add column "budget_2010" float,
add column "budget_2011" float,
add column "budget_2012" float,
add column "budget_2013" float;

--2010
update crop_budgets_per_clumu_2010_2013 t1
set "budget_2010" =
(
	SELECT
		"seed and chem ($/acre)"
		+ "harvest machinery ($/bu)" * yield1::numeric
		+ "labor ($/acre)"
		+ "N ($/acre)"
		+ "P ($/acre)"
		+ "K ($/acre)"
	from crop_budgets_fert_and_harvest
	where ( ccrop = t1.crop1 and pcrop = t1.crop4 and "year" = t1.year1 )
)::NUMERIC;
*/

--2011
update crop_budgets_per_clumu_2010_2013 t1
set "budget_2011" =
(
	SELECT
		"seed and chem ($/acre)"
		+ "harvest machinery ($/bu)" * yield2::numeric
		+ "labor ($/acre)"
		+ "N ($/acre)"
		+ "P ($/acre)"
		+ "K ($/acre)"
	from crop_budgets_fert_and_harvest
	where ( ccrop = t1.crop2 and pcrop = t1.crop1 and "year" = t1.year2 )
)::NUMERIC;

--2012
update crop_budgets_per_clumu_2010_2013 t1
set "budget_2012" =
(
	SELECT
		"seed and chem ($/acre)"
		+ "harvest machinery ($/bu)" * yield3::numeric
		+ "labor ($/acre)"
		+ "N ($/acre)"
		+ "P ($/acre)"
		+ "K ($/acre)"
	from crop_budgets_fert_and_harvest
	where ( ccrop = t1.crop3 and pcrop = t1.crop2 and "year" = t1.year3 )
)::NUMERIC;

--2013
update crop_budgets_per_clumu_2010_2013 t1
set "budget_2013" =
(
	SELECT
		"seed and chem ($/acre)"
		+ "harvest machinery ($/bu)" * yield4::numeric
		+ "labor ($/acre)"
		+ "N ($/acre)"
		+ "P ($/acre)"
		+ "K ($/acre)"
	from crop_budgets_fert_and_harvest
	where ( ccrop = t1.crop4 and pcrop = t1.crop3 and "year" = t1.year4 )
)::NUMERIC;
