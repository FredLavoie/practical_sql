


CREATE TABLE new_york_addresses (
    longitude numeric(9,6),
    latitude numeric(9,6),
    street_number varchar(10),
    street varchar(32),
    unit varchar(7),
    postcode varchar(5),
    id integer CONSTRAINT new_york_key PRIMARY KEY
);

\COPY new_york_addresses
FROM '/Users/fredericlavoie/dev/practical_sql/city_of_new_york.csv'
WITH (FORMAT CSV, HEADER);




-- ************************************************************************************************************************
-- Indexes

-- Definition:
-- Like an index in a book, a table index helps find data in a table with a direct adress to the data
-- rather than searching through the table one row at a time

-- To benchmark a query, use the EXPLAIN command in PostgreSQL
EXPLAIN ANALYZE SELECT * FROM new_york_addresses
WHERE street = 'BROADWAY';
-- Execution Time: 36.574 ms
-- Execution Time: 4.845 ms (with index)

EXPLAIN ANALYZE SELECT * FROM new_york_addresses
WHERE street = '52 STREET';
-- Execution Time: 38.185 ms
-- Execution Time: 2.324 ms (with index)

EXPLAIN ANALYZE SELECT * FROM new_york_addresses
WHERE street = 'ZWICKY AVENUE';
-- Execution Time: 37.221 ms
-- Execution Time: 0.325 ms (with index)

-- Create an index for the street names
CREATE INDEX street_idx ON new_york_addresses (street);

-- To drop/delete an index
DROP INDEX street_idx