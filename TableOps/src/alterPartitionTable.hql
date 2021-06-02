-- Alter table operations --

CREATE DATABASE IF NOT EXISTS premier_league;

USE premier_league;

CREATE TABLE IF NOT EXISTS clubs (
  name STRING,
  founded_in STRING
)
PARTITIONED BY (city STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',';

-- Rename the table
ALTER TABLE clubs RENAME TO official_clubs;
SHOW TABLES;

-- Alter partition related props
ALTER TABLE official_clubs ADD IF NOT EXISTS
PARTITION (city = 'Manchester') LOCATION '/home/playground/AlterTable/data/manchester_clubs.csv'
PARTITION (city = 'London') LOCATION '/home/playground/AlterTable/data/london_clubs.csv';

-- Show partitions
SHOW PARTITIONS official_clubs;

-- Change partition location
ALTER TABLE official_clubs PARTITION (city = 'Manchester')
SET LOCATION '/home/playground/AlterTable/data/duplicate/manchester_clubs.csv';

SELECT * FROM official_clubs;

-- Drop partitions
ALTER TABLE official_clubs DROP IF EXISTS PARTITION (city = 'Manchester');

