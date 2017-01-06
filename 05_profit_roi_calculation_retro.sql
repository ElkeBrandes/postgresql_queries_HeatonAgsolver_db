-- add a unique identifyer:
/*
alter table crop_budgets_per_clumu_clu_rents_2010_2013
add column cluid_mukey text;

update crop_budgets_per_clumu_clu_rents_2010_2013
set cluid_mukey = cluid || mukey;
*/
-- Check for duplicate cluid_mukey values:
/*
SELECT t.cluid_mukey
    FROM crop_budgets_per_clumu_clu_rents_2010_2013 t
GROUP BY t.cluid_mukey
  HAVING COUNT(*) > 1
*/
/*
--add columns for profit calculation
alter table crop_budgets_per_clumu_clu_rents_2010_2013
add column profit1 real,
add column profit2 real,
add column profit3 real,
add column profit4 real,
add column profit_average real;
*/


--calculate profit values based on historical comm. price
--			SB		CG
--2010	12.08	5.46
--2011	13.08	6.35
--2012	14.54	6.94
--2013	13.38	4.51


/*
update crop_budgets_per_clumu_clu_rents_2010_2013
set profit1 = (( NULLIF(yield1::NUMERIC,0) * 5.46 ) - ( clu_cashrent_2010 + budget_2010 )) * 2.471
where crop1 = 'CG';

update crop_budgets_per_clumu_clu_rents_2010_2013
set profit2 = (( NULLIF(yield2::NUMERIC,0) * 6.35 ) - ( clu_cashrent_2011 + budget_2011 )) * 2.471
where crop2 = 'CG';


update crop_budgets_per_clumu_clu_rents_2010_2013
set profit3 = (( NULLIF(yield3::NUMERIC,0) * 6.94 ) - ( clu_cashrent_2012 + budget_2012 )) * 2.471
where crop3 = 'CG';

update crop_budgets_per_clumu_clu_rents_2010_2013
set profit4 = (( NULLIF(yield4::NUMERIC,0) * 4.51 ) - ( clu_cashrent_2013 + budget_2013 )) * 2.471
where crop4 = 'CG';

update crop_budgets_per_clumu_clu_rents_2010_2013
set profit1 = (( NULLIF(yield1::NUMERIC,0) * 12.08 ) - ( clu_cashrent_2010 + budget_2010  )) * 2.471
where crop1 = 'SB';

update crop_budgets_per_clumu_clu_rents_2010_2013
set profit2 = (( NULLIF(yield2::NUMERIC,0) * 13.08 ) - ( clu_cashrent_2011 + budget_2011 )) * 2.471
where crop2 = 'SB';

update crop_budgets_per_clumu_clu_rents_2010_2013
set profit3 = (( NULLIF(yield3::NUMERIC,0) * 14.54 ) - ( clu_cashrent_2012 + budget_2012 )) * 2.471
where crop3 = 'SB';

update crop_budgets_per_clumu_clu_rents_2010_2013
set profit4 = (( NULLIF(yield4::NUMERIC,0) * 13.38 ) - ( clu_cashrent_2013 + budget_2013 )) * 2.471
where crop4 = 'SB';
*/

update crop_budgets_per_clumu_clu_rents_2010_2013
set profit_average = ( profit1 + profit2 + profit3 + profit4 ) / 4;






