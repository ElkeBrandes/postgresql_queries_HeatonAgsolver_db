-- take out a sub dataset with only the townships that have more than 3500 ha unprofitable land:

/*
DROP TABLE IF EXISTS profit_hotspots;
CREATE TABLE profit_hotspots
as SELECT
co_name,
twpid,
fips,
clumuacres::NUMERIC/2.471 AS clumuha,
cluid_mukey,
profit_2015
from crop_budgets_per_clumu_2015_twp_yields
WHERE "twpid" = '1031' OR
twpid = '1040' OR
twpid = '1063' OR
twpid = '1101' OR
twpid = '1162' OR
twpid = '1294' OR
twpid = '1361' OR
twpid = '1364' OR
twpid = '1513' OR
twpid = '1515' OR
twpid = '1648' OR
twpid = '169' OR
twpid = '1696' OR
twpid = '173' OR
twpid = '174' OR
twpid = '176' OR
twpid = '1799' OR
twpid = '1801' OR
twpid = '1850' OR
twpid = '1853' OR
twpid = '1854' OR
twpid = '1859' OR
twpid = '1895' OR
twpid = '1949' OR
twpid = '221' OR
twpid = '223' OR
twpid = '224' OR
twpid = '225' OR
twpid = '226' OR
twpid = '227' OR
twpid = '230' OR
twpid = '234' OR
twpid = '280' OR
twpid = '281' OR
twpid = '282' OR
twpid = '330' OR
twpid = '337' OR
twpid = '384' OR
twpid = '401' OR
twpid = '431' OR
twpid = '460' OR
twpid = '461' OR
twpid = '465' OR
twpid = '486' OR
twpid = '488' OR
twpid = '546' OR
twpid = '550' OR
twpid = '555' OR
twpid = '559' OR
twpid = '592' OR
twpid = '595' OR
twpid = '601' OR
twpid = '608' OR
twpid = '610' OR
twpid = '616' OR
twpid = '636' OR
twpid = '637' OR
twpid = '638' OR
twpid = '639' OR
twpid = '641' OR
twpid = '656' OR
twpid = '659' OR
twpid = '663' OR
twpid = '666' OR
twpid = '668' OR
twpid = '670' OR
twpid = '674' OR
twpid = '678' OR
twpid = '680' OR
twpid = '682' OR
twpid = '698' OR
twpid = '705' OR
twpid = '716' OR
twpid = '723' OR
twpid = '728' OR
twpid = '737' OR
twpid = '742' OR
twpid = '750' OR
twpid = '755' OR
twpid = '768' OR
twpid = '770' OR
twpid = '776' OR
twpid = '786' OR
twpid = '791' OR
twpid = '792' OR
twpid = '796' OR
twpid = '798' OR
twpid = '801' OR
twpid = '803' OR
twpid = '813' OR
twpid = '816' OR
twpid = '832' OR
twpid = '834' OR
twpid = '857' OR
twpid = '875' OR
twpid = '883' OR
twpid = '901' OR
twpid = '902' OR
twpid = '906' OR
twpid = '920' OR
twpid = '922' OR
twpid = '964' OR
twpid = '965' OR
twpid = '998';
*/
-- calculate average profit/ha in corn/bean for Iowa (area weighted profit average over the CLU-MU units)
-- and total area in row crop 

-- set all area losing 250 $ or more equal to zero (put into a break even management)

ALTER TABLE profit_hotspots
ADD COLUMN profit_2015_alternative float4;


UPDATE profit_hotspots
SET profit_2015_alternative = profit_2015 WHERE profit_2015 > '-250';


UPDATE profit_hotspots
SET profit_2015_alternative = '0' WHERE profit_2015 <= '-250';

UPDATE profit_hotspots
SET clumuha = NULL WHERE profit_2015 is null;

-- calculate average profit for both scenarios:

DROP TABLE IF EXISTS crop_budgets_calculations_hotspots;
CREATE TABLE crop_budgets_calculations_hotspots
AS SELECT 
sum(profit_2015 * clumuha)/sum(clumuha) AS av_profit,
sum(clumuha) AS total_ha,
sum(profit_2015_alternative * clumuha)/sum(clumuha) AS av_profit_alternative
FROM profit_hotspots;

-- SELECT sum(profit_2015_alternative * clumuha)/sum(clumuha) FROM crop_budgets_per_clumu_2015_twp_yields WHERE profit_2015_alternative != '0';

-- calculate average profit/ha in corn/bean for this scenario after taking the least profitable ha out (area weighted profit average over the CLU-MU units)

-- calculate the sum of ha that are at or below -250 on the townships with more than 3500 ha of those unprofitable areas:

SELECT 
sum(profit_2015_ha) as unprofit_ha,
sum(total_ha) as total_ha 
from profit_250_sa_township_2015_cashrents_r WHERE profit_2015_ha > 3500;

-- list those townships:
/*
DROP TABLE IF EXISTS hotspot_twp;
CREATE TABLE hotspot_twp
AS SELECT 
twpid,
total_ha,
profit_2015_ha
FROM profit_250_sa_township_2015_cashrents_r
WHERE profit_2015_ha > 3500;
*/
-- calculate total area of cropland in the 104 hot spots:

SELECT
sum(total_ha)
from profit_250_sa_township_2015_cashrents_r WHERE profit_2015_ha > 3500;