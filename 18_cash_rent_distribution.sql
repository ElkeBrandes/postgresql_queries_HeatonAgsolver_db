-- cash rents distribution in the state, on a CLU level:

-- to reduce the number of records, first round cash rents to the nearest $, then aggregate over the same amounts

/*
DROP TABLE IF EXISTS cashrent_rounded;
CREATE TABLE cashrent_rounded
AS SELECT
fips,
twpid,
cluid_mukey,
clumuacres,
round((clu_cashrent_2010*2.471),0) AS round_clu_cashrent_2010,
round((clu_cashrent_2011*2.471),0) AS round_clu_cashrent_2011,
round((clu_cashrent_2012*2.471),0) AS round_clu_cashrent_2012,
round((clu_cashrent_2013*2.471),0) AS round_clu_cashrent_2013
FROM crop_budgets_per_clumu_clu_rents_2010_2013;
*/


DROP TABLE IF EXISTS cashrent_rounded_aggregated_2010;
CREATE TABLE cashrent_rounded_aggregated_2010
AS SELECT
round_clu_cashrent_2010,
sum(clumuacres::numeric / 2.471) AS round_clu_cashrent_2010_ha
FROM cashrent_rounded
GROUP BY round_clu_cashrent_2010;

DROP TABLE IF EXISTS cashrent_rounded_aggregated_2011;
CREATE TABLE cashrent_rounded_aggregated_2011
AS SELECT
round_clu_cashrent_2011,
sum(clumuacres::numeric / 2.471) AS round_clu_cashrent_2011_ha
FROM cashrent_rounded
GROUP BY round_clu_cashrent_2011;

DROP TABLE IF EXISTS cashrent_rounded_aggregated_2012;
CREATE TABLE cashrent_rounded_aggregated_2012
AS SELECT
round_clu_cashrent_2012,
sum(clumuacres::numeric / 2.471) AS round_clu_cashrent_2012_ha
FROM cashrent_rounded
GROUP BY round_clu_cashrent_2012;

DROP TABLE IF EXISTS cashrent_rounded_aggregated_2013;
CREATE TABLE cashrent_rounded_aggregated_2013
AS SELECT
round_clu_cashrent_2013,
sum(clumuacres::numeric / 2.471) AS round_clu_cashrent_2013_ha
FROM cashrent_rounded
GROUP BY round_clu_cashrent_2013;


