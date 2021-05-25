-- External tables and operations --

CREATE DATABASE IF NOT EXISTS competition;

USE competition;

CREATE EXTERNAL TABLE clubs (
  name STRING,
  year_of_foundation TIMESTAMP,
  budget FLOAT 
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
LOCATION '/home/data/clubs';

-- External tables - only metadata is managed by hive

-- Copy schema from another table
CREATE EXTERNAL TABLE topClubs
LIKE clubs
LOCATION '/home/data/top_clubs';
