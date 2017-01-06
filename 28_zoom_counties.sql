
-- for boone county, 2010-2013:
/*
DROP TABLE IF EXISTS boone_zoom_2010_2013;
CREATE TABLE  boone_zoom_2010_2013
AS SELECT
twpid,
fips,
cluid,
mukey,
cluid_mukey,
clumuacres,
year1,
crop1,
yield1,
budget_2010,
clu_cashrent_2010,
profit1,
year2,
crop2,
yield2,
budget_2011,
clu_cashrent_2011,
profit2,
year3,
crop3,
yield3,
budget_2012,
clu_cashrent_2012,
profit3,
year4,
crop4,
yield4,
budget_2013,
clu_cashrent_2013,
profit4
FROM crop_budgets_per_clumu_clu_rents_2010_2013
WHERE fips = 'IA015';
*/
-- 2015:

DROP TABLE IF EXISTS boone_zoom_2015;
CREATE TABLE  boone_zoom_2015
AS SELECT
twpid,
fips,
cluid,
mukey,
cluid_mukey,
clumuacres,
ccrop as current_crop,
yield_2015,
budget_2015,
clu_adj_rent_2015,
profit_2015
FROM crop_budgets_per_clumu_2015_twp_yields
WHERE fips = 'IA015';


-- for washington county, 2015:

DROP TABLE IF EXISTS washington_zoom_2015;
CREATE TABLE  washington_zoom_2015
AS SELECT
twpid,
fips,
cluid,
mukey,
cluid_mukey,
clumuacres,
ccrop as current_crop,
yield_2015,
budget_2015,
clu_adj_rent_2015,
profit_2015
FROM crop_budgets_per_clumu_2015_twp_yields
WHERE fips = 'IA183';

-- for buena vista county, 2015:

DROP TABLE IF EXISTS buenavista_zoom_2015;
CREATE TABLE  buenavista_zoom_2015
AS SELECT
twpid,
fips,
cluid,
mukey,
cluid_mukey,
clumuacres,
ccrop as current_crop,
yield_2015,
budget_2015,
clu_adj_rent_2015,
profit_2015
FROM crop_budgets_per_clumu_2015_twp_yields
WHERE fips = 'IA021';
