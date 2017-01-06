-- extract data of twpid 1074 from retrospective analysis:
/*
DROP TABLE IF EXISTS beaver_twp_2010_2013;
CREATE TABLE beaver_twp_2010_2013
AS SELECT
*
FROM crop_budgets_per_clumu_clu_rents_2010_2013
WHERE twpid = '1074';

-- extract data of twpid 1074 from 2015 analysis:

DROP TABLE IF EXISTS beaver_twp_2015;
CREATE TABLE beaver_twp_2015
AS SELECT
*
FROM crop_budgets_per_clumu_2015_twp_yields
WHERE twpid = '1074';

-- join both tables:

DROP TABLE IF EXISTS beaver_twp;
CREATE TABLE beaver_twp
AS SELECT
t2.*,
t1.pcrop AS crop_2014,
t1.ccrop  AS crop_2015,
t1.adj_rent_2015,
t1.clu_adj_rent_2015,
t1.yield_2015,
t1.budget_2015,
t1.profit_2015
FROM beaver_twp_2015 t1
INNER JOIN beaver_twp_2010_2013 t2
on t1.cluid_mukey = t2.cluid_mukey;
*/
-- join the biogeochemistry data to the table:

DROP TABLE IF EXISTS beaver_twp_all_data;
CREATE TABLE beaver_twp_all_data
AS SELECT
t1.*,
t2.slope,
t2.rotation,
t2.sci,
t2.sciom,
t2.scifo,
t2.scier,
t2.watereros,
t2.winderos,
t2.toteros,
t2.totsoiloss1,
t2.ann_soil_c_delta1,
t2.co2_flux1,
t2.n2_fix1,
t2.n2o_flux1,
t2.no_flux1,
t2.n_fert1,
t2.n_litter_in1,
t2.n_precip1,
t2.n_uptake1,
t2.nh3_vol1,
t2.no3_leach1,
t2.totsoiloss2,
t2.ann_soil_c_delta2,
t2.co2_flux2,
t2.n2_fix2,
t2.n2o_flux2,
t2.no_flux2,
t2.n_fert2,
t2.n_litter_in2,
t2.n_precip2,
t2.n_uptake2,
t2.nh3_vol2,
t2.no3_leach2,
t2.totsoiloss3,
t2.ann_soil_c_delta3,
t2.co2_flux3,
t2.n2_fix3,
t2.n2o_flux3,
t2.no_flux3,
t2.n_fert3,
t2.n_litter_in3,
t2.n_precip3,
t2.n_uptake3,
t2.nh3_vol3,
t2.no3_leach3,
t2.totsoiloss4,
t2.ann_soil_c_delta4,
t2.co2_flux4,
t2.n2_fix4,
t2.n2o_flux4,
t2.no_flux4,
t2.n_fert4,
t2.n_litter_in4,
t2.n_precip4,
t2.n_uptake4,
t2.nh3_vol4,
t2.no3_leach4
FROM beaver_twp t1
INNER JOIN heaton_results t2
on t1.cluid = t2.cluid
AND t1.mukey = t2.mukey;


