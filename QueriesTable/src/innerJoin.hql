-- Hive supports only equi-joins
-- equi join only considers equals conditions

CREATE DATABASE IF NOT EXISTS professional;

USE professional;

CREATE TABLE IF NOT EXISTS companies (
  name STRING,
  listed_in DATE,
  start_price FLOAT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',';

LOAD DATA LOCAL INPATH '/home/playground/QueriesTable/data/companies.csv'
OVERWRITE INTO TABLE companies;

-- Inner Join/ Self Join
SELECT a.listed_in, a.name, a.start_price, b.name, b.start_price
FROM companies a JOIN companies b
ON a.listed_in = b.listed_in
WHERE a.name = 'Apple' AND b.name = 'IBM';

-- We can have multiple tables for join
SELECT a.listed_in, a.name, a.start_price, b.name, b.start_price, c.name, c.start_price
FROM companies a JOIN companies b
ON a.listed_in = b.listed_in
JOIN companies c
ON a.listed_in = c.listed_in
WHERE a.name = 'Apple' AND b.name = 'IBM' AND c.name = 'GM';

-- Join optimizations
-- In case of one signle key is used in join ON condition
-- then hive will only use single MR job
-- It will buffer the other tables and stream the last table
-- assuming the last table is the largest among them
-- or else we can specify the stream table to hive
SELECT /*+ STREAMTABLE(a) */ a.listed_in, a.name, a.start_price, b.name, b.start_price
FROM companies a JOIN companies b
ON a.listed_in = b.listed_in
WHERE a.name = 'Apple' AND b.name = 'IBM';
-- In above example we assume comapnies a table is the largest and will be streamed
