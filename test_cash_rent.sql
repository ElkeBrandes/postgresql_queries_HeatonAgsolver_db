select sum(clu_cash_rent * clumuacres)/NULLIF (sum(clumuacres),0) from clumu_cgsb_profit_2011_2014 where fips = 'IA001' and year = '2011';
-- result: 191.77
-- average county rent: 191.93
 
select sum(clu_cash_rent * clumuacres)/NULLIF (sum(clumuacres),0) from clumu_cgsb_profit_2011_2014 where fips = 'IA003' and year = '2011';
-- result: 254.44
-- average county rent: 227.36
 
select sum(clumuacres) from clumu_cgsb_profit_2011_2014 where year = '2011';
-- result: 23595320.85 (=9.55 Mha)

select sum(clu_cash_rent * clumuacres)/NULLIF (sum(clumuacres),0) from clumu_cgsb_profit_2011_2014 where year = '2011';
-- 219.92
select sum(clu_cash_rent * clumuacres)/NULLIF (sum(clumuacres),0) from clumu_cgsb_profit_2011_2014 where profit < 0 and year = '2011';
-- result: 189.31

select sum(clumuha) from "01_clumu_cgsb_profit_2011_2014_mean" where mean_profit_ha < 0;
-- 953625.00