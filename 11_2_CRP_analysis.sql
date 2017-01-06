
-- to check the sum of all highly unprofitable areas:
--select sum(clumuacres::NUMERIC/2.471) from profit_2015_250_sa;
-- = 2.5 Mha

-- from the table with all subfield areas at and below -250 $/ha, filter those out that are > 0.5 acres and sum them up per township:

drop table if exists profit_2015_250_sa_crp;
create table profit_2015_250_sa_crp
as select 
*
from profit_2015_250_sa
where clumuacres::numeric >= 0.5;

-- check the sum of all highly unprofitable areas that are larger than or equal to 0.5 acres:
-- select sum(clumuacres::NUMERIC/2.471) from profit_2015_250_sa_crp;
-- just a little less than 2.5 Mha

-- sum up those area to the township level:

DROP TABLE IF EXISTS "profit_2015_250_sa_crp_totals";
CREATE TABLE "profit_2015_250_sa_crp_totals"
AS SELECT
twpid,
sum(clumuacres::numeric)/2.471 AS "profit_2015_ha"
FROM "profit_2015_250_sa_crp"
GROUP BY twpid;

--test area:
-- select sum(profit_2015_ha) from profit_2015_250_sa_crp_totals;

-- analyze the portion of fields that are highly unprofitable: how much percent of the respective CLU?
-- create a new table with the relevant data:


DROP TABLE IF EXISTS subfield_portion_analysis;
CREATE TABLE  subfield_portion_analysis
AS SELECT 
co_name,
fips,
twpid,
cluid,
cluid_mukey,
cluacres / 2.471 AS cluha,
clumuacres::NUMERIC / 2.471 AS clumuha,
profit_2015
FROM crop_budgets_per_clumu_2015_twp_yields;

-- test area:
select sum(clumuha) from subfield_portion_analysis where profit_2015 <= -250;

-- by aggregating to CLU, calculate the % of highly unprofitable area in each CLU:

/*
DROP TABLE IF EXISTS subfield_portion_percent;
CREATE TABLE subfield_portion_percent
AS SELECT
co_name,
fips,
twpid,
cluid,
cluha,
sum(clumuha) as ha,
round(sum(clumuha::NUMERIC)/cluha::NUMERIC,2) AS clu_percent
FROM subfield_portion_analysis
WHERE profit_2015 <= -250
GROUP BY cluid, cluha, twpid, fips, co_name;


-- check area:
select sum(ha) from subfield_portion_percent
*/
-- for a distribution, aggregate the areas to the percentage:
/*
DROP TABLE IF EXISTS subfield_portion_distribution;
CREATE TABLE subfield_portion_distribution
AS SELECT
sum(ha) as ha,
clu_percent
FROM subfield_portion_percent
GROUP BY clu_percent;
*/
-- check how much area makes up less than 10% vs. more than 10%:
--select sum(ha) from subfield_portion_distribution where clu_percent >= '0.1';
--select sum(ha) from subfield_portion_distribution where clu_percent < '0.1';
--select sum(ha) from subfield_portion_distribution;

-- filter for CLUs with 10% or more of highly unprofitable land:
/*
DROP TABLE IF EXISTS subfield_portion_10_percent;
CREATE TABLE subfield_portion_10_percent
AS SELECT
* 
FROM subfield_portion_percent
WHERE clu_percent >= 0.1;
*/
-- assign the % back to the clu_mu polygons:
/*
DROP TABLE IF EXISTS subfield_portion_analysis_percent;
CREATE TABLE subfield_portion_analysis_percent
AS SELECT
t1.*,
t2.clu_percent
FROM subfield_portion_analysis as t1
INNER JOIN subfield_portion_percent as t2 on t1.cluid = t2.cluid;
*/

-- select Washington County:
/*
DROP TABLE IF EXISTS subfield_portion_analysis_percent_183;
CREATE TABLE subfield_portion_analysis_percent_183
AS SELECT * FROM subfield_portion_analysis_percent 
WHERE fips = 'IA183';
*/
-- select Buena Vista County:
/*
DROP TABLE IF EXISTS subfield_portion_analysis_percent_021;
CREATE TABLE subfield_portion_analysis_percent_021
AS SELECT * FROM subfield_portion_analysis_percent 
WHERE fips = 'IA021';
*/