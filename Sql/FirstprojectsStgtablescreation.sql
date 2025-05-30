
USE FirstProject;
GO

-- Staging Table for Store
CREATE TABLE stg_Store (
    store_id INT,
    store_name VARCHAR(50),
    store_city VARCHAR(50),
    store_region VARCHAR(10)
)

--  Staging Table for Product
CREATE TABLE stg_Product (
    product_id INT,
    product_name VARCHAR(50),
    category VARCHAR(25),
    brand VARCHAR(25),
    unit_price DECIMAL(10,2)
)

--  Staging Table for Customer
CREATE TABLE stg_Customer (
    customer_id INT,
    customer_name VARCHAR(100),
    gender VARCHAR(10),
    age_group VARCHAR(10),
    city VARCHAR(50)
)

--  Staging Table for Calendar
CREATE TABLE stg_Calendar (
    date_key INT,
    fulldate DATE,
    day VARCHAR(10),
    month INT,
    year INT,
    quarter INT
)

--  Staging Table for Inventory
CREATE TABLE stg_Inventory (
    store_id INT,
    product_id INT,
    current_stock INT,
    last_updated DATE
)

--  Staging Table for Sales
CREATE TABLE stg_Sales (
    sale_id INT,
    sales_date DATE,
    store_id INT,
    product_id INT,
    customer_id INT,
    date_key INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    total_amount DECIMAL(10,2)
)
