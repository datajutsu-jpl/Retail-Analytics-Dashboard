# 📊 Retail Analytics Dashboard

## 🔧 Project Overview

This end-to-end project simulates a real-world retail sales analytics pipeline. It showcases a full BI solution using raw CSV data, SQL-based ETL, dimensional data modeling (star schema), and a Power BI dashboard to extract and visualize key business insights.

---

## 📆 Business Objectives

* Track and analyze overall sales performance against targets
* Identify top-performing products and categories
* Evaluate customer segments based on gender, age, and city
* Monitor regional sales trends and underperforming stores
* Support inventory decision-making (Dim\_Inventory added for future scope)

---

## 📊 Data Pipeline Architecture

### 🔹 1. Data Ingestion

* `retail_raw_feed.csv` loaded into staging table (`stg_raw_feed`) using `BULK INSERT`

### 🔹 2. Dimensional Modeling (Star Schema)

* **Fact\_Sales**: Core transaction data
* **Dim\_Product**: Product details
* **Dim\_Customer**: Age, gender, location
* **Dim\_Store**: Store metadata
* **Dim\_Calendar**: Time dimension (by date)
* **Dim\_Inventory**: Current stock per store-product (added for extended use cases)

### 🔹 3. ETL Workflow

* SQL scripts created for schema creation, data staging, dimensional loads, and fact population
* All transformations handled using stored procedures and `INSERT INTO ... SELECT` logic

---

## 📅 Power BI Dashboard Features

### 📊 Page 1: Executive Overview

* Total Revenue, Units Sold, AOV, and Transactions
* Trend analysis by Month and Quarter
* Slicers for Year, Region, Category

### 🔹 Page 2: Top Products

* Top 10 products by revenue
* Revenue by category (treemap)
* Revenue trends over quarters

### 🔹 Page 3: Regional Performance

* Revenue by Region and City
* Map visual for top cities
* Regional contribution trends

### 🔹 Page 4: Customer Segments

* Revenue by Age Group and Gender
* City-wise customer spend
* Segmentation matrix

### 🔹 Page 5: Inventory Alerts (for future scope)

* View to track low stock products by store & category (ready for Power BI binding)

---

## 🧰 Key Insights

*  Revenue fell short of target despite exceeding unit sales (+7.1%)
*  Q3 is the best-performing quarter; seasonal patterns observed in Q2 & Q4
* 👩 26–35 year-olds and female customers generate the highest spend
* 🏢 West region (e.g., Mumbai, Pune) leads across all quarters
* ⚠️ Lower AOV suggests high volume in lower-value SKUs; upsell opportunities exist

---

## 📊 Data-Driven Recommendations

* Focus marketing efforts on 26–35 age group and female customer segments
* Bundle low-value products to boost AOV
* Investigate underperformance in Central region stores
* Align stock and staffing strategy with seasonal sales trends (Q2/Q4)

---

## 📁 Folder Structure

```
Retail-Analytics-Dashboard/
├── data/
│   └── retail_raw_feed.csv
├── pbix/
│   └── RetailFirst.pbix
├── sql/
│   ├── schema.sql
│   ├── staging_load.sql
│   ├── dimension_views.sql
│   ├── fact_sales_etl.sql
├── images/
│   └── dashboard_screenshot.png
├── docs/
│   └── er_diagram.png
└── README.md
```

---

## 🔗 How to Use

1. Execute SQL scripts in order:

   * `schema.sql`
   * `staging_load.sql`
   * `dimension_views.sql`
   * `fact_sales_etl.sql`
2. Open `RetailFirst.pbix` and refresh
3. Interact with slicers to explore segment-level performance

---

## 🚀 Next Steps

* Future enhancement: Scheduled ETL job using SSIS or Task Scheduler
* Add Profit Margin and RFM segmentation for advanced analysis

---

> Built with passion for data and business intelligence ❤️
