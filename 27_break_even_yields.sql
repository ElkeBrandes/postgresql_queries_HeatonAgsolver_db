-- calculate the yield that is needed to break even in 2015:

/*
-- add a column for break even yield:
alter table crop_budgets_per_clumu_2015_twp_yields
add column break_even_yield_2015 varchar;
*/
-- calculate break even yield in Mg/ha (conversion from bu/ac included):
-- corn price assumption: 3.65, soy price assumption: 8.90 (mid points of Nov 10 WASDE)
/*
update crop_budgets_per_clumu_2015_twp_yields
set break_even_yield_2015 = ((budget_2015+ clu_adj_rent_2015)/3.65)*25.40117272
*0.001*2.471 WHERE ccrop = 'CG';

update crop_budgets_per_clumu_2015_twp_yields
set break_even_yield_2015 = ((budget_2015+ clu_adj_rent_2015)/8.90)*27.2155422*0.001*2.471
 WHERE ccrop = 'SB';


update crop_budgets_per_clumu_2015_twp_yields
set break_even_yield_2015 = '0' WHERE yield_2015 ='0';
*/

-- add a column for difference between actual and break even yield:
/*
alter table crop_budgets_per_clumu_2015_twp_yields
add column diff_yield_2015 varchar;
*/
-- calculate the difference between actual modelled yield and yield needed to break even 
-- (negative values: the modelled yields are higher than break even yields)

update crop_budgets_per_clumu_2015_twp_yields
set diff_yield_2015 = break_even_yield_2015::numeric - (yield_2015::numeric * 25.40117272 * 0.001 * 2.471) WHERE ccrop = 'CG';

update crop_budgets_per_clumu_2015_twp_yields
set diff_yield_2015 = break_even_yield_2015::numeric - (yield_2015::numeric * 27.2155422*0.001*2.471)  WHERE ccrop = 'SB';

