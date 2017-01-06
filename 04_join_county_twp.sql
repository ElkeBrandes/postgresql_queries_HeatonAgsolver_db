-- join the clu rent data with the county name:

DROP TABLE IF EXISTS clu_rents_twp_county;
CREATE TABLE clu_rents_twp_county
AS SELECT
t2.co_name,
t1.*
FROM clu_rents_twp AS t1 
LEFT OUTER JOIN counties_twp AS t2 ON t1.twpid::INT = t2.twpid
ORDER BY cluid;

-- the problem here is that twpid 1038 is not assigned a county, allthough we know it is in Linn county.
-- manually assign Linn county to all records for 1038:

UPDATE clu_rents_twp_county
SET co_name = 'LINN' WHERE twpid = '1038';