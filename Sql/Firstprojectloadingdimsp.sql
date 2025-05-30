
USE FirstProject;
GO

CREATE OR ALTER PROCEDURE sp_load_all_dimensions
AS
BEGIN
    BEGIN TRY
       
		-- Load Dim_Store
        ----------------------
        INSERT INTO Dim_Store (store_name, store_city, store_region)
        SELECT DISTINCT store_name, store_city, store_region
        FROM stg_raw_feed
        WHERE store_name IS NOT NULL 
          AND store_city IS NOT NULL 
          AND store_region IS NOT NULL;

       
        -- Load Dim_Product
        ----------------------
        INSERT INTO Dim_Product (product_name, category, brand, unit_price)
        SELECT DISTINCT product_name, category, brand, unit_price
        FROM stg_raw_feed
        WHERE product_name IS NOT NULL
          AND category IS NOT NULL
          AND brand IS NOT NULL
          AND unit_price IS NOT NULL;

        
        -- Load Dim_Customer
        ----------------------
        INSERT INTO Dim_Customer (customer_name, gender, age_group, city)
        SELECT DISTINCT customer_name, gender, age_group, city
        FROM stg_raw_feed
        WHERE customer_name IS NOT NULL
          AND gender IS NOT NULL
          AND age_group IS NOT NULL
          AND city IS NOT NULL;


        -- Load Dim_Calendar
        ----------------------
        INSERT INTO Dim_Calendar (date_key, fulldate, day, month, year, quarter)
        SELECT DISTINCT 
            CONVERT(INT, FORMAT(sales_date, 'yyyyMMdd')) AS date_key,
            sales_date,
            DATENAME(WEEKDAY, sales_date),
            MONTH(sales_date),
            YEAR(sales_date),
            DATEPART(QUARTER, sales_date)
        FROM stg_raw_feed
        WHERE sales_date IS NOT NULL;

        
        -- Load Dim_Inventory 
        ----------------------
        INSERT INTO Dim_Inventory (store_id, product_id, current_stock, last_updated)
        SELECT 
            s.store_id,
            p.product_id,
            100 AS current_stock,  -- Simulated stock level
            MAX(r.sales_date)
        FROM stg_raw_feed r
        JOIN Dim_Store s 
            ON r.store_name = s.store_name 
           AND r.store_city = s.store_city 
           AND r.store_region = s.store_region
        JOIN Dim_Product p 
            ON r.product_name = p.product_name 
           AND r.brand = p.brand 
           AND r.category = p.category 
           AND r.unit_price = p.unit_price
        GROUP BY s.store_id, p.product_id;

        PRINT 'All dimensions loaded successfully.';

    END TRY
    BEGIN CATCH
        PRINT 'Error loading dimensions: ' + ERROR_MESSAGE();
    END CATCH
END;

