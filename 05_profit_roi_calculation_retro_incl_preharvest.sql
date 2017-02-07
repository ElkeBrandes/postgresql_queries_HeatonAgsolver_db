
--add columns for profit calculation
alter table crop_budgets_per_clumu_clu_rents_2010_2013
add column profit1_preharv float,
add column profit2_preharv FLOAT,
add column profit3_preharv FLOAT,
add column profit4_preharv FLOAT,
add column profit_average_preharv FLOAT;



--calculate profit values based on historical comm. price
--			SB		CG
--2010	12.08	5.46
--2011	13.08	6.35
--2012	14.54	6.94
--2013	13.38	4.51

-- calculate profit in metric units ($/ha)


update crop_budgets_per_clumu_clu_rents_2010_2013
set 
profit1_preharv = (( NULLIF(yield1::NUMERIC,0) * 5.46 ) - ( clu_cashrent_2010 + budget_preharv_2010 )) * 2.471
where crop1 = 'CG';
update crop_budgets_per_clumu_clu_rents_2010_2013
set 
profit2_preharv = (( NULLIF(yield2::NUMERIC,0) * 6.35 ) - ( clu_cashrent_2011 + budget_preharv_2011 )) * 2.471
where crop2 = 'CG';
update crop_budgets_per_clumu_clu_rents_2010_2013
set 
profit3_preharv = (( NULLIF(yield3::NUMERIC,0) * 6.94 ) - ( clu_cashrent_2012 + budget_preharv_2012 )) * 2.471
where crop3 = 'CG';
update crop_budgets_per_clumu_clu_rents_2010_2013
set 
profit4_preharv = (( NULLIF(yield4::NUMERIC,0) * 4.51 ) - ( clu_cashrent_2013 + budget_preharv_2013 )) * 2.471
where crop4 = 'CG';
update crop_budgets_per_clumu_clu_rents_2010_2013
set 
profit1_preharv = (( NULLIF(yield1::NUMERIC,0) * 12.08 ) - ( clu_cashrent_2010 + budget_preharv_2010 )) * 2.471
where crop1 = 'SB';
update crop_budgets_per_clumu_clu_rents_2010_2013
set 
profit2_preharv = (( NULLIF(yield2::NUMERIC,0) * 13.08 ) - ( clu_cashrent_2011 + budget_preharv_2011 )) * 2.471
where crop2 = 'SB';
update crop_budgets_per_clumu_clu_rents_2010_2013
set 
profit3_preharv = (( NULLIF(yield3::NUMERIC,0) * 14.54 ) - ( clu_cashrent_2012 + budget_preharv_2012 )) * 2.471
where crop3 = 'SB';
update crop_budgets_per_clumu_clu_rents_2010_2013
set 
profit4_preharv = (( NULLIF(yield4::NUMERIC,0) * 13.38 ) - ( clu_cashrent_2013 + budget_preharv_2013 )) * 2.471
where crop4 = 'SB';

update crop_budgets_per_clumu_clu_rents_2010_2013
set 
profit_average_preharv = ( profit1_preharv + profit2_preharv + profit3_preharv + profit4_preharv ) / 4;






