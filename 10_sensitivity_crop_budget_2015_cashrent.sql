-- change corn crop budgets from -$120 to +$120 (in $30 steps) 
-- and soybean crop budgets from -$80 to +$80 (in $20 steps)
-- to investigate the resulting changes in profitability
-- scenario:
-- 2013 crops (crop4)
-- trend yields for 2015
-- 2015 crop budget: sensitivity analysis
-- price = projected price for marketing year 2015/16:
-- corn = 3.50 $/bu
-- soy = 9.00 $/bu
/*
alter table crop_budgets_per_clumu_2015_twp_yields
add column cluid_mukey text;

update crop_budgets_per_clumu_2015_twp_yields
set cluid_mukey = cluid || mukey;

--add columns for profit calculation
alter table crop_budgets_per_clumu_2015_twp_yields
add column "profit-120_2015" float4,
add column "profit-90_2015" float4,
add column "profit-60_2015" float4,
add column "profit-30_2015" float4,
add column "profit_2015" float4,
add column "profit+30_2015" float4,
add column "profit+60_2015" float4,
add column "profit+90_2015" float4,
add column "profit+120_2015" float4;
*/

--calculate profit values based on projected comm. price
--			                SB		CG
--May 2015 WASDE prediction	9.00	3.50

-- profit in USD/ha are calculated here:

update crop_budgets_per_clumu_2015_twp_yields
set "profit-120_2015" = ((( NULLIF(yield_2015::NUMERIC,0) * 3.50 ) - ( clu_adj_rent_2015 + budget_2015 - 120/2.471)))*2.471 
where ccrop = 'CG';

update crop_budgets_per_clumu_2015_twp_yields
set "profit-120_2015" = ((( NULLIF(yield_2015::NUMERIC,0) * 9.00 ) - ( clu_adj_rent_2015 + budget_2015 - 80/2.471)) )*2.471 
where ccrop = 'SB';

update crop_budgets_per_clumu_2015_twp_yields
set "profit-90_2015" = ((( NULLIF(yield_2015::NUMERIC,0) * 3.50 ) - ( clu_adj_rent_2015 + budget_2015 - 90/2.471)))*2.471  
where ccrop = 'CG';

update crop_budgets_per_clumu_2015_twp_yields
set "profit-90_2015" = ((( NULLIF(yield_2015::NUMERIC,0) * 9.00 ) - ( clu_adj_rent_2015 + budget_2015 - 60/2.471)))*2.471  
where ccrop = 'SB';

update crop_budgets_per_clumu_2015_twp_yields
set "profit-60_2015" = ((( NULLIF(yield_2015::NUMERIC,0) * 3.50 ) - ( clu_adj_rent_2015 + budget_2015 - 60/2.471)))*2.471  
where ccrop = 'CG';

update crop_budgets_per_clumu_2015_twp_yields
set "profit-60_2015" = ((( NULLIF(yield_2015::NUMERIC,0) * 9.00 ) - ( clu_adj_rent_2015 + budget_2015 - 40/2.471)))*2.471 
where ccrop = 'SB';

update crop_budgets_per_clumu_2015_twp_yields
set "profit-30_2015" = ((( NULLIF(yield_2015::NUMERIC,0) * 3.50 ) - ( clu_adj_rent_2015 + budget_2015 - 30/2.471)))*2.471  
where ccrop = 'CG';

update crop_budgets_per_clumu_2015_twp_yields
set "profit-30_2015" = ((( NULLIF(yield_2015::NUMERIC,0) * 9.00 ) - ( clu_adj_rent_2015 + budget_2015 - 20/2.471)))*2.471  
where ccrop = 'SB';

update crop_budgets_per_clumu_2015_twp_yields
set "profit_2015" = ((( NULLIF(yield_2015::NUMERIC,0) * 3.50 ) - ( clu_adj_rent_2015 + budget_2015)))*2.471  
where ccrop = 'CG';

update crop_budgets_per_clumu_2015_twp_yields
set "profit_2015" = ((( NULLIF(yield_2015::NUMERIC,0) * 9.00 ) - ( clu_adj_rent_2015 + budget_2015)))*2.471  
where ccrop = 'SB';

update crop_budgets_per_clumu_2015_twp_yields
set "profit+30_2015" = ((( NULLIF(yield_2015::NUMERIC,0) * 3.50 ) - ( clu_adj_rent_2015 + budget_2015 + 30/2.471)))*2.471  
where ccrop = 'CG';

update crop_budgets_per_clumu_2015_twp_yields
set "profit+30_2015" = ((( NULLIF(yield_2015::NUMERIC,0) * 9.00 ) - ( clu_adj_rent_2015 + budget_2015 + 20/2.471)))*2.471  
where ccrop = 'SB';


update crop_budgets_per_clumu_2015_twp_yields
set "profit+60_2015" = ((( NULLIF(yield_2015::NUMERIC,0) * 3.50 ) - ( clu_adj_rent_2015 + budget_2015 + 60/2.471)))*2.471  
where ccrop = 'CG';

update crop_budgets_per_clumu_2015_twp_yields
set "profit+60_2015" = ((( NULLIF(yield_2015::NUMERIC,0) * 9.00 ) - ( clu_adj_rent_2015 + budget_2015 + 40/2.471)) )*2.471 
where ccrop = 'SB';

update crop_budgets_per_clumu_2015_twp_yields
set "profit+90_2015" = ((( NULLIF(yield_2015::NUMERIC,0) * 3.50 ) - ( clu_adj_rent_2015 + budget_2015 + 90/2.471)))*2.471  
where ccrop = 'CG';

update crop_budgets_per_clumu_2015_twp_yields
set "profit+90_2015" = ((( NULLIF(yield_2015::NUMERIC,0) * 9.00 ) - ( clu_adj_rent_2015 + budget_2015 + 60/2.471)))*2.471  
where ccrop = 'SB';

update crop_budgets_per_clumu_2015_twp_yields
set "profit+120_2015" = ((( NULLIF(yield_2015::NUMERIC,0) * 3.50 ) - ( clu_adj_rent_2015 + budget_2015 + 120/2.471)))*2.471  
where ccrop = 'CG';

update crop_budgets_per_clumu_2015_twp_yields
set "profit+120_2015" = ((( NULLIF(yield_2015::NUMERIC,0) * 9.00 ) - ( clu_adj_rent_2015 + budget_2015 + 80/2.471)))*2.471  
where ccrop = 'SB';




/*
SELECT t.cluid_mukey
    FROM results_w_profit_cb_sa t
GROUP BY t.cluid_mukey
  HAVING COUNT(*) > 1


DELETE FROM results_w_profit_cb_sa
WHERE yield2 = '0';
*/