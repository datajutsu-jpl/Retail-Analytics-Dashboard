--Top performing products by quarter ,products ,category
--CREATE VIEW top_products_by_quarter AS
SELECT top 10
	b.product_name, 
	b.category,
	c.year,
	c.quarter,
	COUNT(a.sale_id) as Total_transactions,
	COUNT(a.quantity) as quantity_sold, 
	SUM(a.total_amount) as total_price,
	ROUND(AVG(a.unit_price),2) as avg_price
FROM fact_sales a
LEFT JOIN dim_product b
on a.Product_id = b.Product_id
LEFT JOIN Dim_Calendar c
on a.date_key = c.date_key
GROUP BY	
	b.Product_name,
	b.category,
	c.year,
	c.quarter
ORDER BY 
	total_price desc,
	c.quarter asc,
	c.year
----------------------------------------------------------------------------	

--CREATE VIEW top5_products_by_quarter AS
WITH RankedProducts AS (
    SELECT
        p.product_name,
        p.category,
        cal.year,
        cal.quarter,
        SUM(f.total_amount) AS total_revenue,
        RANK() OVER (
            PARTITION BY cal.year, cal.quarter, p.category
            ORDER BY SUM(f.total_amount) DESC
        ) AS revenue_rank
    FROM Fact_Sales f
    JOIN Dim_Product p ON f.product_id = p.product_id
    JOIN Dim_Calendar cal ON f.date_key = cal.date_key
    GROUP BY 
        p.product_name,
        p.category,
        cal.year,
        cal.quarter
)
SELECT *
FROM RankedProducts
WHERE revenue_rank <= 5

---------------------------------------------------------------------------

--overall sales by rgion		
--CREATE VIEW overall_sales_by_region AS
SELECT 
	TOP 5 b.store_region,
	COUNT(a.quantity) as quantities_sold,
	SUM(a.total_amount) as  total_revenue
FROM Fact_Sales a
LEFT JOIN Dim_Store b 
ON a.store_id = b.store_id
GROUP BY 
	b.Store_region
ORDER BY 
	total_revenue DESC
		
--overall sales by region accordance wuth quaters

--CREATE VIEW sales_by_region AS

SELECT
	s.store_region,
    s.store_city,
    COUNT(f.sale_id) AS total_transactions,
    SUM(f.quantity) AS total_units_sold,
    SUM(f.total_amount) AS total_revenue,
    ROUND(AVG(f.unit_price), 2) AS avg_unit_price
FROM Fact_Sales f
JOIN Dim_Store s ON f.store_id = s.store_id
GROUP BY s.store_region, s.store_city


--------------------------------------------------------
--sales by month 

--CREATE VIEW view_sales_by_month AS
SELECT
    c.year,
    c.month,
    DATENAME(MONTH, c.fulldate) AS month_name,
    COUNT(a.sale_id) AS total_transactions,
    SUM(a.quantity) AS total_units_sold,
    SUM(a.total_amount) AS total_revenue,
    floor(AVG(a.unit_price)) AS avg_unit_price
FROM Fact_Sales a
JOIN Dim_Calendar c ON a.date_key = c.date_key
GROUP BY c.year, c.month, DATENAME(MONTH, c.fulldate)

--sales by month [category and region as filters]


SELECT
    c.year,
    c.month,
    DATENAME(MONTH, c.fulldate) AS month_name,
	b.Store_region,
    COUNT(a.sale_id) AS total_transactions,
    SUM(a.quantity) AS total_units_sold,
    SUM(a.total_amount) AS total_revenue,
    floor(AVG(a.unit_price)) AS avg_unit_price
FROM Fact_Sales a
JOIN Dim_Calendar c ON a.date_key = c.date_key
JOIN Dim_Store b on a.store_id = b.store_id
GROUP BY c.year, c.month, DATENAME(MONTH, c.fulldate), b.Store_region


SELECT
    c.year,
    c.month,
    DATENAME(MONTH, c.fulldate) AS month_name,
	b.category,
    COUNT(a.sale_id) AS total_transactions,
    SUM(a.quantity) AS total_units_sold,
    SUM(a.total_amount) AS total_revenue,
    floor(AVG(a.unit_price)) AS avg_unit_price
FROM Fact_Sales a
JOIN Dim_Calendar c ON a.date_key = c.date_key
JOIN Dim_Product b on a.Product_id = b.Product_id
GROUP BY c.year, c.month, DATENAME(MONTH, c.fulldate), b.category
