USE FirstProject 
GO 

CREATE OR ALTER PROCEDURE sp_fact_sales_load
AS 
	BEGIN
		BEGIN TRY 

			INSERT INTO Fact_Sales (
			sale_id, sales_date, store_id, product_id, customer_id, date_key,
			quantity, unit_price, total_amount)
									
				SELECT
					r.sale_id,
					r.sales_date,
					s.store_id,
					p.product_id,
					c.customer_id,
					CONVERT(INT, FORMAT(r.sales_date, 'yyyyMMdd')) AS date_key,
					r.quantity,
					r.unit_price,
					r.quantity * r.unit_price AS total_amount
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
				JOIN Dim_Customer c
					ON r.customer_name = c.customer_name
				   AND r.gender = c.gender
				   AND r.age_group = c.age_group
				   AND r.city = c.city;


		   PRINT 'FACT LOADED SUCESSFULLY'
	END TRY
		BEGIN CATCH 
			PRINT 'ERROR LOADING FACT_SALES:' + ERROR_MESSAGE()
		END CATCH 

END 
