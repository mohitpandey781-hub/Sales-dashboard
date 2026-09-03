USE SALES;
select * from `pizza_sales (1)`;

-- TOTAL REVENUE:
SELECT ROUND(SUM(total_price),2) AS TOTAL_SALES FROM `pizza_sales (1)`;

-- AVERAGE SALES:
SELECT ROUND(SUM(total_price)/COUNT(DISTINCT order_id),2) from `pizza_sales (1)`;

-- TOTAL QUANTITY :
SELECT SUM(quantity) as TOTAL_QUANTITY FROM `pizza_sales (1)`;

-- TOTAL PIZZAS SOLD:
SELECT COUNT(DISTINCT order_id) as TOTAL_ORDERS FROM `pizza_sales (1)`;

-- AVERAGE PIZZAS PER ORDER:
SELECT CAST(SUM(quantity) / (COUNT(DISTINCT order_id))AS DECIMAL(10,2)) 
AS AVERAGE_PIZZA_PER_ORDER 
FROM `pizza_sales (1)`;

-- DAILY TRENDS FOR TOTAL ORDERS:
SELECT DAYNAME(order_date) AS order_day, COUNT(DISTINCT order_id) AS total_orders 
FROM   `pizza_sales (1)`
GROUP BY DAYNAME(order_date)
ORDER BY FIELD(order_day,"Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday");

-- MONTHLY TRENDS FOR TOTAL ORDERS:
SELECT MONTHNAME(STR_TO_DATE(order_date,"%d-%m-%Y"))AS MONTH_NAME,
COUNT(DISTINCT order_id) as total_order
from `pizza_sales (1)`
group by month(STR_TO_DATE(order_date,"%d-%m-%Y")),
monthname(STR_TO_DATE(order_date,"%d-%m-%Y"))
order by month(STR_TO_DATE(order_date,"%d-%m-%Y")); 

--  % of Sales by Pizza Category:


SELECT pizza_category,CAST(SUM(total_price)as decimal (10,2)) as total_revenue,
cast(sum(total_price)*100/ (select sum(total_price)from `pizza_sales (1)`)as decimal(10,2)) as PCT
FROM `pizza_sales (1)`
GROUP BY pizza_category;

-- % of Sales by Pizza Size
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from `pizza_sales (1)`) AS DECIMAL(10,2)) AS PCT
from `pizza_sales (1)`
group by pizza_size;


-- Total Pizzas Sold by Pizza Category
select pizza_category ,sum(quantity) as total_quantity_sold
from `pizza_sales (1)`
group by pizza_category
order by total_quantity_sold desc;

-- Top 5 Pizzas by Revenue:
select pizza_name,sum(total_price) as total_revenue
from `pizza_sales (1)`
group by pizza_name
order by total_revenue desc 
limit 5;


--  Bottom 5 Pizzas by Revenue:
select pizza_name, ROUND(sum(total_price),2) as total_revenue
from `pizza_sales (1)`
group by pizza_name
order by total_revenue ASC 
limit 5;

-- TOP 5 PIZZA BY QUANTITY:
SELECT pizza_name , round(sum(quantity))as total_quantity
from `pizza_sales (1)`
group by pizza_name
order by total_quantity desc
limit 5;

-- or 
SELECT  pizza_name , round(sum(quantity))as total_quantity
from `pizza_sales (1)`
group by pizza_name
order by total_quantity desc
limit 5;


-- Bottom 5 by quantity:
SELECT  pizza_name , round(sum(quantity))as total_quantity
from `pizza_sales (1)`
group by pizza_name
order by total_quantity asc
limit 5;