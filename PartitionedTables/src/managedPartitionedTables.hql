-- Managed partitioned tables and operations --

CREATE DATABASE IF NOT EXISTS champions_league;

USE champions_league;

CREATE TABLE players (
  name STRING,
  club STRING,
  matches_played SMALLINT,
  times_champion TINYINT
)
PARTITIONED BY (nationality STRING, position STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',';

-- Load data into partitions
LOAD DATA LOCAL INPATH '/home/playground/PartitionedTables/data/portugal_forwards.csv'
INTO TABLE players
PARTITION (nationality = 'Portugal', position = 'Forward');

LOAD DATA LOCAL INPATH '/home/playground/PartitionedTables/data/portugal_midfield.csv'
INTO TABLE players
PARTITION (nationality = 'Portugal', position = 'MidField');

LOAD DATA LOCAL INPATH '/home/playground/PartitionedTables/data/argentina_forwards.csv'
INTO TABLE players
PARTITION (nationality = 'Portugal', position = 'Forward');

-- Get details about the partitioned keys
DESCRIBE EXTENDED players;

-- Show partitions
SHOW PARTITIONS players;

-- Filter partitions on partition keys
SHOW PARTITIONS players PARTITION (nationality = 'Portugal');

-- Filter players on partitioned keys
SELECT * FROM players
WHERE nationality = 'Portugal' AND position = 'Forward';

-- It is also allowed to filter on non-partitioned keys,
-- but it will create enormous MR job
-- hence it will be helpful if we set strict mode
set hive.mapred.mode = 'strict';
-- In this case hive throws error, if filtered on non-partioned keys


