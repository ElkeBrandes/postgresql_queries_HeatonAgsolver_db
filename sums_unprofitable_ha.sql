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

SELECT SUM(clumuacres::NUMERIC/2.471)
FROM crop_budgets_per_clumu_clu_rents_2010_2013 WHERE profit1::NUMERIC <= '-250';

SELECT SUM(clumuacres::NUMERIC/2.471)
FROM crop_budgets_per_clumu_clu_rents_2010_2013 WHERE profit2::NUMERIC <= '-250';

SELECT SUM(clumuacres::NUMERIC/2.471)
FROM crop_budgets_per_clumu_clu_rents_2010_2013 WHERE profit3::NUMERIC <= '-250';

SELECT SUM(clumuacres::NUMERIC/2.471)
FROM crop_budgets_per_clumu_clu_rents_2010_2013 WHERE profit4::NUMERIC <= '-250';

SELECT SUM(clumuacres::NUMERIC/2.471)
FROM crop_budgets_per_clumu_clu_rents_2010_2013 WHERE profit1::NUMERIC <= '-250' AND profit2::NUMERIC <= '-250.0' AND profit3::NUMERIC <= '-250.0' AND profit4::NUMERIC <= '-250.0';
