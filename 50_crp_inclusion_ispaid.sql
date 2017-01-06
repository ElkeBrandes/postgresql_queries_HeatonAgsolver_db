-- fips is the county identifier used in the heaton_results table and tables derived from there: IA001, IA003, etc
-- cono is the county identifier used in ISPAID: 1, 2, etc. 
-- import table exerpt from ISPAID database, including cono, sms, drainage class etc.: ispaid_drainage_class

-- export table, add cono in excel, import table county_cono

-- join table ISPAID_drainage class with county_cono via cono
/*
DROP TABLE IF EXISTS ISPAID_fips;
CREATE TABLE ISPAID_fips
AS SELECT
t1.*,
t2.fips
FROM "ISPAID_drainage_class" AS t1 
INNER JOIN "county_cono" AS t2 ON t1.cono = t2.cono;
*/


-- join soil properties to crop_budgets_per_clumu_2015_twp_yields via unique identifier in ISPAID/SSURGO DATABASE
-- sms = soil map symbol, same as musym in heaton_results
-- hydsoicd = hydric soil code
-- floodfrqcd = flooding frequency code
-- lndscppos = landscape position
-- drnclscd = drainage class code

DROP TABLE IF EXISTS clumu_drainage_class;
CREATE TABLE clumu_drainage_class
AS SELECT 
t1.fips,
t2.cono,
t2.sms,
t2.hydsoilcd,
t2.floodfrqcd,
t2.lndscppos,
t2.drnclscd,
t1.cluid,
t1.mukey
FROM heaton_results AS t1
INNER JOIN ispaid_fips AS t2 ON t1.fips = t2.fips AND t1.musym = t2.sms;

-- join clumu_drainage_class with the tables that include data to calculate profits 


