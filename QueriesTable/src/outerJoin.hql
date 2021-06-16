CREATE DATABASE IF NOT EXISTS offices;

USE offices;

CREATE TABLE IF NOT EXISTS companies (
  name STRING,
  listed_in DATE,
  start_price FLOAT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',';

CREATE TABLE IF NOT EXISTS dividends (
  name STRING,
  issue_date DATE,
  dividend FLOAT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',';

LOAD DATA LOCAL INPATH '/home/playground/QueriesTable/data/companies.csv'
OVERWRITE INTO TABLE companies;

LOAD DATA LOCAL INPATH '/home/playground/QueriesTable/data/dividends.csv'
OVERWRITE INTO TABLE dividends;

-- Outer Join --
-- Left Outer
SELECT c.name, c.start_price, d.dividend
FROM companies c LEFT OUTER JOIN dividends d
ON year(c.listed_in) = year(d.issue_date) AND c.name = d.name;

-- Where clause is applied after JOIN operation
-- Also partition keys are ignored in ON clause of JOIN operation

-- Right Outer
SELECT c.name, c.start_price, d.dividend
FROM companies c RIGHT OUTER JOIN dividends d
ON year(c.listed_in) = year(d.issue_date) AND c.name = d.name;

-- Full Outer
SELECT c.name, c.start_price, d.dividend
FROM companies c FULL OUTER JOIN dividends d
ON year(c.listed_in) = year(d.issue_date) AND c.name = d.name;


-- Left Semi Join
SELECT c.name, c.start_price, c.listed_in
FROM companies c LEFT SEMI JOIN dividends d
ON year(c.listed_in) = year(d.issue_date) AND c.name = d.name;

-- Left semi join is similar to IN or EXISTS operations in SQL

-- Cross Join or Cartesian Join
set hive.strict.checks.cartesian.product = false;
SELECT c.name, c.start_price, d.dividend
FROM companies c JOIN dividends d;
