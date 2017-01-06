-- filter for profits lower than -250:
/*
DROP TABLE IF EXISTS profit1_250_ap;
CREATE TABLE profit1_250_ap
AS SELECT
fips,
twpid,
clumuacres,
profit1
FROM crop_budgets_per_clumu_clu_rents_2010_2013 
WHERE profit1::numeric <= '-250.0';

DROP TABLE IF EXISTS profit2_250_ap;
CREATE TABLE profit2_250_ap
AS SELECT
fips,
twpid,
clumuacres,
profit2
FROM crop_budgets_per_clumu_clu_rents_2010_2013 
WHERE profit2::numeric <= '-250.0';

DROP TABLE IF EXISTS profit3_250_ap;
CREATE TABLE profit3_250_ap
AS SELECT
fips,
twpid,
clumuacres,
profit3
FROM crop_budgets_per_clumu_clu_rents_2010_2013
WHERE profit3::numeric <= '-250.0';

DROP TABLE IF EXISTS profit4_250_ap;
CREATE TABLE profit4_250_ap
AS SELECT
fips,
twpid,
clumuacres,
profit4
FROM crop_budgets_per_clumu_clu_rents_2010_2013
WHERE profit4::numeric <= '-250.0';
*/

DROP TABLE IF EXISTS profit_250_ap;
CREATE TABLE profit_250_ap
AS SELECT
fips,
twpid,
clumuacres,
profit1,
profit2,
profit3,
profit4
FROM crop_budgets_per_clumu_clu_rents_2010_2013 
WHERE profit1::numeric <= '-250.0' AND profit2::numeric <= '-250.0' AND profit3::numeric <= '-250.0' AND profit4::numeric <= '-250.0';
/*
DROP TABLE IF EXISTS profit_av_250_ap;
CREATE TABLE profit_av_250_ap
AS SELECT
fips,
twpid,
clumuacres,
profit1,
profit2,
profit3,
profit4
FROM crop_budgets_per_clumu_clu_rents_2010_2013 
WHERE (profit1::numeric + profit2::numeric + profit3::numeric + profit4::numeric)/4 <= '-250.0';
*/