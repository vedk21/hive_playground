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


