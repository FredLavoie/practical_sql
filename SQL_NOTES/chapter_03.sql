CREATE TABLE char_data_types (
	varchar_column varchar(10),
	char_column char(10),
	test_column text
);

INSERT INTO char_data_types
VALUES
	('abc', 'abc', 'abc'),
	('defghi', 'defghi', 'defghi');


-- The COPY command needs to be \copy in psql
COPY char_data_types TO '/Users/fredericlavoie/Documents/practical_sql/chapter_03/typetest.csv'
WITH (FORMAT CSV, HEADER, DELIMITER '|');

