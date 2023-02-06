

-- List 12-4
SELECT census.state_us_abbreviation AS st,
       census.st_population,
       plants.plant_count,
       round((plants.plant_count/census.st_population::numeric(10,1)) * 1000000, 1)
           AS plants_per_million
FROM
    (
         SELECT st,
                count(*) AS plant_count
         FROM meat_poultry_egg_inspect
         GROUP BY st
    )
    AS plants
JOIN
    (
        SELECT state_us_abbreviation,
               sum(p0010001) AS st_population
        FROM us_counties_2010
        GROUP BY state_us_abbreviation
    )
    AS census
ON plants.st = census.state_us_abbreviation
ORDER BY plants_per_million DESC;




-- ************************************************************************************************************************
-- Common Table Expressions (CTE)

-- Definition:
-- Create temporary tables for querying.
-- Relatively new addition to the SQL standard.
-- informally called a "WITH clause"

WITH
--  Temp Table Name (column names)
    large_counties (geo_name, st, p0010001)
AS
    (
        -- column names map to temp table column names
        SELECT geo_name, state_us_abbreviation, p0010001
        FROM us_counties_2010
        WHERE p0010001 >= 100000
    )
SELECT st, count(*)
FROM large_counties
GROUP BY st
ORDER BY count(*) DESC;

-- The above query is the same as the following query
SELECT state_us_abbreviation AS st, count(*)
FROM us_counties_2010
WHERE p0010001 >= 100000
GROUP BY st
ORDER BY count(*) DESC;

-- Listing 12-8
-- A query using CTE which is an alternative method of writting the List 12-4
WITH
    counties (st, population) AS
    (SELECT state_us_abbreviation, sum(population_count_100_percent)
     FROM us_counties_2010
     GROUP BY state_us_abbreviation),

    plants (st, plants) AS
    (SELECT st, count(*) AS plants
     FROM meat_poultry_egg_inspect
     GROUP BY st)

SELECT counties.st,
       population,
       plants,
       round((plants/population::numeric(10,1))*1000000, 1) AS per_million
FROM counties JOIN plants
ON counties.st = plants.st
ORDER BY per_million DESC;
