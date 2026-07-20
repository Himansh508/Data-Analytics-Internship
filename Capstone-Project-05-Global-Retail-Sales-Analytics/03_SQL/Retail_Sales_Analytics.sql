
-- ==========================================================
-- Capstone Project 05
-- Global Retail Sales Analytics
-- Complete SQL Analysis Script
-- Author: Aashu
-- ==========================================================

CREATE DATABASE IF NOT EXISTS retail_sales_db;
USE retail_sales_db;

-- Import your cleaned CSV into a table named `superstore`
-- before executing the queries below.

-- 1. Total Sales
SELECT ROUND(SUM(sales),2) AS total_sales FROM superstore;

-- 2. Total Profit
SELECT ROUND(SUM(profit),2) AS total_profit FROM superstore;

-- 3. Total Orders
SELECT COUNT(DISTINCT order_id) AS total_orders FROM superstore;

-- 4. Total Customers
SELECT COUNT(DISTINCT customer_id) AS total_customers FROM superstore;

-- 5. Average Order Value
SELECT ROUND(SUM(sales)/COUNT(DISTINCT order_id),2) AS avg_order_value FROM superstore;

-- 6. Average Discount
SELECT ROUND(AVG(discount),2) AS avg_discount FROM superstore;

-- 7. Average Shipping Cost
SELECT ROUND(AVG(shipping_cost),2) AS avg_shipping_cost FROM superstore;

-- 8. Category-wise Sales
SELECT category, ROUND(SUM(sales),2) sales FROM superstore GROUP BY category ORDER BY sales DESC;

-- 9. Category-wise Profit
SELECT category, ROUND(SUM(profit),2) profit FROM superstore GROUP BY category ORDER BY profit DESC;

-- 10. Sub-Category-wise Sales
SELECT sub_category, ROUND(SUM(sales),2) sales FROM superstore GROUP BY sub_category ORDER BY sales DESC;

-- 11. Region-wise Sales
SELECT region, ROUND(SUM(sales),2) sales FROM superstore GROUP BY region ORDER BY sales DESC;

-- 12. Country-wise Profit
SELECT country, ROUND(SUM(profit),2) profit FROM superstore GROUP BY country ORDER BY profit DESC;

-- 13. Top 10 Customers
SELECT customer_name, ROUND(SUM(sales),2) sales FROM superstore GROUP BY customer_name ORDER BY sales DESC LIMIT 10;

-- 14. Top 10 Products
SELECT product_name, ROUND(SUM(sales),2) sales FROM superstore GROUP BY product_name ORDER BY sales DESC LIMIT 10;

-- 15. Most Profitable Products
SELECT product_name, ROUND(SUM(profit),2) profit FROM superstore GROUP BY product_name ORDER BY profit DESC LIMIT 10;

-- 16. Top States by Sales
SELECT state, ROUND(SUM(sales),2) sales FROM superstore GROUP BY state ORDER BY sales DESC LIMIT 10;

-- 17. Segment-wise Sales
SELECT segment, ROUND(SUM(sales),2) sales FROM superstore GROUP BY segment;

-- 18. Ship Mode Usage
SELECT ship_mode, COUNT(*) total_orders FROM superstore GROUP BY ship_mode ORDER BY total_orders DESC;

-- 19. Year-wise Sales
SELECT year, ROUND(SUM(sales),2) sales FROM superstore GROUP BY year ORDER BY year;

-- 20. Market-wise Sales
SELECT market, ROUND(SUM(sales),2) sales FROM superstore GROUP BY market ORDER BY sales DESC;

-- 21. Monthly Sales
SELECT MONTH(order_date) month_no, ROUND(SUM(sales),2) sales FROM superstore GROUP BY MONTH(order_date) ORDER BY month_no;

-- 22. Monthly Profit
SELECT MONTH(order_date) month_no, ROUND(SUM(profit),2) profit FROM superstore GROUP BY MONTH(order_date) ORDER BY month_no;

-- 23. High Discount Orders
SELECT * FROM superstore WHERE discount>0.5;

-- 24. Loss Making Orders
SELECT * FROM superstore WHERE profit<0;

-- 25. Orders Above Average Sales
SELECT * FROM superstore WHERE sales>(SELECT AVG(sales) FROM superstore);

-- 26. Top 5 Customers per Sales (RANK)
SELECT customer_name,SUM(sales) sales,RANK() OVER(ORDER BY SUM(sales) DESC) rnk FROM superstore GROUP BY customer_name LIMIT 5;

-- 27. Top 5 Products (DENSE_RANK)
SELECT product_name,SUM(profit) profit,DENSE_RANK() OVER(ORDER BY SUM(profit) DESC) rnk FROM superstore GROUP BY product_name LIMIT 5;

-- 28. Running Sales by Year
SELECT year,SUM(sales) sales,SUM(SUM(sales)) OVER(ORDER BY year) running_sales FROM superstore GROUP BY year;

-- 29. Sales by Priority
SELECT order_priority,ROUND(SUM(sales),2) sales FROM superstore GROUP BY order_priority;

-- 30. Quantity by Category
SELECT category,SUM(quantity) qty FROM superstore GROUP BY category;

-- 31. Average Profit by Segment
SELECT segment,ROUND(AVG(profit),2) avg_profit FROM superstore GROUP BY segment;

-- 32. Sales by City
SELECT city,ROUND(SUM(sales),2) sales FROM superstore GROUP BY city ORDER BY sales DESC LIMIT 20;

-- 33. Profit Margin
SELECT ROUND((SUM(profit)/SUM(sales))*100,2) AS profit_margin_percent FROM superstore;

-- 34. Discount Impact
SELECT discount,ROUND(AVG(profit),2) avg_profit FROM superstore GROUP BY discount ORDER BY discount;

-- 35. Top Shipping Cost Orders
SELECT order_id,shipping_cost FROM superstore ORDER BY shipping_cost DESC LIMIT 10;

-- 36. Customers with Multiple Orders
SELECT customer_name,COUNT(DISTINCT order_id) orders_count FROM superstore GROUP BY customer_name HAVING orders_count>5 ORDER BY orders_count DESC;

-- 37. Create Sales View
CREATE OR REPLACE VIEW vw_region_sales AS SELECT region,SUM(sales) total_sales FROM superstore GROUP BY region;

-- 38. View Data
SELECT * FROM vw_region_sales;

-- 39. CTE Example
WITH regional AS (SELECT region,SUM(profit) p FROM superstore GROUP BY region) SELECT * FROM regional ORDER BY p DESC;

-- 40. Final KPI Summary
SELECT COUNT(DISTINCT order_id) orders, COUNT(DISTINCT customer_id) customers, ROUND(SUM(sales),2) sales, ROUND(SUM(profit),2) profit FROM superstore;
