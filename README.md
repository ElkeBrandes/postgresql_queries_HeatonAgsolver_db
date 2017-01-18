# postgresql_queries_HeatonAgsolver_db
This repo contains the query scripts I have written and saved locally for the Heaton Lab Agsolver postgreSQL database. On 2017-01-06 I have copied all scripts over to the new db and imported the initial tables.

Scripts starting with a number belong to one of the following

###Sub-projects:

1. Profitability 1.0 (scripts of analyses published in Brandes et al 2016) - finalized
  
  00_test_for_unique_cluid_mukey
  
  001_annual_stats

  002_test_for_county_mean_cash_rents

  01_county_twpid_import

  02_crop_budget_calculation_retro

  03_clu_cashrents_retro

  04_join_county_twp

  05_profit_roi_calculation_retro

  06_1_filter_profit_250

  07_1_profit_250_twp_aggregate

  09_township_yields_2015

  09_township_yields_postgres

  10_1_sensitivity_analysis_2015_yields

  10_1_sensitivity_analysis_crop_budget_gabe

  10_sensitivity_crop_budget_2015_cashrent

  11_1_SA_crop_budget_250_filter_2015_cashrents

  12_1_SA_crop_buget_profit_250_twp_aggregate

  14_crop_budget_comparison_corn_soy

  15_profit_distributions

  16_percentage_corn

  17_1_yield_distributions_2015

  17_yield_distributions

  18_1_cash_rent_distribution_2015

  18_cash_rent_distribution

  19_1_crop_budget_distribution_2015

  19_crop_budget_distribution

  20_cash_rent_township_maps

  21_crop_budget_maps

  22_cashrent_and_crop_budget_averages_year

  23_1_yield_SA_250_cutoff

  24_1_price_SA_250_cutoff

  25_management_change_analysis

  26_1_revenue_distribution_2015

  26_revenue_distribution

  28_zoom_counties


2. Profitability 1.0 (unpublished analyses) - finalized

  02_crop_budget_calculation_retro_incl_preharvest

  --04_assign_cashrents_small_CLU (not used)

  04_extract_data_single_counties

  06_filter_profit_500

  07_profit_500_twp_aggregate

  08_profit_500_county_aggregate

  10_1_sensitivity_analysis_2015_yields_incl_perharvest

  10_2_calculate_zero_profit_cash_rent_2015

  10_3_break_even_yield

  11_SA_crop_budget_profit_500_filter_2015_cashrents

  11_SA_crop_budget_profit_500_filter_zero_profit_cashrents

  12_SA_crop_budget_profit_500_twp_aggregate

  13_filter_break_even_yields

  23_yield_sensitivity_analysis

  24_price_sensitivity_analysis

  27_break_even_yields


3. Profitability analysis updated (including preharvest costs, 2014, 2015 data)

  01_1_cash_rents_2012_2015

  01_average_profitability_2011_2014

  01_average_profitability_2012_2015

  09_county_mean_yields_cashrents_2012_2015

  10_yield_distributions_2011_2014

  11_yield_distributions_2011_2014_per_county


4. Switchgrass economics (net benefits of converting low profit corn/soybean to switchgrass) - ongoing

  02_1_subset_all_years_unprofitable

  02_data_prep_for_partial_budget

  08_mean_corn_yields

  09_extract_annual_yields_2011_2014

  09_extract_annual_yields_2012_2015

  10_clu_land_values

  12_swg_areas_per_county


5. Switchgrass nutrient loss (N leaching changes when targeted areas are converted to switchgrass) - ongoing

  05_1_cgsb_swg_N_loss_change

  05_2_low_leaching_soil_properties

  05_cgsb_swg_N_leaching_change

  06_distributions_N_loss

  07_1_county_n_loss

  07_county_leaching

  08_disproportionate_benefits_analysis


6. Prairie integration (loss mitigation by integrating CRP into low profit areas) - on hold

  11_2_CRP_analysis

  49_prairie_scenarios

  50_crp_inclusion_ispaid

  51_crp_inclusion_profits

  52_Landuse_classes


7. Economic STRIPS integration (identifying low-profit areas suitable for prairie contour strips) - on hold

  60_strips_profit

  61_corn_soybean_profit_surface

  62_corn_soybean_profit_surface_final_tables

  63_profit_surface_distributions


###General scripts (to run tests and controls)

  calculation_mean_profits
  
  cash_rent_clu_aggregated
  
  select_min_max_profits
  
  SSURGO_query
  
  sums_unprofitable_ha
  
  test_area
  
  test_cash_rent
  
  test_soil
  
  tests_various
  
  township_extract_lizhi


