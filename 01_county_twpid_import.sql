-- the identifyer fips for the county in the table profit_roi_metric_AP is different from the county no in the township shapefile.
-- therefore, I need to connect the fips with county no over the county name.

-- create an empty table to import county data into from txt file:

drop table if exists county_import;
CREATE TABLE county_import (fips TEXT, county_name TEXT);
-- then import the file.

drop table if exists county;
CREATE TABLE county
AS SELECT DISTINCT fips, county_name
FROM county_import;

SELECT * FROM county
ORDER BY fips


-- import township data (CLU and counties associated with each township):
--create an empty table:
drop table if exists clu_township;
CREATE TABLE clu_township (cluid INT, twpid INT);
-- import the table clu_cgsb_twp.txt file in the GIS folder townsh

drop table if exists counties_twp;
CREATE TABLE counties_twp (type INT, twp_name VARCHAR, co_name VARCHAR, twpid INT)
-- import table counties_twp from the political_townships.dbf file in the GIS folder townsh



