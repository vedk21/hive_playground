-- Select queries on table and its variations --

CREATE DATABASE IF NOT EXISTS restaurant;

USE restaurant;

CREATE TABLE IF NOT EXISTS hotels (
  name STRING,
  offers TINYINT,
  revenue FLOAT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',';

LOAD DATA LOCAL INPATH '/home/playground/QueriesTable/data/restaurant.csv'
OVERWRITE INTO TABLE hotels;

-- Where clause with predicate conditions
SELECT name, revenue
FROM hotels
WHERE revenue > 10000 AND offers > 2;

-- Use of calculated column in Where condition
SELECT h.name, h.revenue, h.offers_allowed
FROM (
  SELECT name, revenue, (revenue * (offers * 0.4)) AS offers_allowed
  FROM hotels
) h
WHERE h.offers_allowed > 40000;

-- LIKE and RLIKE
SELECT name FROM hotels
WHERE name LIKE '%ea%';

SELECT name FROM hotels
WHERE name RLIKE '(?i).*(ea|ma).*'; -- with all jdk supported regex can be used
