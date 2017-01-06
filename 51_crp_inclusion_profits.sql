-- calculate profitability with corn and soybean under new assumptions:
-- 2014
-- 2015
-- average profit 2014/2015

-- set categories for profit 2015 in table crop_budgets_per_clumu_2015_twp_yields:

alter table crop_budgets_per_clumu_2015_twp_yields
drop column profit_2015_cat varchar;


UPDATE crop_budgets_per_clumu_2015_twp_yields
SET profit_2015_cat = '<-400' WHERE profit_2015 < -400;

UPDATE crop_budgets_per_clumu_2015_twp_yields
SET profit_2015_cat = '-400 - -350' WHERE profit_2015 >= -400 AND profit_2015 < -350;

UPDATE crop_budgets_per_clumu_2015_twp_yields
SET profit_2015_cat = '-350 - -300' WHERE profit_2015 >= -350 AND profit_2015 < -300;

UPDATE crop_budgets_per_clumu_2015_twp_yields
SET profit_2015_cat = '-300 - -250' WHERE profit_2015 >= -300 AND profit_2015 < -250;

UPDATE crop_budgets_per_clumu_2015_twp_yields
SET profit_2015_cat = '-250 - -200' WHERE profit_2015 >= -250 AND profit_2015 < -200;

UPDATE crop_budgets_per_clumu_2015_twp_yields
SET profit_2015_cat = '-200 - -150' WHERE profit_2015 >= -200 AND profit_2015 < -150;

UPDATE crop_budgets_per_clumu_2015_twp_yields
SET profit_2015_cat = '-150 - -100' WHERE profit_2015 >= -150 AND profit_2015 < -100;

UPDATE crop_budgets_per_clumu_2015_twp_yields
SET profit_2015_cat = '-100 - 0' WHERE profit_2015 >= -100 AND profit_2015 < 0;

UPDATE crop_budgets_per_clumu_2015_twp_yields
SET profit_2015_cat = '>0' WHERE profit_2015 >= 0;



-- set "diversification range" for disproportionate ESS benefits hypothesis: 
-- based on average profit 2014/2015, select areas below the profit thresholds:
-- -100 $/ha
-- -150 $/ha
-- -200 $/ha
-- -250 $/ha
-- -300 $/ha 
-- -350 $/ha 
-- -400 $/ha 

-- per conversion scenario:
-- create a new crop category for new land cover "CP", to distinguish CG, SB, CP.
-- create a new column that concatenates CLUID and crop. 
-- re-calculate area weighted cashrents by aggregating over CLUID_crop. 
-- for CP, re-calculate paid cashrents by selecting the three highest cash rents and 
-- calculate the area weighted average of those for the complete CLUID_crop (window function)
/*
UPDATE <table_name>
SET CLUID_crop AS area...(area weighted average) OVER (PARTITION BY cluid)
WHERE crop = CP 
*/
-- add column for profit_2014_2015: 
-- fill it with CP "profit": 
-- select for dry mesic, mesic, and wet mesic prairie:
-- if soil drainage class <= 30 then use dry mesic seed mix
-- if 35 <= soil drainage class <=  45 then use mesic seed mix
-- if 50 <=soil drainage class <= 55 then use wet mesic seed mix
-- if soil drainage class >= 60 then don't put into prairie

-- fill it with row crop profit:
-- use the newly calculated cash rents, yields, production costs, grain prices to calculate profit 