CREATE DATABASE IF NOT EXISTS restaurant;

USE restaurant;

CREATE TABLE IF NOT EXISTS orders (
  name STRING,
  purchase_date DATE,
  price FLOAT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',';

LOAD DATA LOCAL INPATH '/home/playground/QueriesTable/data/orders.csv'
OVERWRITE INTO TABLE orders;

SELECT year(purchase_date), sum(price)
FROM orders
WHERE purchase_date IS NOT NULL
GROUP BY year(purchase_date);

-- Having clause
SELECT year(purchase_date), sum(price)
FROM orders
WHERE purchase_date IS NOT NULL
GROUP BY year(purchase_date)
HAVING sum(price) > 250;

-- If having is not used,
-- then we need sub-query to implement above resultant query
SELECT o.year, o.avg_price
FROM (
  SELECT year(purchase_date) AS year, sum(price) AS avg_price
  FROM orders
  WHERE purchase_date IS NOT NULL
  GROUP BY year(purchase_date)
) o
WHERE o.avg_price > 250;
