
-- E-Commerce Sales & Customer Analytics
-- SQL Analysis


CREATE DATABASE ecommerce_analytics;

USE ecommerce_analytics;


-- 1. Database & Table
CREATE TABLE ecommerce_sales (
    Order_ID VARCHAR(20),
    Order_Date DATE,
    Customer_ID VARCHAR(20),
    Customer_Name VARCHAR(100),
    City VARCHAR(50),
    Category VARCHAR(50),
    Product VARCHAR(100),
    Quantity INT,
    Unit_Price DECIMAL(10,2),
    Discount_Percent DECIMAL(5,2),
    Sales DECIMAL(12,2),
    Profit DECIMAL(12,2),
    Payment_Method VARCHAR(50),
    Order_Status VARCHAR(30)
);


-- 2. Data Verification
SELECT COUNT(*) AS Total_Rows
FROM ecommerce_sales;

SELECT *
FROM ecommerce_sales
LIMIT 10;

DESCRIBE ecommerce_sales;


-- 3. Overall Sales KPIs
SELECT
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    COUNT(DISTINCT Customer_ID) AS Total_Customers
FROM ecommerce_sales;


-- 4. Sales by Category
SELECT
    Category,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM ecommerce_sales
GROUP BY Category
ORDER BY Total_Sales DESC;


-- 5. Top 10 Products
SELECT
    Product,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM ecommerce_sales
GROUP BY Product
ORDER BY Total_Sales DESC
LIMIT 10;


-- 6. Top 10 Cities
SELECT
    City,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM ecommerce_sales
GROUP BY City
ORDER BY Total_Sales DESC
LIMIT 10;


-- 7. Monthly Sales
SELECT
    YEAR(Order_Date) AS Year,
    MONTH(Order_Date) AS Month,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM ecommerce_sales
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
ORDER BY Year, Month;


-- 8. Repeat Customers
SELECT
    Customer_ID,
    Customer_Name,
    COUNT(DISTINCT Order_ID) AS Total_Orders
FROM ecommerce_sales
GROUP BY Customer_ID, Customer_Name
HAVING COUNT(DISTINCT Order_ID) > 1
ORDER BY Total_Orders DESC;


-- 9. Category Profit Margin
SELECT
    Category,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Profit_Margin
FROM ecommerce_sales
GROUP BY Category
ORDER BY Profit_Margin DESC;


-- 10. Order Status Analysis
SELECT
    Order_Status,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM ecommerce_sales
GROUP BY Order_Status
ORDER BY Total_Orders DESC;