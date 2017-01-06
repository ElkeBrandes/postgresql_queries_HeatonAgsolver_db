/*
DROP TABLE IF EXISTS average_std_cashrent_crop_budget;
CREATE TABLE average_std_cashrent_crop_budget
AS SELECT 
AVG(budget_2010*2.471) AS av_budget_2010,
STDDEV_POP(budget_2010*2.471) AS std_budget_2010,
AVG(budget_2011*2.471) av_budget_2011,
STDDEV_POP(budget_2011*2.471) AS std_budget_2011,
AVG(budget_2012*2.471) av_budget_2012,
STDDEV_POP(budget_2012*2.471) AS std_budget_2012,
AVG(budget_2013*2.471) av_budget_2013,
STDDEV_POP(budget_2013*2.471) AS std_budget_2013,
AVG(clu_cashrent_2010*2.471) AS av_rent_2010,
STDDEV_POP(clu_cashrent_2010*2.471) AS std_rent_2010,
AVG(clu_cashrent_2011*2.471) AS av_rent_2011,
STDDEV_POP(clu_cashrent_2011*2.471) AS std_rent_2011,
AVG(clu_cashrent_2012*2.471) AS av_rent_2012,
STDDEV_POP(clu_cashrent_2012*2.471) AS std_rent_2012,
AVG(clu_cashrent_2013*2.471) AS av_rent_2013,
STDDEV_POP(clu_cashrent_2013*2.471) AS std_rent_2013
FROM crop_budgets_per_clumu_clu_rents_2010_2013;
*/

DROP TABLE IF EXISTS average_std_cashrent_crop_budget_2015;
CREATE TABLE average_std_cashrent_crop_budget_2015
AS SELECT 
AVG(budget_2015*2.471) AS av_budget_2015,
STDDEV_POP(budget_2015*2.471) AS std_budget_2015,
AVG(clu_adj_rent_2014*2.471) AS av_rent_2014,
STDDEV_POP(clu_adj_rent_2014*2.471) AS std_rent_2014
FROM crop_budgets_per_clumu_2015;