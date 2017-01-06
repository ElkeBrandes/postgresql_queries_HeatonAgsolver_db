
/*
DROP TABLE IF EXISTS corn_profit_aggregated11;
CREATE TABLE corn_profit_aggregated11
AS SELECT
round(profit_cg::NUMERIC * 2.471,0) AS profit_cg,
sum(clumuacres)/2.471 AS profit_cg_11_ha
FROM clumu_cgsb_profit_2011_2014_single_crop
WHERE year = '2011'
GROUP BY profit_cg;


DROP TABLE IF EXISTS corn_profit_aggregated12;
CREATE TABLE corn_profit_aggregated12
AS SELECT
round(profit_cg::NUMERIC * 2.471,0) AS profit_cg,
sum(clumuacres)/2.471 AS profit_cg_12_ha
FROM clumu_cgsb_profit_2011_2014_single_crop
WHERE year = '2012'
GROUP BY profit_cg;

DROP TABLE IF EXISTS corn_profit_aggregated13;
CREATE TABLE corn_profit_aggregated13
AS SELECT
round(profit_cg::NUMERIC * 2.471,0) AS profit_cg,
sum(clumuacres)/2.471 AS profit_cg_13_ha
FROM clumu_cgsb_profit_2011_2014_single_crop
WHERE year = '2013'
GROUP BY profit_cg;

DROP TABLE IF EXISTS corn_profit_aggregated14;
CREATE TABLE corn_profit_aggregated14
AS SELECT
round(profit_cg::NUMERIC * 2.471,0) AS profit_cg,
sum(clumuacres)/2.471 AS profit_cg_14_ha
FROM clumu_cgsb_profit_2011_2014_single_crop
WHERE year = '2014'
GROUP BY profit_cg;

DROP TABLE IF EXISTS soy_profit_aggregated11;
CREATE TABLE soy_profit_aggregated11
AS SELECT
round(profit_sb::NUMERIC * 2.471,0) AS profit_sb,
sum(clumuacres)/2.471 AS profit_sb_11_ha
FROM clumu_cgsb_profit_2011_2014_single_crop
WHERE year = '2011'
GROUP BY profit_sb;

DROP TABLE IF EXISTS soy_profit_aggregated12;
CREATE TABLE soy_profit_aggregated12
AS SELECT
round(profit_sb::NUMERIC * 2.471,0) AS profit_sb,
sum(clumuacres)/2.471 AS profit_sb_12_ha
FROM clumu_cgsb_profit_2011_2014_single_crop
WHERE year = '2012'
GROUP BY profit_sb;

DROP TABLE IF EXISTS soy_profit_aggregated13;
CREATE TABLE soy_profit_aggregated13
AS SELECT
round(profit_sb::NUMERIC * 2.471,0) AS profit_sb,
sum(clumuacres)/2.471 AS profit_sb_13_ha
FROM clumu_cgsb_profit_2011_2014_single_crop
WHERE year = '2013'
GROUP BY profit_sb;

DROP TABLE IF EXISTS soy_profit_aggregated14;
CREATE TABLE soy_profit_aggregated14
AS SELECT
round(profit_sb::NUMERIC * 2.471,0) AS profit_sb,
sum(clumuacres)/2.471 AS profit_sb_14_ha
FROM clumu_cgsb_profit_2011_2014_single_crop
WHERE year = '2014'
GROUP BY profit_sb;
*/
-- yields:
/*
DROP TABLE IF EXISTS corn_yield_aggregated11;
CREATE TABLE corn_yield_aggregated11
AS SELECT
round((yield_cg / 39.368) * 2.471,2) AS yield_cg,
sum(clumuacres)/2.471 AS yield_cg_11_ha
FROM clumu_cgsb_profit_2011_2014_single_crop
WHERE year = '2011'
GROUP BY yield_cg;
*/
DROP TABLE IF EXISTS soy_yield_aggregated11;
CREATE TABLE soy_yield_aggregated11
AS SELECT
round((yield_sb / 36.7437) * 2.471,2) AS yield_sb,
sum(clumuacres)/2.471 AS yield_sb_11_ha
FROM clumu_cgsb_profit_2011_2014_single_crop
WHERE year = '2011'
GROUP BY yield_sb;

/*
DROP TABLE IF EXISTS corn_yield_aggregated12;
CREATE TABLE corn_yield_aggregated12
AS SELECT
round((yield_cg / 39.368) * 2.471,2) AS yield_cg,
sum(clumuacres)/2.471 AS yield_cg_12_ha
FROM clumu_cgsb_profit_2011_2014_single_crop
WHERE year = '2012'
GROUP BY yield_cg;
*/
DROP TABLE IF EXISTS soy_yield_aggregated12;
CREATE TABLE soy_yield_aggregated12
AS SELECT
round((yield_sb / 36.7437) * 2.471,2) AS yield_sb,
sum(clumuacres)/2.471 AS yield_sb_12_ha
FROM clumu_cgsb_profit_2011_2014_single_crop
WHERE year = '2012'
GROUP BY yield_sb;
/*
DROP TABLE IF EXISTS corn_yield_aggregated13;
CREATE TABLE corn_yield_aggregated13
AS SELECT
round((yield_cg / 39.368) * 2.471,2) AS yield_cg,
sum(clumuacres)/2.471 AS yield_cg_13_ha
FROM clumu_cgsb_profit_2011_2014_single_crop
WHERE year = '2013'
GROUP BY yield_cg;
*/
DROP TABLE IF EXISTS soy_yield_aggregated13;
CREATE TABLE soy_yield_aggregated13
AS SELECT
round((yield_sb / 36.7437) * 2.471,2) AS yield_sb,
sum(clumuacres)/2.471 AS yield_sb_13_ha
FROM clumu_cgsb_profit_2011_2014_single_crop
WHERE year = '2013'
GROUP BY yield_sb;
/*
DROP TABLE IF EXISTS corn_yield_aggregated14;
CREATE TABLE corn_yield_aggregated14
AS SELECT
round((yield_cg / 39.368) * 2.471,2) AS yield_cg,
sum(clumuacres)/2.471 AS yield_cg_14_ha
FROM clumu_cgsb_profit_2011_2014_single_crop
WHERE year = '2014'
GROUP BY yield_cg;
*/
DROP TABLE IF EXISTS soy_yield_aggregated14;
CREATE TABLE soy_yield_aggregated14
AS SELECT
round((yield_sb / 36.7437) * 2.471,2) AS yield_sb,
sum(clumuacres)/2.471 AS yield_sb_14_ha
FROM clumu_cgsb_profit_2011_2014_single_crop
WHERE year = '2014'
GROUP BY yield_sb;

