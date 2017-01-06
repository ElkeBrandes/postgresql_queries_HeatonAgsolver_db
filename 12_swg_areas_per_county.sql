-- after having done the spatial processing in ArcGIS to identify areas that should go into switchgrass, 
-- import the txt file exported from ArcGIS (I use psql because it is faster: 
-- \copy  swg_scenarios from C:/Users/ebrandes/Documents/swg_scenarios.txt DELIMITER ' '

-- there are a lot of 'NULL' values for fips, that means that there is no attribute data associated with the polygon 
-- most likely because that polygon was not continuously in corn/soybean from 2012-2015.
-- the null values are filled with a character 'NULL'. First I want to replace those by real NULL VALUES.
-- Also, there is one row that includes the column NAMES I want to get rid OF.
/*
DELETE FROM swg_scenarios
WHERE "FIPS" = 'NULL' OR "FIPS" = 'FIPS';
*/

/*
DROP TABLE IF EXISTS "12_swg_areas_county";
CREATE TABLE "12_swg_areas_county" AS 
WITH min_16_table AS (
SELECT
"FIPS",
SUM("SHAPE_AREA"::NUMERIC)*0.0001 AS in_swg_min_16
FROM swg_scenarios 
WHERE "IN_SWG_MIN_16_10000_20" = 'TRUE' 
GROUP BY "FIPS"
),
"2nd_16_table" AS (
SELECT
"FIPS",
SUM("SHAPE_AREA"::NUMERIC)*0.0001 AS in_swg_2nd_16
FROM swg_scenarios 
WHERE "IN_SWG_2ND_16_10000_20" = 'TRUE' 
GROUP BY "FIPS"
),
min_6_table AS (
SELECT
"FIPS",
SUM("SHAPE_AREA"::NUMERIC)*0.0001 AS in_swg_min_6
FROM swg_scenarios 
WHERE "IN_SWG_MIN_6_10000_20" = 'TRUE' 
GROUP BY "FIPS"
),
"2nd_6_table" AS (
SELECT
"FIPS",
SUM("SHAPE_AREA"::NUMERIC)*0.0001 AS in_swg_2nd_6
FROM swg_scenarios 
WHERE "IN_SWG_2ND_6_10000_20" = 'TRUE' 
GROUP BY "FIPS"
),
total_area_table AS (
SELECT DISTINCT
"FIPS",
SUM("SHAPE_AREA"::NUMERIC)*0.0001 AS total_ha
FROM swg_scenarios 
GROUP BY "FIPS"
),
fips_min_16_table AS (
SELECT 
t1.*,
t2.in_swg_min_16
FROM total_area_table AS t1
LEFT JOIN min_16_table AS t2 ON t1."FIPS" = t2."FIPS"
),
fips_16_table AS (
SELECT
t1.*,
t2.in_swg_2nd_16
FROM fips_min_16_table AS t1
LEFT JOIN "2nd_16_table" AS t2 ON t1."FIPS" = t2."FIPS"
),
fips_16_6_table AS (
SELECT
t1.*,
t2.in_swg_min_6
FROM fips_16_table AS t1
LEFT JOIN "min_6_table" AS t2 ON t1."FIPS" = t2."FIPS"
)
SELECT
t1.*,
t2.in_swg_2nd_6
FROM fips_16_6_table AS t1
LEFT JOIN "2nd_6_table" AS t2 ON t1."FIPS" = t2."FIPS";

*/

/*
UPDATE "12_swg_areas_county"
SET 
in_swg_min_16 = 0 WHERE in_swg_min_16 IS NULL;
*/

UPDATE "12_swg_areas_county"
SET 
in_swg_min_6 = 0 WHERE in_swg_min_6 IS NULL;
