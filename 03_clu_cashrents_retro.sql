
-- create a new table named clu_rents_twp that contains the weighted averages of cashrents for each CLU and associates a twpid with each CLU.
-- after AS SELECT, name the column and then the name the new column should have. 
-- finally, group by CLU.
-- GROUP BY needs to be done for each of the columns included in the table, except for those the GROUP BY function is used for.
/*
drop table if exists clu_rents_twp;
CREATE TABLE clu_rents_twp
AS SELECT 
t2.twpid
, t1.cluid
, nullif(sum(clumuacres::NUMERIC),0) AS cluacres
, sum(adj_rent_2010::NUMERIC * clumuacres::NUMERIC)/NULLIF (sum(clumuacres::NUMERIC),0) AS clu_cashrent_2010
, sum(adj_rent_2011::NUMERIC * clumuacres::NUMERIC)/NULLIF (sum(clumuacres::NUMERIC),0) AS clu_cashrent_2011
, sum(adj_rent_2012::NUMERIC * clumuacres::NUMERIC)/NULLIF (sum(clumuacres::NUMERIC),0) AS clu_cashrent_2012
, sum(adj_rent_2013::NUMERIC * clumuacres::NUMERIC)/NULLIF (sum(clumuacres::NUMERIC),0) AS clu_cashrent_2013
FROM crop_budgets_per_clumu_2010_2013 t1
inner join clu_township t2 on t1.cluid::INT = t2.cluid
GROUP BY 
t2.twpid,
t1.cluid
ORDER BY cluid;
*/

-- join twpid and clu cashrents to the table crop_budgets_per_clumu_2010_2013, by creating a new table:

drop table if exists crop_budgets_per_clumu_clu_rents_2010_2013;
CREATE TABLE crop_budgets_per_clumu_clu_rents_2010_2013
AS SELECT
t2.twpid,
t1.*,
t2.clu_cashrent_2010,
t2.clu_cashrent_2011,
t2.clu_cashrent_2012,
t2.clu_cashrent_2013
FROM crop_budgets_per_clumu_2010_2013 AS t1
inner join clu_rents_twp t2 on t1.cluid = t2.cluid
ORDER BY twpid;



--SELECT clumuacres FROM heaton_results_12_18_14_processed