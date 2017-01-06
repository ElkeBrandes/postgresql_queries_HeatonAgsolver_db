-- create a new table revenue_rounded, taking yields from heaton_results

/*
DROP TABLE IF EXISTS revenue_rounded;
CREATE TABLE revenue_rounded
AS SELECT 
cluid || mukey AS cluid_mukey,
clumuacres,
crop1,
yield1,
crop2,
yield2,
crop3,
yield3,
crop4,
yield4
FROM heaton_results;
*/
/*
alter table revenue_rounded
add column corn_rev1 float4,
add column soy_rev1 float4,
add column corn_rev2 float4,
add column soy_rev2 float4,
add column corn_rev3 float4,
add column soy_rev3 float4,
add column corn_rev4 float4,
add column soy_rev4 float4;
*/

-- calculate corn and soybean revenue by multiplying yield with price for each year
/*
-- 2010:
update revenue_rounded
set corn_rev1 = round((yield1::NUMERIC * 5.46) * 2.471,0)
where crop1 = 'CG';

update revenue_rounded
set soy_rev1 = round((yield1::NUMERIC * 12.08) * 2.471,0)
where crop1 = 'SB';


-- 2011:
update revenue_rounded
set corn_rev2 = round((yield2::NUMERIC * 6.35) * 2.471,0)
where crop2 = 'CG';

update revenue_rounded
set soy_rev2 = round((yield2::NUMERIC * 13.08) * 2.471,0)
where crop2 = 'SB';

--2012:
update revenue_rounded
set corn_rev3 = round((yield3::NUMERIC * 6.94) * 2.471,0)
where crop3 = 'CG';

update revenue_rounded
set soy_rev3 = round((yield3::NUMERIC * 14.54) * 2.471,0)
where crop3 = 'SB';

--2013:
update revenue_rounded
set corn_rev4 = round((yield4::NUMERIC * 4.51) * 2.471,0)
where crop4 = 'CG';

update revenue_rounded
set soy_rev4 = round((yield4::NUMERIC * 13.38) * 2.471,0)
where crop4 = 'SB';
*/
-- aggregate to same yield values

DROP TABLE IF EXISTS corn_rev_aggregated1;
CREATE TABLE corn_rev_aggregated1
AS SELECT
corn_rev1,
sum(clumuacres::numeric / 2.471) AS corn_rev1_ha
FROM revenue_rounded
GROUP BY corn_rev1;

DROP TABLE IF EXISTS soy_rev_aggregated1;
CREATE TABLE soy_rev_aggregated1
AS SELECT
soy_rev1,
sum(clumuacres::numeric / 2.471) AS soy_rev1_ha
FROM revenue_rounded
GROUP BY soy_rev1;

DROP TABLE IF EXISTS corn_rev_aggregated2;
CREATE TABLE corn_rev_aggregated2
AS SELECT
corn_rev2,
sum(clumuacres::numeric / 2.471) AS corn_rev2_ha
FROM revenue_rounded
GROUP BY corn_rev2;

DROP TABLE IF EXISTS soy_rev_aggregated2;
CREATE TABLE soy_rev_aggregated2
AS SELECT
soy_rev2,
sum(clumuacres::numeric / 2.471) AS soy_rev2_ha
FROM revenue_rounded
GROUP BY soy_rev2;

DROP TABLE IF EXISTS corn_rev_aggregated3;
CREATE TABLE corn_rev_aggregated3
AS SELECT
corn_rev3,
sum(clumuacres::numeric / 2.471) AS corn_rev3_ha
FROM revenue_rounded
GROUP BY corn_rev3;

DROP TABLE IF EXISTS soy_rev_aggregated3;
CREATE TABLE soy_rev_aggregated3
AS SELECT
soy_rev3,
sum(clumuacres::numeric / 2.471) AS soy_rev3_ha
FROM revenue_rounded
GROUP BY soy_rev3;

DROP TABLE IF EXISTS corn_rev_aggregated4;
CREATE TABLE corn_rev_aggregated4
AS SELECT
corn_rev4,
sum(clumuacres::numeric / 2.471) AS corn_rev4_ha
FROM revenue_rounded
GROUP BY corn_rev4;

DROP TABLE IF EXISTS soy_rev_aggregated4;
CREATE TABLE soy_rev_aggregated4
AS SELECT
soy_rev4,
sum(clumuacres::numeric / 2.471) AS soy_rev4_ha
FROM revenue_rounded
GROUP BY soy_rev4;
