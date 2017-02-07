-- sum up total land:
SELECT sum(acres/2.471)  FROM clumu_cgsb_profit_2012_2015 WHERE year = 2012;
-- result: 9414047

-- correct for areas without profit result:
SELECT sum(acres/2.471)  FROM clumu_cgsb_profit_2012_2015 WHERE year = 2012 AND profit_csr2 IS NOT NULL;
-- result: 9413900

-- sum up all land below -250 US$/ha in 2012:
SELECT sum(acres/2.471)  FROM clumu_cgsb_profit_2012_2015 WHERE year = 2012 AND profit_csr2 < (-250/2.471);
-- result: 395382

-- sum up all land below -250 US$/ha in 2013:
SELECT sum(acres/2.471)  FROM clumu_cgsb_profit_2012_2015 WHERE year = 2013 AND profit_csr2 < (-250/2.471);
-- result: 1969735

-- sum up all land below -250 US$/ha in 2014:
SELECT sum(acres/2.471)  FROM clumu_cgsb_profit_2012_2015 WHERE year = 2014 AND profit_csr2 < (-250/2.471);
-- result: 2819191

-- sum up all land below -250 US$/ha in 2015:
SELECT sum(acres/2.471)  FROM clumu_cgsb_profit_2012_2015 WHERE year = 2015 AND profit_csr2 < (-250/2.471);
-- result: 2181488