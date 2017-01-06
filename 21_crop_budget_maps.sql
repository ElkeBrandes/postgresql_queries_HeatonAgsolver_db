-- calculate area weighted crop budget averages for each township for 2010 - 2013 and 2015

DROP TABLE IF EXISTS crop_budgets_twp_ap;
CREATE TABLE crop_budgets_twp_ap
AS SELECT
twpid,
sum(clumuacres::numeric)/2.471 as total_ha,
(sum(budget_2010::NUMERIC * clumuacres::NUMERIC)/NULLIF (sum(clumuacres::NUMERIC),0))*2.471 AS twp_crop_budget_2010,
(sum(budget_2011::NUMERIC * clumuacres::NUMERIC)/NULLIF (sum(clumuacres::NUMERIC),0))*2.471 AS twp_crop_budget_2011,
(sum(budget_2012::NUMERIC * clumuacres::NUMERIC)/NULLIF (sum(clumuacres::NUMERIC),0))*2.471 AS twp_crop_budget_2012,
(sum(budget_2013::NUMERIC * clumuacres::NUMERIC)/NULLIF (sum(clumuacres::NUMERIC),0))*2.471 AS twp_crop_budget_2013
FROM crop_budgets_per_clumu_clu_rents_2010_2013
GROUP BY twpid
ORDER BY twpid;

UPDATE crop_budgets_twp_ap
SET twp_crop_budget_2010 = 99999 WHERE total_ha < 700;
UPDATE crop_budgets_twp_ap
SET twp_crop_budget_2011 = 99999 WHERE total_ha < 700;
UPDATE crop_budgets_twp_ap
SET twp_crop_budget_2012 = 99999 WHERE total_ha < 700;
UPDATE crop_budgets_twp_ap
SET twp_crop_budget_2013 = 99999 WHERE total_ha < 700;


-- calculate area weighted crop budget averages for the year 2014:

/*
DROP TABLE IF EXISTS crop_budget_twp_2015;
CREATE TABLE crop_budget_twp_2015
AS SELECT
twpid,
sum(clumuacres::numeric)/2.471 as total_ha,
(sum(budget_2015::NUMERIC * clumuacres::NUMERIC)/NULLIF (sum(clumuacres::NUMERIC),0))*2.471 AS twp_crop_budget_2015
FROM crop_budgets_per_clumu_2015_twp
GROUP BY twpid
ORDER BY twpid;

UPDATE crop_budget_twp_2015
SET twp_crop_budget_2015 = 99999 WHERE total_ha < 700;
*/