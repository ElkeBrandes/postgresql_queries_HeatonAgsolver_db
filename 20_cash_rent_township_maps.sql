-- calculate area weighted cash rent averages for each township for 2010 - 2013 and 2015
/*
DROP TABLE IF EXISTS cashrents_twp_ap;
CREATE TABLE cashrents_twp_ap
AS SELECT
twpid,
sum(clumuacres::numeric)/2.471 as total_ha,
(sum(adj_rent_2010::NUMERIC * clumuacres::NUMERIC)/NULLIF (sum(clumuacres::NUMERIC),0))*2.471 AS twp_cashrent_2010,
(sum(adj_rent_2011::NUMERIC * clumuacres::NUMERIC)/NULLIF (sum(clumuacres::NUMERIC),0))*2.471 AS twp_cashrent_2011,
(sum(adj_rent_2012::NUMERIC * clumuacres::NUMERIC)/NULLIF (sum(clumuacres::NUMERIC),0))*2.471 AS twp_cashrent_2012,
(sum(adj_rent_2013::NUMERIC * clumuacres::NUMERIC)/NULLIF (sum(clumuacres::NUMERIC),0))*2.471 AS twp_cashrent_2013
FROM crop_budgets_per_clumu_clu_rents_2010_2013
GROUP BY twpid
ORDER BY twpid;

UPDATE cashrents_twp_ap
SET twp_cashrent_2010 = 99999 WHERE total_ha < 700;
UPDATE cashrents_twp_ap
SET twp_cashrent_2011 = 99999 WHERE total_ha < 700;
UPDATE cashrents_twp_ap
SET twp_cashrent_2012 = 99999 WHERE total_ha < 700;
UPDATE cashrents_twp_ap
SET twp_cashrent_2013 = 99999 WHERE total_ha < 700;
*/

-- calculate area weighted cash rent averages for the year 2014:


DROP TABLE IF EXISTS cashrents_twp_2015;
CREATE TABLE cashrents_twp_2015
AS SELECT
twpid,
sum(clumuacres::numeric)/2.471 as total_ha,
(sum(adj_rent_2015::NUMERIC * clumuacres::NUMERIC)/NULLIF (sum(clumuacres::NUMERIC),0))*2.471 AS twp_cashrent_2015
FROM crop_budgets_per_clumu_2015_twp_yields
GROUP BY twpid
ORDER BY twpid;

UPDATE cashrents_twp_2015
SET twp_cashrent_2015 = 0 WHERE total_ha < 700;
