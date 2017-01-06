-- yield distribution of corn and soybean in each county, on a CLU-mapunit level:

-- group by fips and yield
DROP TABLE IF EXISTS "11_corn_yield_cnty_aggr11";
CREATE TABLE "11_corn_yield_cnty_aggr11"
AS SELECT 
fips, 
sum(clumuha) as corn_yield11_ha,
round_corn_yield11
FROM "09_yields_rounded_2011_2014"
GROUP BY fips, round_corn_yield11;

DROP TABLE IF EXISTS "11_soy_yield_cnty_aggr11";
CREATE TABLE "11_soy_yield_cnty_aggr11"
AS SELECT 
fips, 
sum(clumuha) as soy_yield11_ha,
round_soy_yield11
FROM "09_yields_rounded_2011_2014"
GROUP BY fips, round_soy_yield11;

DROP TABLE IF EXISTS "11_corn_yield_cnty_aggr12";
CREATE TABLE "11_corn_yield_cnty_aggr12"
AS SELECT 
fips, 
sum(clumuha) as corn_yield12_ha,
round_corn_yield12
FROM "09_yields_rounded_2011_2014"
GROUP BY fips, round_corn_yield12;

DROP TABLE IF EXISTS "11_soy_yield_cnty_aggr12";
CREATE TABLE "11_soy_yield_cnty_aggr12"
AS SELECT 
fips, 
sum(clumuha) as soy_yield12_ha,
round_soy_yield12
FROM "09_yields_rounded_2011_2014"
GROUP BY fips, round_soy_yield12;

DROP TABLE IF EXISTS "11_corn_yield_cnty_aggr13";
CREATE TABLE "11_corn_yield_cnty_aggr13"
AS SELECT 
fips, 
sum(clumuha) as corn_yield13_ha,
round_corn_yield13
FROM "09_yields_rounded_2011_2014"
GROUP BY fips, round_corn_yield13;

DROP TABLE IF EXISTS "11_soy_yield_cnty_aggr13";
CREATE TABLE "11_soy_yield_cnty_aggr13"
AS SELECT 
fips, 
sum(clumuha) as soy_yield13_ha,
round_soy_yield13
FROM "09_yields_rounded_2011_2014"
GROUP BY fips, round_soy_yield13;

DROP TABLE IF EXISTS "11_corn_yield_cnty_aggr14";
CREATE TABLE "11_corn_yield_cnty_aggr14"
AS SELECT 
fips, 
sum(clumuha) as corn_yield14_ha,
round_corn_yield14
FROM "09_yields_rounded_2011_2014"
GROUP BY fips, round_corn_yield14;

DROP TABLE IF EXISTS "11_soy_yield_cnty_aggr14";
CREATE TABLE "11_soy_yield_cnty_aggr14"
AS SELECT 
fips, 
sum(clumuha) as soy_yield14_ha,
round_soy_yield14
FROM "09_yields_rounded_2011_2014"
GROUP BY fips, round_soy_yield14;

