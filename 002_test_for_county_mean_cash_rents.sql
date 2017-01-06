DROP TABLE IF EXISTS cash_rent_county_means;
CREATE TABLE cash_rent_county_means
AS SELECT 
fips,
sum(adj_rent_2010::numeric * muacres::numeric)/sum(muacres::numeric) as county_mean_rent_2010,
sum(adj_rent_2011::numeric * muacres::numeric)/sum(muacres::numeric) as county_mean_rent_2011,
sum(adj_rent_2012::numeric * muacres::numeric)/sum(muacres::numeric) as county_mean_rent_2012,
sum(adj_rent_2013::numeric * muacres::numeric)/sum(muacres::numeric) as county_mean_rent_2013,
sum(adj_rent_2014::numeric * muacres::numeric)/sum(muacres::numeric) as county_mean_rent_2014,
sum(adj_rent_2015::numeric * muacres::numeric)/sum(muacres::numeric) as county_mean_rent_2015
FROM adj_cash_rents_ia_mu_cgsb_2010_2015
GROUP BY fips;