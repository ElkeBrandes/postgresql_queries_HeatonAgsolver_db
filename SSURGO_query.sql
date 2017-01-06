SELECT
l.areasymbol, -- from legend
m.mukey, m.iacornsr, -- from mapunit
c.cokey, c.compname, c.comppct_r, c.majcompflag, -- from component
ch.chkey, ch.hzdept_r, ch.hzdepb_r, ch.sandtotal_r, ch.ph1to1h2o_r, ch.ph01mcacl2_r  -- from chorizon
FROM chorizon AS ch
LEFT JOIN component AS c ON ch.cokey = c.cokey
LEFT JOIN mapunit AS m ON c.mukey = m.mukey
LEFT JOIN legend AS l ON m.lkey = l.lkey
WHERE l.areasymbol LIKE 'IA%' AND l.areatypename = 'Non-MLRA Soil Survey Area' -- always true for SSURGO
