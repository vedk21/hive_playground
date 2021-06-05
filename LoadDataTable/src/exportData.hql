-- Export data from tables to directory --

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

-- Export data
INSERT OVERWRITE LOCAL DIRECTORY '/home/playground/LoadDataTable/data/output'
SELECT name, founded_in
FROM places;

-- Multiple directory export
FROM places p
INSERT OVERWRITE LOCAL DIRECTORY '/home/playground/LoadDataTable/data/output/mh'
  SELECT name, founded_in
  WHERE p.state = 'MH'
INSERT OVERWRITE LOCAL DIRECTORY '/home/playground/LoadDataTable/data/output/ka'
  SELECT name, founded_in
  WHERE p.state = 'KA';

-- Change delimeters for output format files
INSERT OVERWRITE LOCAL DIRECTORY '/home/playground/LoadDataTable/data/output/csv'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
SELECT name, founded_in
FROM places;
