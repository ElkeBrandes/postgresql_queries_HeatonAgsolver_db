-- from table profit_per_clumu_2015_sa, select the records where profit_2015 is equal to or smaller than zero.

alter table profit_per_clumu_2015_sa
add column "yield_even" float4,
add column "yield-yield_even" float4,
add column "yield_-500" float4,
add column "yield-yield_-500" float4;


update profit_per_clumu_2015_sa
set 
"yield_even" = CASE WHEN ccrop = 'CG' THEN ("budget_2015" + "clu_rent_2015") / 3.72 ELSE ("budget_2015" + "clu_rent_2015") / 10.15 END, 
"yield-yield_even" = yield_2015 - yield_even,
"yield_-500" = CASE WHEN ccrop = 'CG' THEN (budget_2015 + clu_rent_2015 - 500/2.471) / ELSE ("budget_2015" + "clu_rent_2015" - 500/2.471) / 10.15 END,
"yield-yield_-500" = yield_2015 - yield_-500;

