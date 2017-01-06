
-- count the number of rows (more reliable than navicat software)

-- SELECT count(*) FROM crop_budgets_per_clumu_2015
-- SELECT * FROM clu_rents_twp_county WHERE cluid = '6959242'

SELECT count(DISTINCT cluid_mukey) FROM "05_dndc_clumu_cgsb_swg";
SELECT count(DISTINCT mean_profit_ha) FROM clumu_cgsb_profit_2011_2014_mean;
SELECT count(*) FROM "05_low_leaching";

SELECT sum(acres) FROM clumu_cgsb_profit_2012_2015 WHERE profit_csr2 IS NULL;
SELECT sum(clumuha) FROM "02_clumu_cgsb_profit_switch2"

-- to count the clu in the whole state:  
--SELECT count(DISTINCT cluid) FROM clumu_cgsb_profit_2011_2014

/*
SELECT t.cluid_mukey
    FROM results_w_profit_cb_sa t
GROUP BY t.cluid_mukey
  HAVING COUNT(*) > 1
*/
--getting the size of the database

SELECT pg_database_size(current_database());

--getting the size of a table:


select pg_relation_size('yields_cutoffs_2012_2015');
select pg_relation_size('05_dndc_clumu_iowa_cgsb_swg_2011_2014');

/*
select
'crop_budgets_per_clumu_2015',
pg_size_pretty(pg_database_size('crop_budgets_per_clumu_2015')::BIGINT )
from information_schema.tables
where table_schema = 'public'
*/

--SELECT AVG(yield_2013::numeric) FROM crop_budgets_per_clumu_2015;
--SELECT AVG(yield4::numeric) FROM crop_budgets_per_clumu_clu_rents_2010_2013;

--ALTER TABLE crop_budgets_per_clumu_2015 ALTER COLUMN "profit-120_2015" TYPE numeric(6,2);
/*
alter table crop_budgets_per_clumu_2015
drop column "profit-120_2015",
drop column "profit-90_2015",
drop column "profit-60_2015",
drop column "profit-30_2015",
drop column "profit_2015",
drop column "profit+30_2015",
drop column "profit+60_2015",
drop column "profit+90_2015",
drop column "profit+120_2015";
*/

--SELECT sum(clumuacres::numeric/2.471) from crop_budgets_per_clumu_2015_twp_yields WHERE profit_2015 * 2.471 <= -500;
--SELECT sum(clumuacres::numeric/2.471) from crop_budgets_per_clumu_2015_twp_yields;
--SELECT sum(clumuacres::numeric/2.471) from profit_rounded_2015_c WHERE round_corn_profit_2015*2.471 <= -500;
--SELECT sum(clumuacres::numeric/2.471) from profit_rounded_2015_c WHERE round_soy_profit_2015 * 2.471 <= -500;
--SELECT sum(round_corn_profit_2015_ha) from corn_profit_rounded_aggregated_2015_c WHERE round_corn_profit_2015  <= -500;
--SELECT sum(round_soy_profit_2015_ha) from soy_profit_rounded_aggregated_2015_c WHERE round_soy_profit_2015  <= -500;
--SELECT sum(profit_2015_ha) from profit_500_sa_township_2015_cashrents_r;
--SELECT sum(profit_2015_ha) from profit_y_500_sa_township_r;
--SELECT sum("profit_sa_p_0.14_ha") from profit_p_500_sa_township;
--SELECT sum(total_ha) from profit_500_sa_township_r
/*
SELECT 
sum(profit1::numeric*clumuacres::numeric)/sum(clumuacres::numeric),
sum(profit2::numeric*clumuacres::numeric)/sum(clumuacres::numeric),
sum(profit3::numeric*clumuacres::numeric)/sum(clumuacres::numeric),
sum(profit4::numeric*clumuacres::numeric)/sum(clumuacres::numeric)
from crop_budgets_per_clumu_clu_rents_2010_2013;

SELECT 
sum(profit_2015::numeric*clumuacres::numeric)/sum(clumuacres::numeric)
from crop_budgets_per_clumu_2015_twp_yields;
*/

-- calcultate averages of revenues:

-- 2010:
/*
SELECT 
sum(corn_rev1*corn_rev1_ha)/sum(corn_rev1_ha)
FROM corn_rev_aggregated1;

SELECT
sum(soy_rev1*soy_rev1_ha)/sum(soy_rev1_ha)
FROM soy_rev_aggregated1;
*/

ALTER TABLE clumu_cgsb_profit_2012_2015
ADD COLUMN cluid_mukey TEXT;

UPDATE clumu_cgsb_profit_2012_2015
SET cluid_mukey = cluid || mukey;

SELECT count(DISTINCT cluid_mukey) FROM clumu_cgsb_profit_2011_2014;

SELECT COUNT(*) FROM clumu_cgsb_profit_2011_2014 WHERE clumuacres = 0 AND year = '2011';
SELECT SUM(acres) FROM clumu_cgsb_profit_2012_2015 WHERE yield IS NULL AND year = '2012';