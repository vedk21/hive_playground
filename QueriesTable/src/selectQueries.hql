-- Select queries on table and its variations --

CREATE DATABASE IF NOT EXISTS gym;

USE gym;

CREATE TABLE IF NOT EXISTS trainers (
  name STRING,
  leavesAllowed TINYINT,
  salary FLOAT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',';

LOAD DATA LOCAL INPATH '/home/playground/QueriesTable/data/trainers.csv'
OVERWRITE INTO TABLE trainers;

-- Use of Arithmatic operators
SELECT name, salary, (salary - leavesAllowed * 0.20)
FROM trainers;

-- Math functions in select query
SELECT name, round(salary)
FROM trainers;

-- Aggregate functions
SELECT count(*), avg(salary)
FROM trainers;

-- Improve aggregation performance
SET hive.map.agg = true;
-- This setting will perform all top level aggrgation in map phase

-- Table generating functions
--SELECT explode() FROM trainers;
-- pass array or map to explode into new row entries for each

-- Limit clause
SELECT name FROM trainers LIMIT 1;

-- Aliases for column
SELECT name, round(salary) AS avgSalary
FROM trainers;

-- Nested select queries
SELECT t.name, t.finalSalary FROM (
SELECT name, salary, (salary - leavesAllowed * 0.20) AS finalSalary
FROM trainers
) t
WHERE t.finalSalary > 50000;

-- Alternate way for nested queries
FROM (
  SELECT name, salary, (salary - leavesAllowed * 0.20) AS finalSalary
  FROM trainers
) t
SELECT t.name, t.finalSalary
WHERE t.finalSalary > 50000;

-- Case When Then query
SELECT name, salary,
CASE
  WHEN salary > 50000 THEN 'High'
  WHEN salary <= 20000 THEN 'Low'
  ELSE 'Average'
END AS category
FROM trainers;

-- Auto mode for hive
SET hive.exec.mdoe.local.auto = true;
-- With this hive will try to run most of the queries in local mode
-- withour running a MR job
