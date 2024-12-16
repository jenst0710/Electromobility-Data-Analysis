CREATE DATABASE electromobility_db;
USE electromobility_db;
CREATE TABLE IF NOT EXISTS EV_sales(
EV_sales_id INT NOT NULL,
EV_sales_region VARCHAR(20),
EV_sales_category VARCHAR(20),
EV_sales_mode VARCHAR(20), 
EV_sales_powertrain VARCHAR(20),
EV_sales_year YEAR,
EV_sales_number_of_vehicles INT NOT NULL,
PRIMARY KEY (EV_sales_id));
SELECT * FROM EV_sales WHERE EV_sales_category='Historical'; 

CREATE TABLE IF NOT EXISTS EV_stock(
EV_stock_id INT NOT NULL,
EV_stock_region VARCHAR(20),
EV_stock_category VARCHAR(20),
EV_stock_mode VARCHAR(20), 
EV_stock_powertrain VARCHAR(20),
EV_stock_year YEAR,
EV_stock_number_of_vehicles INT NOT NULL,
PRIMARY KEY (EV_stock_id));

SELECT * FROM EV_sales;

# Select EV Sales and EV stock for 2023 per EV mode worldwide
SELECT EV_sales_mode, SUM(EV_sales_number_of_vehicles) FROM EV_sales 
WHERE EV_sales_category='Historical' AND EV_sales_year=2023 AND EV_sales_region='World' GROUP BY EV_sales_mode;

SELECT EV_stock_mode, SUM(EV_stock_number_of_vehicles) FROM EV_stock 
WHERE EV_stock_category='Historical'AND EV_stock_year=2023 AND EV_stock_region='World' GROUP BY EV_stock_mode;

# Select EV Sales & Stock data for 2023 per EV mode worldwide
SELECT EV_sales.EV_sales_mode, SUM(EV_sales.EV_sales_number_of_vehicles) 
AS total_sales, EV_stock.total_stock FROM EV_sales 
JOIN 
(SELECT EV_stock_mode, SUM(EV_stock_number_of_vehicles) 
AS total_stock FROM EV_stock 
WHERE EV_stock_category='Historical' AND EV_stock_year=2023 AND EV_stock_region='World' GROUP BY EV_stock_mode) 
AS EV_stock 
ON EV_sales.EV_sales_mode = EV_stock.EV_stock_mode 
WHERE EV_sales.EV_sales_category='Historical' AND EV_sales.EV_sales_year=2023 AND EV_sales.EV_sales_region='World' 
GROUP BY EV_sales.EV_sales_mode, EV_stock.total_stock;


