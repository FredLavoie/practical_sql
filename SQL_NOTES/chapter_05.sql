
-- The results are truncated to an integer value
SELECT 11/ 6; -- 1

SELECT 11.0/ 6; -- 1.833333

-- To force decimal devision, you can CAST one of the
-- integers to numeric type
SELECT CAST (11 AS numeric(3,1)) / 6; -- 1.833333



SELECT 3 ^ 3 - 1; -- 26

SELECT 3 ^ (3 - 1); -- 9




-- query for the US Counties

SELECT geo_name, state_us_abbreviation, area_land
    FROM us_counties_2010
    ORDER BY area_land DESC
    LIMIT 3;


-- The results should have a difference of 0 for all rows
-- indicating that the data is clean
SELECT geo_name,
    state_us_abbreviation AS "st",
    p0010001 AS "Total",
    p0010003 + p0010004 + p0010005 + p0010006 + p0010007
        + p0010008 + p0010009 AS "All Races",
    ( p0010003 + p0010004 + p0010005 + p0010006 + p0010007
        + p0010008 + p0010009 ) - p0010001 AS "Difference"
    FROM us_counties_2010
    ORDER BY "Difference" DESC;



-- Percentage of population that is Asian by county
SELECT geo_name,
    state_us_abbreviation AS "st",
    (CAST(p0010006 AS numeric(8,1)) / p0010001) * 100 AS "pct_asian"
    FROM us_counties_2010
    ORDER BY "pct_asian" DESC;


-- NEW TABLE
CREATE TABLE percent_change (
    department varchar(20),
    spend_2014 numeric(10,2),
    spend_2017 numeric(10,2)
);

INSERT INTO percent_change
VALUES
    ('Building', 250000, 289000),
    ('Assesor', 178556, 179500),
    ('LIbrary', 87777, 90001),
    ('Clerk', 451980, 650000),
    ('Police', 250000, 223000),
    ('Recreation', 199000, 195000);
    
SELECT department,
    spend_2014,
    spend_2017,
    round((spend_2017 - spend_2014) / spend_2014 * 100, 1) AS "pct_change"
FROM percent_change;


-- Aggregate Functions for Averages and Sums
SELECT sum(p0010001) AS "County Sum",
    round(avg(p0010001), 0) AS "County Average"
FROM us_counties_2010;