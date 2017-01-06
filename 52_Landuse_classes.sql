-- import tables exported from ArcGIS: 
-- "CDL_cropland_area_counties": contains pixel counts in non-cropland, cropland, and background for the original CDL 
-- "cdl_prairie_cropland_area_counties": contains pixel counts in non-cropland, cropland, and background for the 7 prairie scenarios integrated into CDL
-- 1. for original CDL raster:
-- get rid of the background pixels
/*
DROP TABLE
IF EXISTS CDL_non_cropland_per_county;

CREATE TABLE CDL_non_cropland_per_county AS SELECT
	"IowaCounti" AS County_ID,
	"Count" AS Pixels,
	"CDL_2015_r" AS Landuse_class
FROM
	"CDL_cropland_area_counties"
WHERE
	"CDL_2015_r" != 999
ORDER BY
	County_ID;

-- sum up classes 1 and 2 to total ag land
DROP TABLE
IF EXISTS CDL_non_cropland_per_county_sums;

CREATE TABLE CDL_non_cropland_per_county_sums AS SELECT
	county_id,
	SUM (pixels) * 900 * 0.0001 AS total_agland_ha
FROM
	CDL_non_cropland_per_county
GROUP BY
	county_id
ORDER BY
	County_ID;

-- check total agland:
SELECT
	SUM (total_agland_ha)
FROM
	cdl_non_cropland_per_county_sums;

-- join the sums to the table with non-cropland and cropland:
DROP TABLE
IF EXISTS CDL_non_cropland_per_county_percent;

CREATE TABLE CDL_non_cropland_per_county_percent AS SELECT
	t1.county_id,
	t1.landuse_class,
	t1.pixels,
	t2.total_agland_ha
FROM
	CDL_non_cropland_per_county AS t1
INNER JOIN CDL_non_cropland_per_county_sums AS t2 ON t1.county_id = t2.county_id;



-- calculate percent of non-cropland

ALTER TABLE CDL_non_cropland_per_county_percent
ADD COLUMN ag_land_percent numeric;



UPDATE CDL_non_cropland_per_county_percent
SET ag_land_percent = (pixels * 900 * 0.0001) / total_agland_ha;



-- select only non-cropland in a new table:

DROP TABLE IF EXISTS CDL_non_cropland_per_county_percent2;


CREATE TABLE CDL_non_cropland_per_county_percent2
AS SELECT 
*
FROM CDL_non_cropland_per_county_percent
WHERE landuse_class = 2;
*/


-- 2. for prairie-integrated CDL raster:
-- imported table shows all combinations of 1, 2, and 99 values that exist in each county, and the counts of pixels for each combination.
-- NOTE: Since prairie patches are not always covering only corn or soybean fields of the 2015 CDL, the 999 values are slightly different. 
-- get rid of background pixels: Change the values 999 to NULL
/*
UPDATE cdl_prairie_cropland_area_counties
SET prairie1 = NULL WHERE prairie1 = '999';


UPDATE cdl_prairie_cropland_area_counties
SET prairie2 = NULL WHERE prairie2 = '999';


UPDATE cdl_prairie_cropland_area_counties
SET prairie3 = NULL WHERE prairie3 = '999';


UPDATE cdl_prairie_cropland_area_counties
SET prairie4 = NULL WHERE prairie4 = '999';


UPDATE cdl_prairie_cropland_area_counties
SET prairie5 = NULL WHERE prairie5 = '999';


UPDATE cdl_prairie_cropland_area_counties
SET prairie6 = NULL WHERE prairie6 = '999';


UPDATE cdl_prairie_cropland_area_counties
SET prairie7 = NULL WHERE prairie7 = '999';

*/

-- for each scenario, calculate total area of land in category 1 and 2 (from pixel area of 900 square meters)
/*
DROP TABLE IF EXISTS cdl_prairie1_agland_sums;


CREATE TABLE cdl_prairie1_agland_sums
AS SELECT 
county_id,
sum("Count") * 900 * 0.0001 AS total_agland_ha
FROM cdl_prairie_cropland_area_counties
WHERE prairie1 IS NOT NULL
GROUP BY county_id;



DROP TABLE IF EXISTS cdl_prairie2_agland_sums;


CREATE TABLE cdl_prairie2_agland_sums
AS SELECT 
county_id,
sum("Count") * 900 * 0.0001 AS total_agland_ha
FROM cdl_prairie_cropland_area_counties
WHERE prairie2 IS NOT NULL
GROUP BY county_id;



DROP TABLE IF EXISTS cdl_prairie3_agland_sums;


CREATE TABLE cdl_prairie3_agland_sums
AS SELECT 
county_id,
sum("Count") * 900 * 0.0001 AS total_agland_ha
FROM cdl_prairie_cropland_area_counties
WHERE prairie3 IS NOT NULL
GROUP BY county_id;



DROP TABLE IF EXISTS cdl_prairie4_agland_sums;


CREATE TABLE cdl_prairie4_agland_sums
AS SELECT 
county_id,
sum("Count") * 900 * 0.0001 AS total_agland_ha
FROM cdl_prairie_cropland_area_counties
WHERE prairie4 IS NOT NULL
GROUP BY county_id;



DROP TABLE IF EXISTS cdl_prairie5_agland_sums;


CREATE TABLE cdl_prairie5_agland_sums
AS SELECT 
county_id,
sum("Count") * 900 * 0.0001 AS total_agland_ha
FROM cdl_prairie_cropland_area_counties
WHERE prairie5 IS NOT NULL
GROUP BY county_id;



DROP TABLE IF EXISTS cdl_prairie6_agland_sums;


CREATE TABLE cdl_prairie6_agland_sums
AS SELECT 
county_id,
sum("Count") * 900 * 0.0001 AS total_agland_ha
FROM cdl_prairie_cropland_area_counties
WHERE prairie6 IS NOT NULL
GROUP BY county_id;



DROP TABLE IF EXISTS cdl_prairie7_agland_sums;


CREATE TABLE cdl_prairie7_agland_sums
AS SELECT 
county_id,
sum("Count") * 900 * 0.0001 AS total_agland_ha
FROM cdl_prairie_cropland_area_counties
WHERE prairie7 IS NOT NULL
GROUP BY county_id;

*/

--SELECT sum(total_agland_ha) FROM cdl_prairie7_agland_sums

-- join the agland sums to the pixel counts for non-cropland (category 2)

-- prairie1: 
DROP TABLE IF EXISTS cdl_prairie1_non_cropland_per_county_percent;


CREATE TABLE cdl_prairie1_non_cropland_per_county_percent AS 
WITH non_crop_table AS (
SELECT
county_id,
sum("Count") * 900 * 0.0001 AS non_cropland_ha
FROM cdl_prairie_cropland_area_counties 
WHERE prairie1 = '2'
GROUP BY county_id)
SELECT
t1.county_id,
t1.non_cropland_ha,
t2.total_agland_ha
FROM non_crop_table AS t1
INNER JOIN cdl_prairie1_agland_sums AS t2 ON t1.county_id = t2.county_id;



ALTER TABLE cdl_prairie1_non_cropland_per_county_percent
ADD COLUMN non_cropland_percent1 FLOAT;



UPDATE cdl_prairie1_non_cropland_per_county_percent
SET non_cropland_percent1 = non_cropland_ha / total_agland_ha;



-- prairie2: 
DROP TABLE IF EXISTS cdl_prairie2_non_cropland_per_county_percent;


CREATE TABLE cdl_prairie2_non_cropland_per_county_percent AS 
WITH non_crop_table AS (
SELECT
county_id,
sum("Count") * 900 * 0.0001 AS non_cropland_ha
FROM cdl_prairie_cropland_area_counties 
WHERE prairie2 = '2'
GROUP BY county_id)
SELECT
t1.county_id,
t1.non_cropland_ha,
t2.total_agland_ha
FROM non_crop_table AS t1
INNER JOIN cdl_prairie2_agland_sums AS t2 ON t1.county_id = t2.county_id;



ALTER TABLE cdl_prairie2_non_cropland_per_county_percent
ADD COLUMN non_cropland_percent2 FLOAT;



UPDATE cdl_prairie2_non_cropland_per_county_percent
SET non_cropland_percent2 = non_cropland_ha / total_agland_ha;



-- prairie3: 
DROP TABLE
IF EXISTS cdl_prairie3_non_cropland_per_county_percent;



CREATE TABLE cdl_prairie3_non_cropland_per_county_percent AS WITH non_crop_table AS (
	SELECT
		county_id,
		SUM ("Count") * 900 * 0.0001 AS non_cropland_ha
	FROM
		cdl_prairie_cropland_area_counties
	WHERE
		prairie3 = '2'
	GROUP BY
		county_id
) SELECT
	t1.county_id,
	t1.non_cropland_ha,
	t2.total_agland_ha
FROM
	non_crop_table AS t1
INNER JOIN cdl_prairie3_agland_sums AS t2 ON t1.county_id = t2.county_id;

ALTER TABLE cdl_prairie3_non_cropland_per_county_percent ADD COLUMN non_cropland_percent3 FLOAT;

UPDATE cdl_prairie3_non_cropland_per_county_percent
SET non_cropland_percent3 = non_cropland_ha / total_agland_ha;

-- prairie4: 
DROP TABLE
IF EXISTS cdl_prairie4_non_cropland_per_county_percent;

CREATE TABLE cdl_prairie4_non_cropland_per_county_percent AS WITH non_crop_table AS (
	SELECT
		county_id,
		SUM ("Count") * 900 * 0.0001 AS non_cropland_ha
	FROM
		cdl_prairie_cropland_area_counties
	WHERE
		prairie4 = '2'
	GROUP BY
		county_id
) SELECT
	t1.county_id,
	t1.non_cropland_ha,
	t2.total_agland_ha
FROM
	non_crop_table AS t1
INNER JOIN cdl_prairie4_agland_sums AS t2 ON t1.county_id = t2.county_id;

ALTER TABLE cdl_prairie4_non_cropland_per_county_percent ADD COLUMN non_cropland_percent4 FLOAT;

UPDATE cdl_prairie4_non_cropland_per_county_percent
SET non_cropland_percent4 = non_cropland_ha / total_agland_ha;

-- prairie5: 
DROP TABLE
IF EXISTS cdl_prairie5_non_cropland_per_county_percent;

CREATE TABLE cdl_prairie5_non_cropland_per_county_percent AS WITH non_crop_table AS (
	SELECT
		county_id,
		SUM ("Count") * 900 * 0.0001 AS non_cropland_ha
	FROM
		cdl_prairie_cropland_area_counties
	WHERE
		prairie5 = '2'
	GROUP BY
		county_id
) SELECT
	t1.county_id,
	t1.non_cropland_ha,
	t2.total_agland_ha
FROM
	non_crop_table AS t1
INNER JOIN cdl_prairie5_agland_sums AS t2 ON t1.county_id = t2.county_id;

ALTER TABLE cdl_prairie5_non_cropland_per_county_percent ADD COLUMN non_cropland_percent5 FLOAT;

UPDATE cdl_prairie5_non_cropland_per_county_percent
SET non_cropland_percent5 = non_cropland_ha / total_agland_ha;

-- prairie6: 
DROP TABLE
IF EXISTS cdl_prairie6_non_cropland_per_county_percent;

CREATE TABLE cdl_prairie6_non_cropland_per_county_percent AS WITH non_crop_table AS (
	SELECT
		county_id,
		SUM ("Count") * 900 * 0.0001 AS non_cropland_ha
	FROM
		cdl_prairie_cropland_area_counties
	WHERE
		prairie6 = '2'
	GROUP BY
		county_id
) SELECT
	t1.county_id,
	t1.non_cropland_ha,
	t2.total_agland_ha
FROM
	non_crop_table AS t1
INNER JOIN cdl_prairie6_agland_sums AS t2 ON t1.county_id = t2.county_id;

ALTER TABLE cdl_prairie6_non_cropland_per_county_percent ADD COLUMN non_cropland_percent6 FLOAT;

UPDATE cdl_prairie6_non_cropland_per_county_percent
SET non_cropland_percent6 = non_cropland_ha / total_agland_ha;

-- prairie7: 
DROP TABLE
IF EXISTS cdl_prairie7_non_cropland_per_county_percent;

CREATE TABLE cdl_prairie7_non_cropland_per_county_percent AS WITH non_crop_table AS (
	SELECT
		county_id,
		SUM ("Count") * 900 * 0.0001 AS non_cropland_ha
	FROM
		cdl_prairie_cropland_area_counties
	WHERE
		prairie7 = '2'
	GROUP BY
		county_id
) SELECT
	t1.county_id,
	t1.non_cropland_ha,
	t2.total_agland_ha
FROM
	non_crop_table AS t1
INNER JOIN cdl_prairie7_agland_sums AS t2 ON t1.county_id = t2.county_id;

ALTER TABLE cdl_prairie7_non_cropland_per_county_percent ADD COLUMN non_cropland_percent7 FLOAT;

UPDATE cdl_prairie7_non_cropland_per_county_percent
SET non_cropland_percent7 = non_cropland_ha / total_agland_ha;
