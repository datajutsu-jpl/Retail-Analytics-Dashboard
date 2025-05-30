--Retail Schema Creation

IF DB_ID('FirstProject') 
IS NULL
CREATE DATABASE FirstProject

GO
USE FirstProject
GO


--Customer Dimension 

CREATE TABLE Dim_Customer(
Customer_id			INT	IDENTITY(1,1)	PRIMARY KEY,
Customer_name		VARCHAR(100),
gender				VARCHAR(10),
age_group			VARCHAR(10),
city				VARCHAR(50)
)

--PODUCT DIMENSION 

CREATE TABLE Dim_Product(
Product_id			INT IDENTITY(1,1)	PRIMARY KEY,
Product_name		VARCHAR(50),
category			VARCHAR(25),
brand				VARCHAR(25),
Unit_price			DECIMAL(10,2)
)

--STORE DIMENSION 

CREATE TABLE Dim_Store(
store_id			INT IDENTITY(1,1)	PRIMARY KEY,
Store_name 			VARCHAR(50),
Store_city			VARCHAR(50),
Store_region 		VARCHAR(10)
)

--INVENTORY DIMENSION 

CREATE TABLE Dim_Inventory (

store_id			INT NOT NULL,
product_id			INT NOT NULL,
current_stock		INT,
last_updated		DATETIME,
PRIMARY KEY (store_id, product_id),
FOREIGN KEY (store_id) REFERENCES Dim_Store(store_id),
FOREIGN KEY (product_id) REFERENCES Dim_Product(product_id)
)


--DATE DIMENSION

CREATE TABLE Dim_Calendar(

date_key			INT				PRIMARY KEY,
fulldate			DATETIME,
day					VARCHAR(10),
month				INT,
year				INT,
quarter				INT
)



--FACT SALES

CREATE TABLE Fact_Sales(

sale_id				INT NOT NULL	PRIMARY KEY,
sales_date			DATETIME,	
store_id			INT				FOREIGN KEY REFERENCES dbo.Dim_Store(store_id),
Product_id 			INT				FOREIGN	KEY	REFERENCES dbo.Dim_Product(product_id),						
Customer_id			INT				FOREIGN KEY REFERENCES dbo.Dim_Customer(customer_id), 
date_key			INT				FOREIGN KEY REFERENCES dbo.Dim_calendar(date_key),
quantity 			INT,	
Unit_price			decimal(10,2),
Total_amount 		decimal(10,2)
)


--INDEXES
CREATE INDEX IX_Customer_id ON dbo.Dim_Customer(customer_id)
CREATE INDEX IX_Store_id ON dbo.Dim_Store(store_id)
CREATE INDEX IX_Product_id ON dbo.Dim_Product(product_id)
CREATE INDEX IX_Date_key ON dbo.Dim_calendar(date_key)
