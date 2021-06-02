-- Alter column details operations --

CREATE DATABASE IF NOT EXISTS premier_league;

USE premier_league;

CREATE TABLE IF NOT EXISTS clubs (
  name STRING,
  founded_in STRING
)
PARTITIONED BY (city STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',';

ALTER TABLE clubs
CHANGE COLUMN founded_in initiated TIMESTAMP
COMMENT 'The date on which clubs was found'
FIRST;

-- set hive.metastore.disallow.incompatible.col.type.changes=false;
-- use this if icompatible type change is necessery

-- Add new columns
ALTER TABLE clubs ADD COLUMNS (
  income FLOAT
);

-- Replace or delete columns
ALTER TABLE clubs REPLACE COLUMNS (
  name STRING,
  founded_in STRING
);

-- above command remove income and initiated column and
-- add founded_in column

-- Add table properties for documentation purpose
ALTER TABLE clubs SET TBLPROPERTIES (
  'notes' = 'This table represents details of every premier league club'
);


