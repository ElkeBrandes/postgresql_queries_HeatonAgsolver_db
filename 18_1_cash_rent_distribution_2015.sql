-- cash rents distribution in the state, on a CLU level:

-- to reduce the number of records, first round cash rents to the nearest $, then aggregate over the same amounts

/*
DROP TABLE IF EXISTS cashrent_rounded_2015;
CREATE TABLE cashrent_rounded_2015
AS SELECT
fips,
twpid,
cluid_mukey,
clumuacres,
round((clu_adj_rent_2015*2.471),0) AS round_clu_cashrent_2015
FROM crop_budgets_per_clumu_2015_twp_yields;
*/


DROP TABLE IF EXISTS cashrent_rounded_aggregated_2015;
CREATE TABLE cashrent_rounded_aggregated_2015
AS SELECT
round_clu_cashrent_2015,
sum(clumuacres::numeric / 2.471) AS round_clu_cashrent_2015_ha
FROM cashrent_rounded_2015
GROUP BY round_clu_cashrent_2015;



