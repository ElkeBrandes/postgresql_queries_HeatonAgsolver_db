-- area weighted average profitability in 2015 calculated over all clu-mu (after correcting profit_2015 in crop_budgets_per_clumu_2015_twp_yields to US$/ha):

SELECT sum(profit_2015*clumuha)/NULLIF (sum(clumuha),0) from crop_budgets_per_clumu_2015_twp_yields;

-- area weighted average profitability in 2010-2013 calculated over all clu-mu:
/*
SELECT sum(profit1::numeric*clumuacres::numeric)/NULLIF (sum(clumuacres::numeric),0) from crop_budgets_per_clumu_clu_rents_2010_2013;
SELECT sum(profit2::numeric*clumuacres::numeric)/NULLIF (sum(clumuacres::numeric),0) from crop_budgets_per_clumu_clu_rents_2010_2013;
SELECT sum(profit3::numeric*clumuacres::numeric)/NULLIF (sum(clumuacres::numeric),0) from crop_budgets_per_clumu_clu_rents_2010_2013;
SELECT sum(profit4::numeric*clumuacres::numeric)/NULLIF (sum(clumuacres::numeric),0) from crop_budgets_per_clumu_clu_rents_2010_2013;
*/