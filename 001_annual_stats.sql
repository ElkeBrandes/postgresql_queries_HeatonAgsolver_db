-- calculate area weighted means of yield in 2010-2013 (corn and soy separate)
-- calculate corn/soy ratios for 2010-2013
-- where did I generate table corn_soy_yields?

/*

DROP TABLE IF EXISTS stats;
CREATE TABLE stats
AS SELECT
sum(corn_yield1::numeric * corn1_clumuacres::numeric)/sum(corn1_clumuacres::numeric) AS corn_yield_av_2010
, SQRT( SUM(corn1_clumuacres::numeric*corn_yield1::numeric^2)/SUM(corn1_clumuacres::numeric) - (SUM(corn1_clumuacres::numeric*corn_yield1::numeric)/SUM(corn1_clumuacres::numeric))^2 ) AS corn_yield_stdev_2010
, sum(soy_yield1::numeric * soy1_clumuacres::numeric)/sum(soy1_clumuacres::numeric)  AS soy_yield_av_2010
, SQRT( SUM(soy1_clumuacres::numeric*soy_yield1::numeric^2)/SUM(soy1_clumuacres::numeric) - (SUM(soy1_clumuacres::numeric*soy_yield1::numeric)/SUM(soy1_clumuacres::numeric))^2 ) AS soy_yield_stdev_2010
, sum(corn_yield2::numeric * corn2_clumuacres::numeric)/sum(corn2_clumuacres::numeric)  AS corn_yield_av_2011
, SQRT( SUM(corn2_clumuacres::numeric*corn_yield2::numeric^2)/SUM(corn2_clumuacres::numeric) - (SUM(corn2_clumuacres::numeric*corn_yield2::numeric)/SUM(corn2_clumuacres::numeric))^2 ) AS corn_yield_stdev_2011
, sum(soy_yield2::numeric * soy2_clumuacres::numeric)/sum(soy2_clumuacres::numeric)  AS soy_yield_av_2011
, SQRT( SUM(soy2_clumuacres::numeric*soy_yield2::numeric^2)/SUM(soy2_clumuacres::numeric) - (SUM(soy2_clumuacres::numeric*soy_yield2::numeric)/SUM(soy2_clumuacres::numeric))^2 ) AS soy_yield_stdev_2011
, sum(corn_yield3::numeric * corn3_clumuacres::numeric)/sum(corn3_clumuacres::numeric)  AS corn_yield_av_2012
, SQRT( SUM(corn3_clumuacres::numeric*corn_yield3::numeric^2)/SUM(corn3_clumuacres::numeric) - (SUM(corn3_clumuacres::numeric*corn_yield3::numeric)/SUM(corn3_clumuacres::numeric))^2 ) AS corn_yield_stdev_2012
, sum(soy_yield3::numeric * soy3_clumuacres::numeric)/sum(soy3_clumuacres::numeric)  AS soy_yield_av_2012
, SQRT( SUM(soy3_clumuacres::numeric*soy_yield3::numeric^2)/SUM(soy3_clumuacres::numeric) - (SUM(soy3_clumuacres::numeric*soy_yield3::numeric)/SUM(soy3_clumuacres::numeric))^2 ) AS soy_yield_stdev_2012
, sum(corn_yield4::numeric * corn4_clumuacres::numeric)/sum(corn4_clumuacres::numeric)  AS corn_yield_av_2013
, SQRT( SUM(corn4_clumuacres::numeric*corn_yield4::numeric^2)/SUM(corn4_clumuacres::numeric) - (SUM(corn4_clumuacres::numeric*corn_yield4::numeric)/SUM(corn4_clumuacres::numeric))^2 ) AS corn_yield_stdev_2013
, sum(soy_yield4::numeric * soy4_clumuacres::numeric)/sum(soy4_clumuacres::numeric)  AS soy_yield_av_2013
, SQRT( SUM(soy4_clumuacres::numeric*soy_yield4::numeric^2)/SUM(soy4_clumuacres::numeric) - (SUM(soy4_clumuacres::numeric*soy_yield4::numeric)/SUM(soy4_clumuacres::numeric))^2 ) AS soy_yield_stdev_2013
, sum(corn1_clumuacres::numeric)/sum(soy1_clumuacres::numeric) AS corn_soy_ratio_2010
, sum(corn2_clumuacres::numeric)/sum(soy2_clumuacres::numeric) AS corn_soy_ratio_2011
, sum(corn3_clumuacres::numeric)/sum(soy3_clumuacres::numeric) AS corn_soy_ratio_2012
, sum(corn4_clumuacres::numeric)/sum(soy4_clumuacres::numeric) AS corn_soy_ratio_2013
FROM corn_soy_yields;


*/
-- why did I write the following query?

SELECT SUM(profit110_500_sa) FROM profit110_500_sa_totals

SELECT SUM(pofit1) FROM results_w_profit_roi_actual_price
SELECT SUM(pofit2) FROM results_w_profit_roi_actual_price
SELECT SUM(pofit3) FROM results_w_profit_roi_actual_price
SELECT SUM(pofit4) FROM results_w_profit_roi_actual_price