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

-- We can modify serde and filestorage options
ALTER TABLE clubs
SET FILEFORMAT SEQUENCEFILE;

ALTER TABLE clubs
SET SERDE 'com.example.JSONSerDe'
WITH SERDEPROPERTIES (
  'prop1' = 'val1'
  'prop2' = 'val2'
);
