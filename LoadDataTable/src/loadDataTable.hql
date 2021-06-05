-- Load data from path to directory --

CREATE DATABASE IF NOT EXISTS city_planner;

USE city_planner;

CREATE TABLE IF NOT EXISTS places (
  name STRING,
  founded_in STRING
)
PARTITIONED BY (state STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',';

LOAD DATA LOCAL INPATH '/home/playground/LoadDataTable/data/places.csv'
OVERWRITE INTO TABLE places
PARTITION (state = 'MH');

-- If LOCAL is used local filesystem path will be used, else hdfs path
-- If overwrite is not used files will be appended to warehouse db directory
-- Hive doesn't verify schema of the data from file
-- but verifies the file format such as SEQUENCEFILE or TEXTFILE etx.

-- Insert data using queries from other table
INSERT OVERWRITE TABLE new_places
PARTITION (state = 'MH')
SELECT name, founded_in FROM places p
WHERE p.state = 'MH';

-- Multiple data inserts from
FROM places p
INSERT OVERWRITE TABLE new_places
  PARTITION (state = 'MH')
  WHERE p.state = 'MH';
INSERT OVERWRITE TABLE new_places
  PARTITION (state = 'KA')
  WHERE p.state = 'KA';
INSERT OVERWRITE TABLE new_places
  PARTITION (state = 'GJ')
  WHERE p.state = 'GJ';

-- Dynamic partioning
INSERT OVERWRITE TABLE new_places
PARTITION (state)
SELECT name, founded_in, p.state
FROM places p;
-- it will automatically look for different values of partions on the run

-- We can also mix the static and dyanamic partitions
INSERT OVERWRITE TABLE new_places
PARTITION (state = 'MH', district)
SELECT name, founded_in, p.state, p.district
FROM places p
WHERE p.state = 'MH';

-- By default dynamic partition is disabled
set hive.exec.dynamic.partition = true;
set hive.exec.dynamic.partition.mode = 'strict';
set hive.exec.dynamic.partition.prenode = 1001;


-- Creating tables and loading data at same time
CREATE TABLE old_places
AS SELECT name, founded_in
FROM places p
WHERE p.state = 'MH';
-- This only works with managed tables