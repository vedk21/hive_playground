-- Create and alter database commands and other options --

CREATE DATABASE humanResources;

-- Suppress warnings if db already exists
CREATE DATABASE IF NOT EXISTS humanResources;

-- Alternatively we can use keyword SCHEMA instead of DATABASE
CREATE SCHEMA IF NOT EXISTS developers; 

-- List db or schemas
SHOW DATABASES;
SHOW SCHEMAS;

-- List dbs with search pattern
SHOW DATABASES LIKE 'h.*'; 

-- Override the default db location
CREATE DATABASE IF NOT EXISTS financials
LOCATION '/home/hive';
-- directories be created lazily, once contents are present inside

-- We can add comment for purpose of documentation
CREATE DATABASE IF NOT EXISTS testers
COMMENT 'Details regarding testers';

-- We can also add DBPROPERTIES for purpose of documentation
CREATE DATABASE IF NOT EXISTS devops
WITH DBPROPERTIES('date' = '2021-05-24', 'creater' = 'vedant kakade');

DESCRIBE DATABASE EXTENDED devops;

-- Drop db
DROP DATABASE devops;
DROP DATABASE IF EXISTS devops;
-- If db has tables then it will not drop the db,
-- first drop the tables or else add CASCADE flag and
-- it will automatically drop tables first and then db
DROP DATABASE IF EXISTS devops CASCADE;
-- by default RESTRICT flag is used
-- which gives error if tables are present in db being drop

-- Alter DBPROPERTIES, no other metadata can b changed
ALTER DATABASE devops SET DBPROPERTIES('edited_by' = 'vedant kakade');
-- We can not drop DBPROPERTIES
