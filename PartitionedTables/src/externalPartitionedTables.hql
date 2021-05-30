-- External partititoned tables and operations --

CREATE DATABASE IF NOT EXISTS log_analysis;

USE log_analysis;

CREATE EXTERNAL TABLE logs (
  severity STRING,
  server STRING,
  process_id INT,
  message STRING
)
PARTITIONED BY (year INT, month INT, day INT)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t';

-- To add data into partitions we use ALTER TABLE command
ALTER TABLE logs ADD PARTITION (year = 2016, month = 5, day = 21)
LOCATION '/home/playground/PartitionedTables/data/2016/05/21';

-- Change the location of the partition later
ALTER TABLE logs PARTITION (year = 2016, month = 5, day = 21)
SET LOCATION '/home/playground/PartitionedTables/data/duplicate/2016/05/21';

-- See details of partition
SHOW PARTITIONS logs;
SHOW PARTITIONS logs PARTITION (year = 2016, month = 5, day = 21);

-- Extended details of external partitioned table
DESCRIBE EXTENDED logs;
-- To see location details
DESCRIBE EXTENDED logs PARTITION (year = 2016, month = 5, day = 21);
