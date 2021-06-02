-- Create table operations and options available --

CREATE DATABASE IF NOT EXISTS companyDB
LOCATION '/home/hive';

CREATE TABLE IF NOT EXISTS companyDB.employee (
  name STRING,
  probationCompleted BOOLEAN,
  LeavesAllowed TINYINT,
  Salary FLOAT,
  JoiningDate TIMESTAMP
)
COMMENT 'Table stores employee basic details'
LOCATION '/home/hive/companyDB.db/employee'
TBLPROPERTIES('creator' = 'vedant kakade');
-- If not exists suppress the warnings if table exists,
-- but it will not warn about different table schema than the one we are creating

-- TBLPROPERTIES is used for documentation purpose,
-- except in case of integration external DB this can be used for db connection and other options

-- Location can be specified explicitely, but its not recommended,
-- if required use external table instead of external location

-- Copy the schema from already existing table
CREATE TABLE IF NOT EXISTS companyDB.users
LIKE companyDB.employee;

-- Show tables from non active DB
SHOW TABLES IN companyDB;

-- List tables with pattern
SHOW TABLES LIKE 'em.*';
SHOW TABLES 'em.*';
-- We can not use IN and LIKE together

-- List down EXTENDED metadata about table
DESCRIBE EXTENDED companyDB.employee;

-- Get metadata about column only
DESCRIBE companyDB.employee Salary;

-- Get formatted metadata listing
DESCRIBE FORMATTED companyDB.employee;

-- Drop table
DROP TABLE companyDB.employee;
DROP TABLE IF EXISTS companyDB.employee;
