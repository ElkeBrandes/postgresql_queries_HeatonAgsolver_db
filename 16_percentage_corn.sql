-- aggregate the area in corn and soy to the township level:
/*
DROP TABLE IF EXISTS twp_corn_soy_area1;
CREATE TABLE twp_corn_soy_area1
AS SELECT
twpid,
SUM(corn1_clumuacres::NUMERIC)/2.471  AS twp_corn1_ha,
SUM (soy1_clumuacres::NUMERIC) / 2.471 AS twp_soy1_ha,
SUM(corn2_clumuacres::NUMERIC)/2.471  AS twp_corn2_ha,
SUM (soy2_clumuacres::NUMERIC) / 2.471 AS twp_soy2_ha,
SUM(corn3_clumuacres::NUMERIC)/2.471  AS twp_corn3_ha,
SUM (soy3_clumuacres::NUMERIC) / 2.471 AS twp_soy3_ha,
SUM(corn4_clumuacres::NUMERIC)/2.471  AS twp_corn4_ha,
SUM (soy4_clumuacres::NUMERIC) / 2.471 AS twp_soy4_ha
FROM corn_soy_yields
GROUP BY twpid
ORDER BY twpid;
*/




-- join with total ha:
/*
DROP TABLE IF EXISTS twp_corn_soy_area;
CREATE TABLE twp_corn_soy_area
AS SELECT
t2.total_ha,
t1.*
FROM twp_corn_soy_area1 AS t1 
JOIN twp_total_ha as t2 ON t1.twpid = t2.twpid;


-- filter out townships with <700 ha:
update twp_corn_soy_area
set twp_corn1_ha =NULL WHERE total_ha < '700';
update twp_corn_soy_area
set twp_soy1_ha =NULL WHERE total_ha < '700';
update twp_corn_soy_area
set twp_corn2_ha =NULL WHERE total_ha < '700';
update twp_corn_soy_area
set twp_soy2_ha =NULL WHERE total_ha < '700';
update twp_corn_soy_area
set twp_corn3_ha =NULL WHERE total_ha < '700';
update twp_corn_soy_area
set twp_soy3_ha =NULL WHERE total_ha < '700';
update twp_corn_soy_area
set twp_corn4_ha =NULL WHERE total_ha < '700';
update twp_corn_soy_area
set twp_soy4_ha =NULL WHERE total_ha < '700';

-- calculate percentage

alter table twp_corn_soy_area
add column twp_corn1_percent real,
add column twp_soy1_percent real,
add column twp_corn2_percent real,
add column twp_soy2_percent real,
add column twp_corn3_percent real,
add column twp_soy3_percent real,
add column twp_corn4_percent real,
add column twp_soy4_percent real;
*/

update twp_corn_soy_area
set twp_corn1_percent = ( twp_corn1_ha / total_ha ) * 100;
update twp_corn_soy_area
set twp_soy1_percent = ( twp_soy1_ha / total_ha ) * 100;
update twp_corn_soy_area
set twp_corn2_percent = ( twp_corn2_ha / total_ha ) * 100;
update twp_corn_soy_area
set twp_soy2_percent = ( twp_soy2_ha / total_ha ) * 100;
update twp_corn_soy_area
set twp_corn3_percent = ( twp_corn3_ha / total_ha ) * 100;
update twp_corn_soy_area
set twp_soy3_percent = ( twp_soy3_ha / total_ha ) * 100;
update twp_corn_soy_area
set twp_corn4_percent = ( twp_corn4_ha / total_ha ) * 100;
update twp_corn_soy_area
set twp_soy4_percent = ( twp_soy4_ha / total_ha ) * 100;
