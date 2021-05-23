-- Different data types used in hive --

CREATE DATABASE IF NOT EXISTS CompanyDB;

USE CompanyDB;

CREATE TABLE IF NOT EXISTS Employees (
  name STRING,
  probationCompleted BOOLEAN,
  LeavesAllowed TINYINT,
  Salary FLOAT,
  JoiningDate TIMESTAMP,
  subordinates ARRAY<STRING>,
  Deductions MAP<STRING, FLOAT>,
  Address STRUCT<Street:STRING, City:STRING, Zip:INT>
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '|'
MAP KEYS TERMINATED BY ':'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE;

LOAD DATA LOCAL INPATH '/home/hivePlayground/DataTypes/data/employees.csv'
OVERWRITE INTO TABLE Employees;

SELECT * FROM Employees;
