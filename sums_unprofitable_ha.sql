/*
SELECT SUM(clumuacres::NUMERIC/2.471)
FROM crop_budgets_per_clumu_clu_rents_2010_2013 WHERE profit1::NUMERIC <= '-500';

SELECT SUM(clumuacres::NUMERIC/2.471)
FROM crop_budgets_per_clumu_clu_rents_2010_2013 WHERE profit2::NUMERIC <= '-500';

SELECT SUM(clumuacres::NUMERIC/2.471)
FROM crop_budgets_per_clumu_clu_rents_2010_2013 WHERE profit3::NUMERIC <= '-500';

SELECT SUM(clumuacres::NUMERIC/2.471)
FROM crop_budgets_per_clumu_clu_rents_2010_2013 WHERE profit4::NUMERIC <= '-500';

SELECT SUM(clumuacres::NUMERIC/2.471)
FROM crop_budgets_per_clumu_clu_rents_2010_2013 WHERE profit4::NUMERIC <= '-500' AND profit2::NUMERIC <= '-500.0' AND profit3::NUMERIC <= '-500.0' AND profit4::NUMERIC <= '-500.0';
*/



-- from calculated budgets and profits as published in Brandes et al 2016
/*
SELECT SUM(clumuacres::NUMERIC/2.471)
FROM crop_budgets_per_clumu_clu_rents_2010_2013 WHERE profit1::NUMERIC <= '-250';
-- result: 45696

SELECT SUM(clumuacres::NUMERIC/2.471)
FROM crop_budgets_per_clumu_clu_rents_2010_2013 WHERE profit2::NUMERIC <= '-250';
-- result: 18012

SELECT SUM(clumuacres::NUMERIC/2.471)
FROM crop_budgets_per_clumu_clu_rents_2010_2013 WHERE profit3::NUMERIC <= '-250';
-- result: 191887

SELECT SUM(clumuacres::NUMERIC/2.471)
FROM crop_budgets_per_clumu_clu_rents_2010_2013 WHERE profit4::NUMERIC <= '-250';
-- result: 1031649

SELECT SUM(clumuacres::NUMERIC/2.471)
FROM crop_budgets_per_clumu_clu_rents_2010_2013 WHERE profit1::NUMERIC <= '-250' AND profit2::NUMERIC <= '-250.0' AND profit3::NUMERIC <= '-250.0' AND profit4::NUMERIC <= '-250.0';
-- result: 8052
*/

-- from calculated budgets including the pre-harvest costs:

SELECT SUM(clumuacres::NUMERIC/2.471)
FROM crop_budgets_per_clumu_clu_rents_2010_2013 WHERE profit1_preharv <= '-250';
-- result: 45696

SELECT SUM(clumuacres::NUMERIC/2.471)
FROM crop_budgets_per_clumu_clu_rents_2010_2013 WHERE profit2_preharv <= '-250';
-- result: 18012

SELECT SUM(clumuacres::NUMERIC/2.471)
FROM crop_budgets_per_clumu_clu_rents_2010_2013 WHERE profit3_preharv <= '-250';
-- result: 191887

SELECT SUM(clumuacres::NUMERIC/2.471)
FROM crop_budgets_per_clumu_clu_rents_2010_2013 WHERE profit4_preharv <= '-250';
-- result: 1031649

SELECT SUM(clumuacres::NUMERIC/2.471)
FROM crop_budgets_per_clumu_clu_rents_2010_2013 WHERE profit1_preharv <= '-250' AND profit2_preharv <= '-250.0' AND profit3_preharv <= '-250.0' AND profit4_preharv <= '-250.0';
-- result: 8052
