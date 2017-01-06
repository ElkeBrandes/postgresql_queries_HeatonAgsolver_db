-- filter for profits lower than -500:

DROP TABLE IF EXISTS profit1_500_ap;
CREATE TABLE profit1_500_ap
AS SELECT
fips,
twpid,
clumuacres,
profit1
FROM crop_budgets_per_clumu_clu_rents_2010_2013 
WHERE profit1 <= -500.0;

DROP TABLE IF EXISTS profit2_500_ap;
CREATE TABLE profit2_500_ap
AS SELECT
fips,
twpid,
clumuacres,
profit2
FROM crop_budgets_per_clumu_clu_rents_2010_2013 
WHERE profit2 <= -500.0;

DROP TABLE IF EXISTS profit3_500_ap;
CREATE TABLE profit3_500_ap
AS SELECT
fips,
twpid,
clumuacres,
profit3
FROM crop_budgets_per_clumu_clu_rents_2010_2013
WHERE profit3 <= -500.0;

DROP TABLE IF EXISTS profit4_500_ap;
CREATE TABLE profit4_500_ap
AS SELECT
fips,
twpid,
clumuacres,
profit4
FROM crop_budgets_per_clumu_clu_rents_2010_2013
WHERE profit4 <= -500.0;


DROP TABLE IF EXISTS profit_500_ap;
CREATE TABLE profit_500_ap
AS SELECT
fips,
twpid,
clumuacres,
profit1,
profit2,
profit3,
profit4
FROM crop_budgets_per_clumu_clu_rents_2010_2013 
WHERE profit1 <= -500.0 AND profit2 <= -500.0 AND profit3 <= -500.0 AND profit4 <= -500.0;

DROP TABLE IF EXISTS profit_av_500_ap;
CREATE TABLE profit_av_500_ap
AS SELECT
fips,
twpid,
clumuacres,
profit1,
profit2,
profit3,
profit4
FROM crop_budgets_per_clumu_clu_rents_2010_2013 
WHERE (profit1 + profit2 + profit3 + profit4)/4 <= -500.0;
