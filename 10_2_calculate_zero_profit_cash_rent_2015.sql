-- use the values in the table crop_budgets_per_clumu_2015_twp that includes 2015 yields (newly calculated)

-- aggregate to CLU, calculate area weighted average of yield and crop budget 
-- (no need to do it separately for corn and soy, since the CLUs separate the two crops already)
-- include the stepwise changes in yield and crop budget for the sensititity analysis

/*
DROP TABLE IF EXISTS rents_clu_2015;
CREATE TABLE rents_clu_2015
AS SELECT
cluid,
ccrop,
sum(yield_2015::numeric * clumuacres::numeric)/sum(clumuacres::numeric) AS clu_yield_2015,
sum(0.7 * yield_2015::numeric * clumuacres::numeric)/sum(clumuacres::numeric) AS clu_sa_yield1,
sum(0.8 * yield_2015::numeric * clumuacres::numeric)/sum(clumuacres::numeric) AS clu_sa_yield2,
sum(0.9 * yield_2015::numeric * clumuacres::numeric)/sum(clumuacres::numeric) AS clu_sa_yield3,
sum(1.1 * yield_2015::numeric * clumuacres::numeric)/sum(clumuacres::numeric) AS clu_sa_yield4,
sum(1.2 * yield_2015::numeric * clumuacres::numeric)/sum(clumuacres::numeric) AS clu_sa_yield5,
sum(1.3 * yield_2015::numeric * clumuacres::numeric)/sum(clumuacres::numeric) AS clu_sa_yield6,
sum(budget_2015 * clumuacres::numeric)/sum(clumuacres::numeric) AS clu_budget_2015,
CASE WHEN ccrop = 'CG' THEN sum(("budget_2015" - 120/2.471) * clumuacres::numeric)/sum(clumuacres::numeric) 
		ELSE sum(("budget_2015" - 80/2.471) * clumuacres::numeric)/sum(clumuacres::numeric) END AS "clu_budget1",
CASE WHEN ccrop = 'CG' THEN sum(("budget_2015" - 90/2.471) * clumuacres::numeric)/sum(clumuacres::numeric) 
		ELSE sum(("budget_2015" - 60/2.471) * clumuacres::numeric)/sum(clumuacres::numeric) END AS "clu_budget2",
CASE WHEN ccrop = 'CG' THEN sum(("budget_2015" - 60/2.471) * clumuacres::numeric)/sum(clumuacres::numeric) 
		ELSE sum(("budget_2015" - 40/2.471) * clumuacres::numeric)/sum(clumuacres::numeric) END AS "clu_budget3",
CASE WHEN ccrop = 'CG' THEN sum(("budget_2015" - 30/2.471) * clumuacres::numeric)/sum(clumuacres::numeric) 
		ELSE sum(("budget_2015" - 20/2.471) * clumuacres::numeric)/sum(clumuacres::numeric) END AS "clu_budget4",
CASE WHEN ccrop = 'CG' THEN sum(("budget_2015" + 30/2.471) * clumuacres::numeric)/sum(clumuacres::numeric) 
		ELSE sum(("budget_2015" + 20/2.471) * clumuacres::numeric)/sum(clumuacres::numeric) END AS "clu_budget5",
CASE WHEN ccrop = 'CG' THEN sum(("budget_2015" + 60/2.471) * clumuacres::numeric)/sum(clumuacres::numeric) 
		ELSE sum(("budget_2015" + 40/2.471) * clumuacres::numeric)/sum(clumuacres::numeric) END AS "clu_budget6",
CASE WHEN ccrop = 'CG' THEN sum(("budget_2015" + 90/2.471) * clumuacres::numeric)/sum(clumuacres::numeric) 
		ELSE sum(("budget_2015" + 60/2.471) * clumuacres::numeric)/sum(clumuacres::numeric) END AS "clu_budget7",
CASE WHEN ccrop = 'CG' THEN sum(("budget_2015" + 120/2.471) * clumuacres::numeric)/sum(clumuacres::numeric) 
		ELSE sum(("budget_2015" + 80/2.471) * clumuacres::numeric)/sum(clumuacres::numeric) END AS "clu_budget8"
FROM crop_budgets_per_clumu_2015_y_twp
GROUP BY cluid, ccrop
ORDER BY cluid;


-- add columns with the calculated rent per CLU 
-- for the sensitivity analyses:
-- for each step in price, yield and crop budget change, need to calculate cash rent new 
-- number of new columns: 1 for the actual 2015 rent, 6 for yield SA, 8 for crop budget SA, 6 for price SA

alter table rents_clu_2015
add column "clu_rent_2015" float4,
add column "clu_rent_sa_yield1" float4,
add column "clu_rent_sa_yield2" float4,
add column "clu_rent_sa_yield3" float4,
add column "clu_rent_sa_yield4" float4,
add column "clu_rent_sa_yield5" float4,
add column "clu_rent_sa_yield6" float4,
add column "clu_rent_sa_budget1" float4,
add column "clu_rent_sa_budget2" float4,
add column "clu_rent_sa_budget3" float4,
add column "clu_rent_sa_budget4" float4,
add column "clu_rent_sa_budget5" float4,
add column "clu_rent_sa_budget6" float4,
add column "clu_rent_sa_budget7" float4,
add column "clu_rent_sa_budget8" float4,
add column "clu_rent_sa_price1" float4,
add column "clu_rent_sa_price2" float4,
add column "clu_rent_sa_price3" float4,
add column "clu_rent_sa_price4" float4,
add column "clu_rent_sa_price5" float4,
add column "clu_rent_sa_price6" float4;

-- calculate rents for each SA scenario



UPDATE rents_clu_2015
SET 
"clu_rent_2015" = CASE WHEN ccrop = 'CG' THEN 3.5 * NULLIF(clu_yield_2015,0) - clu_budget_2015 ELSE 9 * clu_yield_2015 - clu_budget_2015 END,
"clu_rent_sa_yield1" = CASE WHEN ccrop = 'CG' THEN 3.5 * NULLIF(clu_sa_yield1,0) - clu_budget_2015 ELSE 9 * clu_sa_yield1 - clu_budget_2015 END,
"clu_rent_sa_yield2" = CASE WHEN ccrop = 'CG' THEN 3.5 * NULLIF(clu_sa_yield2,0) - clu_budget_2015 ELSE 9 * clu_sa_yield2 - clu_budget_2015 END,
"clu_rent_sa_yield3" = CASE WHEN ccrop = 'CG' THEN 3.5 * NULLIF(clu_sa_yield3,0) - clu_budget_2015 ELSE 9 * clu_sa_yield3 - clu_budget_2015 END,
"clu_rent_sa_yield4" = CASE WHEN ccrop = 'CG' THEN 3.5 * NULLIF(clu_sa_yield4,0) - clu_budget_2015 ELSE 9 * clu_sa_yield4 - clu_budget_2015 END,
"clu_rent_sa_yield5" = CASE WHEN ccrop = 'CG' THEN 3.5 * NULLIF(clu_sa_yield5,0) - clu_budget_2015 ELSE 9 * clu_sa_yield5 - clu_budget_2015 END,
"clu_rent_sa_yield6" = CASE WHEN ccrop = 'CG' THEN 3.5 * NULLIF(clu_sa_yield6,0) - clu_budget_2015 ELSE 9 * clu_sa_yield6 - clu_budget_2015 END,
"clu_rent_sa_budget1" = CASE WHEN ccrop = 'CG' THEN 3.5 * NULLIF(clu_yield_2015,0) - "clu_budget1" ELSE 9 * clu_yield_2015 - "clu_budget1" END,
"clu_rent_sa_budget2" = CASE WHEN ccrop = 'CG' THEN 3.5 * NULLIF(clu_yield_2015,0) - "clu_budget2" ELSE 9 * clu_yield_2015 - "clu_budget2" END,
"clu_rent_sa_budget3" = CASE WHEN ccrop = 'CG' THEN 3.5 * NULLIF(clu_yield_2015,0) - "clu_budget3" ELSE 9 * clu_yield_2015 - "clu_budget3" END,
"clu_rent_sa_budget4" = CASE WHEN ccrop = 'CG' THEN 3.5 * NULLIF(clu_yield_2015,0) - "clu_budget4" ELSE 9 * clu_yield_2015 - "clu_budget4" END,
"clu_rent_sa_budget5" = CASE WHEN ccrop = 'CG' THEN 3.5 * NULLIF(clu_yield_2015,0) - "clu_budget5" ELSE 9 * clu_yield_2015 - "clu_budget5" END,
"clu_rent_sa_budget6" = CASE WHEN ccrop = 'CG' THEN 3.5 * NULLIF(clu_yield_2015,0) - "clu_budget6" ELSE 9 * clu_yield_2015 - "clu_budget6" END,
"clu_rent_sa_budget7" = CASE WHEN ccrop = 'CG' THEN 3.5 * NULLIF(clu_yield_2015,0) - "clu_budget7" ELSE 9 * clu_yield_2015 - "clu_budget7" END,
"clu_rent_sa_budget8" = CASE WHEN ccrop = 'CG' THEN 3.5 * NULLIF(clu_yield_2015,0) - "clu_budget8" ELSE 9 * clu_yield_2015 - "clu_budget8" END,
"clu_rent_sa_price1" = CASE WHEN ccrop = 'CG' THEN 2.54 * NULLIF(clu_yield_2015,0) - clu_budget_2015 ELSE 8.16 * clu_yield_2015 - clu_budget_2015 END,
"clu_rent_sa_price2" = CASE WHEN ccrop = 'CG' THEN 3.56 * NULLIF(clu_yield_2015,0) - clu_budget_2015 ELSE 9.80 * clu_yield_2015 - clu_budget_2015 END,
"clu_rent_sa_price3" = CASE WHEN ccrop = 'CG' THEN 4.57 * NULLIF(clu_yield_2015,0) - clu_budget_2015 ELSE 11.43 * clu_yield_2015 - clu_budget_2015 END,
"clu_rent_sa_price4" = CASE WHEN ccrop = 'CG' THEN 5.59 * NULLIF(clu_yield_2015,0) - clu_budget_2015 ELSE 13.06 * clu_yield_2015 - clu_budget_2015 END,
"clu_rent_sa_price5" = CASE WHEN ccrop = 'CG' THEN 6.60 * NULLIF(clu_yield_2015,0) - clu_budget_2015 ELSE 14.70 * clu_yield_2015 - clu_budget_2015 END,
"clu_rent_sa_price6" = CASE WHEN ccrop = 'CG' THEN 7.62 * NULLIF(clu_yield_2015,0) - clu_budget_2015 ELSE 16.33 * clu_yield_2015 - clu_budget_2015 END;
 */

-- join the rents back into the table crop_budgets_per_clumu_2015_twp 

DROP TABLE IF EXISTS profit_per_clumu_2015_sa;
CREATE TABLE profit_per_clumu_2015_sa
AS SELECT
t1.co_name,
t1.twpid,
t1.fips,
t1.cluid,
t1.clumuacres,
t1.mukey,
t1.ccrop,
t1.yield_2015,
t1.budget_2015,
t2."clu_rent_2015",
t2."clu_rent_sa_yield1",
t2."clu_rent_sa_yield2",
t2."clu_rent_sa_yield3",
t2."clu_rent_sa_yield4",
t2."clu_rent_sa_yield5",
t2."clu_rent_sa_yield6",
t2."clu_rent_sa_budget1",
t2."clu_rent_sa_budget2",
t2."clu_rent_sa_budget3",
t2."clu_rent_sa_budget4",
t2."clu_rent_sa_budget5",
t2."clu_rent_sa_budget6",
t2."clu_rent_sa_budget7",
t2."clu_rent_sa_budget8",
t2."clu_rent_sa_price1",
t2."clu_rent_sa_price2",
t2."clu_rent_sa_price3",
t2."clu_rent_sa_price4",
t2."clu_rent_sa_price5",
t2."clu_rent_sa_price6"
FROM crop_budgets_per_clumu_2015_y_twp AS t1
INNER JOIN rents_clu_2015 AS t2 ON t1.cluid = t2.cluid;

-- calculate profit per CLU-mapunit based on the cash rents
-- at this point the conversion from $/ac to $/ha is done.

alter table profit_per_clumu_2015_sa
add column "profit_2015" float4,
add column "profit_sa_yield1" float4,
add column "profit_sa_yield2" float4,
add column "profit_sa_yield3" float4,
add column "profit_sa_yield4" float4,
add column "profit_sa_yield5" float4,
add column "profit_sa_yield6" float4,
add column "profit_sa_budget1" float4,
add column "profit_sa_budget2" float4,
add column "profit_sa_budget3" float4,
add column "profit_sa_budget4" float4,
add column "profit_sa_budget5" float4,
add column "profit_sa_budget6" float4,
add column "profit_sa_budget7" float4,
add column "profit_sa_budget8" float4,
add column "profit_sa_price1" float4,
add column "profit_sa_price2" float4,
add column "profit_sa_price3" float4,
add column "profit_sa_price4" float4,
add column "profit_sa_price5" float4,
add column "profit_sa_price6" float4;


update profit_per_clumu_2015_sa
set 
"profit_2015" = CASE WHEN ccrop = 'CG' THEN ((NULLIF(yield_2015,0) * 3.5) - ("clu_rent_2015" + "budget_2015")) * 2.471 
ELSE  ((NULLIF(yield_2015,0) * 9) - ("clu_rent_2015" + "budget_2015")) * 2.471 END, 
"profit_sa_yield1" = CASE WHEN ccrop = 'CG' THEN ((NULLIF(0.7 * yield_2015,0) * 3.5) - ("clu_rent_2015" + "budget_2015")) * 2.471 
ELSE  ((NULLIF(0.7 * yield_2015,0) * 9) - ("clu_rent_2015" + "budget_2015")) * 2.471 END, 
"profit_sa_yield2" = CASE WHEN ccrop = 'CG' THEN ((NULLIF(0.8 * yield_2015,0) * 3.5) - ("clu_rent_2015" + "budget_2015")) * 2.471 
ELSE  ((NULLIF(0.8 * yield_2015,0) * 9) - ("clu_rent_2015" + "budget_2015")) * 2.471 END, 
"profit_sa_yield3" = CASE WHEN ccrop = 'CG' THEN ((NULLIF(0.9 * yield_2015,0) * 3.5) - ("clu_rent_2015" + "budget_2015")) * 2.471 
ELSE  ((NULLIF(0.9 * yield_2015,0) * 9) - ("clu_rent_2015" + "budget_2015")) * 2.471 END, 
"profit_sa_yield4" = CASE WHEN ccrop = 'CG' THEN ((NULLIF(1.1 * yield_2015,0) * 3.5) - ("clu_rent_2015" + "budget_2015")) * 2.471 
ELSE  ((NULLIF(1.1 * yield_2015,0) * 9) - ("clu_rent_2015" + "budget_2015")) * 2.471 END, 
"profit_sa_yield5" = CASE WHEN ccrop = 'CG' THEN ((NULLIF(1.2 * yield_2015,0) * 3.5) - ("clu_rent_2015" + "budget_2015")) * 2.471 
ELSE  ((NULLIF(1.2 * yield_2015,0) * 9) - ("clu_rent_2015" + "budget_2015")) * 2.471 END, 
"profit_sa_yield6" = CASE WHEN ccrop = 'CG' THEN ((NULLIF(1.3 * yield_2015,0) * 3.5) - ("clu_rent_2015" + "budget_2015")) * 2.471 
ELSE  ((NULLIF(1.3 * yield_2015,0) * 9) - ("clu_rent_2015" + "budget_2015")) * 2.471 END, 
"profit_sa_budget1" = CASE WHEN ccrop = 'CG' THEN ((NULLIF(yield_2015,0) * 3.5) - ("clu_rent_2015" + "budget_2015"-120/2.471)) * 2.471 
ELSE  ((NULLIF(yield_2015,0) * 9) - ("clu_rent_2015" + "budget_2015" -80/2.471)) * 2.471 END, 
"profit_sa_budget2" = CASE WHEN ccrop = 'CG' THEN ((NULLIF(yield_2015,0) * 3.5) - ("clu_rent_2015" + "budget_2015"-90/2.471)) * 2.471 
ELSE  ((NULLIF(yield_2015,0) * 9) - ("clu_rent_2015" + "budget_2015" - 60/2.471)) * 2.471 END, 
"profit_sa_budget3" = CASE WHEN ccrop = 'CG' THEN ((NULLIF(yield_2015,0) * 3.5) - ("clu_rent_2015" + "budget_2015"-60/2.471)) * 2.471 
ELSE  ((NULLIF(yield_2015,0) * 9) - ("clu_rent_2015" + "budget_2015" - 40/2.471)) * 2.471 END, 
"profit_sa_budget4" = CASE WHEN ccrop = 'CG' THEN ((NULLIF(yield_2015,0) * 3.5) - ("clu_rent_2015" + "budget_2015"-30/2.471)) * 2.471 
ELSE  ((NULLIF(yield_2015,0) * 9) - ("clu_rent_2015" + "budget_2015" - 20/2.471)) * 2.471 END, 
"profit_sa_budget5" = CASE WHEN ccrop = 'CG' THEN ((NULLIF(yield_2015,0) * 3.5) - ("clu_rent_2015" + "budget_2015"+30/2.471)) * 2.471 
ELSE  ((NULLIF(yield_2015,0) * 9) - ("clu_rent_2015" + "budget_2015" + 20/2.471)) * 2.471 END, 
"profit_sa_budget6" = CASE WHEN ccrop = 'CG' THEN ((NULLIF(yield_2015,0) * 3.5) - ("clu_rent_2015" + "budget_2015"+60/2.471)) * 2.471 
ELSE  ((NULLIF(yield_2015,0) * 9) - ("clu_rent_2015" + "budget_2015" + 40/2.471)) * 2.471 END, 
"profit_sa_budget7" = CASE WHEN ccrop = 'CG' THEN ((NULLIF(yield_2015,0) * 3.5) - ("clu_rent_2015" + "budget_2015"+90/2.471)) * 2.471 
ELSE  ((NULLIF(yield_2015,0) * 9) - ("clu_rent_2015" + "budget_2015" + 60/2.471)) * 2.471 END, 
"profit_sa_budget8" = CASE WHEN ccrop = 'CG' THEN ((NULLIF(yield_2015,0) * 3.5) - ("clu_rent_2015" + "budget_2015"+120/2.471)) * 2.471 
ELSE  ((NULLIF(yield_2015,0) * 9) - ("clu_rent_2015" + "budget_2015" + 80/2.471)) * 2.471 END,
"profit_sa_price1" = CASE WHEN ccrop = 'CG' THEN ((NULLIF(yield_2015,0) * 2.54) - ("clu_rent_2015" + "budget_2015")) * 2.471 
ELSE  ((NULLIF(yield_2015,0) * 8.16) - ("clu_rent_2015" + "budget_2015")) * 2.471 END, 
"profit_sa_price2" = CASE WHEN ccrop = 'CG' THEN ((NULLIF(yield_2015,0) * 3.56) - ("clu_rent_2015" + "budget_2015")) * 2.471 
ELSE  ((NULLIF(yield_2015,0) * 9.80) - ("clu_rent_2015" + "budget_2015")) * 2.471 END, 
"profit_sa_price3" = CASE WHEN ccrop = 'CG' THEN ((NULLIF(yield_2015,0) * 4.57) - ("clu_rent_2015" + "budget_2015")) * 2.471 
ELSE  ((NULLIF(yield_2015,0) * 11.43) - ("clu_rent_2015" + "budget_2015")) * 2.471 END, 
"profit_sa_price4" = CASE WHEN ccrop = 'CG' THEN ((NULLIF(yield_2015,0) * 5.59) - ("clu_rent_2015" + "budget_2015")) * 2.471 
ELSE  ((NULLIF(yield_2015,0) * 13.06) - ("clu_rent_2015" + "budget_2015")) * 2.471 END, 
"profit_sa_price5" = CASE WHEN ccrop = 'CG' THEN ((NULLIF(yield_2015,0) * 6.60) - ("clu_rent_2015" + "budget_2015")) * 2.471 
ELSE  ((NULLIF(yield_2015,0) * 14.70) - ("clu_rent_2015" + "budget_2015")) * 2.471 END, 
"profit_sa_price6" = CASE WHEN ccrop = 'CG' THEN ((NULLIF(yield_2015,0) * 7.62) - ("clu_rent_2015" + "budget_2015")) * 2.471 
ELSE  ((NULLIF(yield_2015,0) * 16.33) - ("clu_rent_2015" + "budget_2015")) * 2.471 END;

