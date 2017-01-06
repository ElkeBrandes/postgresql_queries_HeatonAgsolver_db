-- include prairie budget into the prairie scenarios
-- assume the same budget: cost of 67 $/ha on areas in prairie
-- assume that cash rent does not increase on rest of the field due to higher average CSR


/*

alter table crop_budgets_per_clumu_2015_twp_yields
add column profit_prairie1 float,
add column profit_prairie2 float,
add column profit_prairie3 float,
add column profit_prairie4 float,
add column profit_prairie5 float,
add column profit_prairie6 float,
add column profit_prairie7 float;
*/
/*

UPDATE crop_budgets_per_clumu_2015_twp_yields
SET profit_prairie1 = -67 WHERE profit_2015 < -400;

UPDATE crop_budgets_per_clumu_2015_twp_yields
SET profit_prairie2 = -67 WHERE profit_2015 < -350;

UPDATE crop_budgets_per_clumu_2015_twp_yields
SET profit_prairie3 = -67 WHERE profit_2015 < -300;

UPDATE crop_budgets_per_clumu_2015_twp_yields
SET profit_prairie4 = -67 WHERE profit_2015 < -250;

UPDATE crop_budgets_per_clumu_2015_twp_yields
SET profit_prairie5 = -67 WHERE profit_2015 < -200;

UPDATE crop_budgets_per_clumu_2015_twp_yields
SET profit_prairie6 = -67 WHERE profit_2015 < -150;

UPDATE crop_budgets_per_clumu_2015_twp_yields
SET profit_prairie7 = -67 WHERE profit_2015 < -100;


UPDATE crop_budgets_per_clumu_2015_twp_yields
SET profit_prairie1 = profit_2015 WHERE profit_2015 >= -400;

UPDATE crop_budgets_per_clumu_2015_twp_yields
SET profit_prairie2 = profit_2015 WHERE profit_2015 >= -350;

UPDATE crop_budgets_per_clumu_2015_twp_yields
SET profit_prairie3 = profit_2015 WHERE profit_2015 >= -300;

UPDATE crop_budgets_per_clumu_2015_twp_yields
SET profit_prairie4 = profit_2015 WHERE profit_2015 >= -250;

UPDATE crop_budgets_per_clumu_2015_twp_yields
SET profit_prairie5 = profit_2015 WHERE profit_2015 >= -200;

UPDATE crop_budgets_per_clumu_2015_twp_yields
SET profit_prairie6 = profit_2015 WHERE profit_2015 >= -150;

UPDATE crop_budgets_per_clumu_2015_twp_yields
SET profit_prairie7 = profit_2015 WHERE profit_2015 >= -100;
*/

-- calculate area weighted average profit per county
/*
DROP TABLE IF EXISTS profit_2015_with_prairie_county;
CREATE TABLE profit_2015_with_prairie_county
AS SELECT
fips,
sum(profit_2015 * clumuacres::NUMERIC)/NULLIF (sum(clumuacres::NUMERIC),0) AS profit_2015_county,
sum(profit_prairie1 * clumuacres::NUMERIC)/NULLIF (sum(clumuacres::NUMERIC),0) AS profit_prairie1_county,
sum(profit_prairie2 * clumuacres::NUMERIC)/NULLIF (sum(clumuacres::NUMERIC),0) AS profit_prairie2_county,
sum(profit_prairie3 * clumuacres::NUMERIC)/NULLIF (sum(clumuacres::NUMERIC),0) AS profit_prairie3_county,
sum(profit_prairie4 * clumuacres::NUMERIC)/NULLIF (sum(clumuacres::NUMERIC),0) AS profit_prairie4_county,
sum(profit_prairie5 * clumuacres::NUMERIC)/NULLIF (sum(clumuacres::NUMERIC),0) AS profit_prairie5_county,
sum(profit_prairie6 * clumuacres::NUMERIC)/NULLIF (sum(clumuacres::NUMERIC),0) AS profit_prairie6_county,
sum(profit_prairie7 * clumuacres::NUMERIC)/NULLIF (sum(clumuacres::NUMERIC),0) AS profit_prairie7_county
FROM crop_budgets_per_clumu_2015_twp_yields
GROUP BY fips
ORDER BY fips;
*/

-- add fields that calculate the improvement in mean profits for each scenario:
/*
alter table profit_2015_with_prairie_county
add column change_prairie1 float,
add column change_prairie2 float,
add column change_prairie3 float,
add column change_prairie4 float,
add column change_prairie5 float,
add column change_prairie6 float,
add column change_prairie7 float;
*/

UPDATE profit_2015_with_prairie_county
SET change_prairie1 = profit_prairie1_county - profit_2015_county;
UPDATE profit_2015_with_prairie_county
SET change_prairie2 = profit_prairie2_county - profit_2015_county;
UPDATE profit_2015_with_prairie_county
SET change_prairie3 = profit_prairie3_county - profit_2015_county;
UPDATE profit_2015_with_prairie_county
SET change_prairie4 = profit_prairie4_county - profit_2015_county;
UPDATE profit_2015_with_prairie_county
SET change_prairie5 = profit_prairie5_county - profit_2015_county;
UPDATE profit_2015_with_prairie_county
SET change_prairie6 = profit_prairie6_county - profit_2015_county;
UPDATE profit_2015_with_prairie_county
SET change_prairie7 = profit_prairie7_county - profit_2015_county;
