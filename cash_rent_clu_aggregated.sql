-- to select all tables and indexes from the database:
SELECT * FROM SQLITE_MASTER
-- give table results an alias for the row id: and id INTEGER PRIMARY KEY:
ALTER TABLE results
ADD id INTEGER PRIMARY KEY

SELECT * FROM results
WHERE fips = "IA151"

ORDER BY cluid, mukey
-- to see the unique row ID:
SELECT ROWID, cluid FROM results

-- To show specific columns from the table:
SELECT cluid, yield1, yield2, yield3, yield4 FROM "results"

-- to show the types of data in the column(s):
SELECT yield1, TYPEOF(yield1) FROM results

------------------------------------------------------------------------------------------START---------------------------------------------------------
-- create index to speed up queries:
 
CREATE INDEX IF NOT EXISTS re_cluid ON results (cluid);

------
-- create an empty table to import township data into from txt file:
CREATE TABLE clu_township (cluid INT, twpid INT);
-- then import the file.
SELECT * FROM clu_township
ORDER BY twpid

CREATE INDEX IF NOT EXISTS t_cluid ON clu_township (cluid);
------

drop table county

-- create a new table named clu_rents_cb that contains the weighted averages of cashrents for each CLU
-- after AS SELECT, name the column and then the name the new column should have. 
-- also, add the cb_input_costs for each year, as they are on a CLU basis. Names and values stay the same for these.
-- finally, group by CLU.

CREATE TABLE clu_rents_cb
AS SELECT cluid, sum(clumuacres) AS cluacres, sum(cashrent*100 * clumuacres)/sum(clumuacres) AS clu_cashrent,  cb_input_costs1*100 AS cb_input_costs1, cb_input_costs2*100 AS cb_input_costs2, cb_input_costs3*100 AS cb_input_costs3, cb_input_costs4*100 AS cb_input_costs4
FROM results
GROUP BY cluid
ORDER BY cluid;

SELECT * FROM "clu_rents_cb"

CREATE INDEX IF NOT EXISTS c_cluid ON clu_rents_cb (cluid);

CREATE TABLE twp_clu_rents_cb
AS SELECT t.twpid, c.cluid, cluacres, clu_cashrent,  cb_input_costs1, cb_input_costs2, cb_input_costs3, cb_input_costs4
FROM clu_rents_cb AS c
JOIN clu_township AS t ON c.cluid = t.cluid
ORDER BY c.cluid;

SELECT * FROM "twp_clu_rents_cb"
ORDER BY twpid

-- scenario: actual prices for each year (AP)
-- create a table with cluid, mukey, cashrent, cb_input_costs and prices with those values repeated for each mukey within a given cluid:

CREATE TABLE clu_rents_cb_AP_prices_mukey
AS
SELECT r.fips, c.twpid, r.cluid, r.mukey, c.cluacres, c.clu_cashrent, r.crop1, r.crop2, r.crop3, r.crop4, c.cb_input_costs1, c.cb_input_costs2, c.cb_input_costs3, c.cb_input_costs4
, CASE("crop1") WHEN "CG" THEN 383 ELSE 997 END price1_AP
, CASE("crop2") WHEN "CG" THEN 602 ELSE 1253 END price2_AP
, CASE("crop3") WHEN "CG" THEN 667 ELSE 1396 END price3_AP
, CASE("crop4") WHEN "CG" THEN 615 ELSE 1407 END price4_AP
FROM results AS r
JOIN twp_clu_rents_cb AS c ON r.cluid = c.cluid
ORDER BY r.cluid, r.mukey;

SELECT * FROM clu_rents_cb_AP_prices_mukey


CREATE INDEX IF NOT EXISTS crcApm_cluid ON clu_rents_cb_AP_prices_mukey (cluid);
CREATE INDEX IF NOT EXISTS crcApm_mukey ON clu_rents_cb_AP_prices_mukey (mukey);



-- the second table is "yields", simply slect the cluid, mukey and yields from the results table:

CREATE TABLE yields
AS SELECT 
cluid, mukey, clumuacres, yield1, yield2, yield3, yield4
FROM results
ORDER BY cluid, mukey;

SELECT * FROM "yields"

-- create indexes for the yield table:

CREATE INDEX IF NOT EXISTS y_cluid ON yields (cluid);
CREATE INDEX IF NOT EXISTS y_mukey ON yields (mukey);

-- the two tables are linked via the common fields "cluid" and "mukey" 
-- create a new table selecting yields and other data from yields and clu_rents_cb_prices_mukey table:

-- THIS QUERY TAKES A LONG TIME:

CREATE TABLE  clu_rents_cb_AP_prices_yields
AS 
SELECT c.fips, c.twpid, c.cluid, c.mukey, y.clumuacres, c.cluacres, c.crop1, y.yield1, c.crop2, y.yield2, c.crop3, y.yield3, c.crop4, y.yield4, c.clu_cashrent, c.cb_input_costs1, c.cb_input_costs2, c.cb_input_costs3, c.cb_input_costs4
, c.price1_AP 
, c.price2_AP 
, c.price3_AP 
, c.price4_AP 
FROM yields AS y
INNER JOIN clu_rents_cb_AP_prices_mukey AS c ON c.cluid = y.cluid AND c.mukey = y.mukey
ORDER BY y.cluid, y.mukey;

SELECT * FROM "clu_rents_cb_AP_prices_yields"


CREATE INDEX IF NOT EXISTS crcApy_cluid ON clu_rents_cb_AP_prices_yields (cluid);

-- to create a new table named profit_roi with the calculated profits and ROI for each clu-mu combination, taking the clu-averaged rents and crop prices into account.
-- profit = (yield * price) - (crop budget + cashrent)
-- ROI = profit / (crop budget + cashrent)



-- calculate profit and ROI
-- transform profit to $/ha and filter out zero yields


CREATE TABLE profit_roi_metric_AP
AS
SELECT fips, twpid, cluid, mukey, clumuacres, cluacres, crop1, yield1, crop2, yield2, crop3, yield3, crop4, yield4, CAST(CAST(clu_cashrent AS INT)AS REAL)/100 AS clu_cashrent
, (CAST(CAST((yield1 * price1_AP) - (cb_input_costs1 + clu_cashrent) AS INT)AS REAL)/100) * 2.471 AS profit1_AP 
, (CAST(CAST((yield2 * price2_AP) - (cb_input_costs2 + clu_cashrent) AS INT)AS REAL)/100) * 2.471 AS profit2_AP 
, (CAST(CAST((yield3 * price3_AP) - (cb_input_costs3 + clu_cashrent) AS INT)AS REAL)/100) * 2.471 AS profit3_AP 
, (CAST(CAST((yield4 * price4_AP) - (cb_input_costs4 + clu_cashrent) AS INT)AS REAL)/100) * 2.471 AS profit4_AP 
, ((yield1 * price1_AP) - (cb_input_costs1 + clu_cashrent)) / (cb_input_costs1 + clu_cashrent) AS ROI1_AP 
, ((yield2 * price2_AP) - (cb_input_costs2 + clu_cashrent)) / (cb_input_costs2 + clu_cashrent) AS ROI2_AP 
, ((yield3 * price3_AP) - (cb_input_costs3 + clu_cashrent)) / (cb_input_costs3 + clu_cashrent) AS ROI3_AP 
, ((yield4 * price4_AP) - (cb_input_costs4 + clu_cashrent)) / (cb_input_costs4 + clu_cashrent) AS ROI4_AP 
FROM clu_rents_cb_AP_prices_yields
WHERE yield1 > 0 AND yield2 >0 AND yield3 >0 AND yield4 >0
ORDER BY fips, cluid, mukey;

SELECT * FROM profit_roi_metric_AP
WHERE fips = "IA002"
ORDER BY cluid, mukey

CREATE INDEX IF NOT EXISTS prma_twpid ON profit_roi_metric_AP (twpid);

CREATE TABLE corn_yields_twp
AS
SELECT fips, twpid, crop1, yield1, crop2, yield2, crop3, yield3, crop4, yield4
CASE ("crop1") WHEN "CG"  THEN    sum(yield1 * clumuacres)/sum(clumuacres) AS corn_yield1
FROM profit_roi_metric_AP

GROUP BY twpid

------------------------------------------------------------------------------------------END---------------------------------------------------------
-- the identifyer fips for the county in the table profit_roi_metric_AP is different from the county no in the township shapefile.
-- therefore, I need to connect the fips with county no overthe county name.

-- create an empty table to import county data into from txt file:
CREATE TABLE county_import (fips , county);
-- then import the file.
SELECT * FROM county_import
ORDER BY county

CREATE TABLE county
AS SELECT DISTINCT fips, county
FROM county_import;

SELECT * FROM county
WHERE county = "name";

DELETE FROM county
WHERE county = "name";

SELECT * FROM county

--- join this table with the table profit_roi_metric_AP:

CREATE TABLE  profit_roi_metric_AP_county
AS 
SELECT
p.fips, county, twpid, cluid, mukey, clumuacres, cluacres, crop1, yield1, crop2, yield2, crop3, yield3, crop4, yield4, profit1_AP, profit2_AP, profit3_AP, profit4_AP,  ROI1_AP, ROI2_AP , ROI3_AP , ROI4_AP  
FROM  profit_roi_metric_AP AS p
INNER JOIN county AS c ON c.fips = p.fips;

SELECT * FROM profit_roi_metric_AP_county

DROP TABLE profit_roi_metric_AP_county_delete

CREATE INDEX IF NOT EXISTS prm_county ON profit_roi_metric_AP_county (county);
CREATE INDEX IF NOT EXISTS prm_clumuacres ON profit_roi_metric_AP_county (clumuacres);

-- from table corn_profit_roi_metric, calculate corn area percentage and total ha in corn and/or beans per twpid:

CREATE TABLE corn_area
AS SELECT twpid, clumuacres
,   CASE("crop1") WHEN "CG" THEN  clumuacres ELSE NULL END AS corn_ac_2010
,   CASE("crop2") WHEN "CG" THEN  clumuacres ELSE NULL END AS corn_ac_2011
,   CASE("crop3") WHEN "CG" THEN  clumuacres ELSE NULL END AS corn_ac_2012
,   CASE("crop4") WHEN "CG" THEN  clumuacres ELSE NULL END AS corn_ac_2013
FROM corn_profit_roi_metric
ORDER BY twpid;

SELECT * FROM corn_area
CREATE INDEX IF NOT EXISTS ca_twpid ON corn_area (twpid);


CREATE TABLE corn_area_percentage
AS SELECT  twpid, sum(clumuacres) AS twp_acres
,  sum(corn_ac_2010)/ sum(clumuacres) AS percent_corn_2010
, sum(corn_ac_2011)/ sum(clumuacres) AS percent_corn_2011
, sum(corn_ac_2012)/ sum(clumuacres) AS percent_corn_2012
, sum(corn_ac_2013)/ sum(clumuacres) AS percent_corn_2013
FROM corn_area
GROUP BY twpid
ORDER BY twpid;

SELECT * FROM corn_area_percentage