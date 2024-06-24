Select *
From pizza_sales;



-- Providing KPIs: 1)Total Revenue
select round(sum(total_price),2) as Total_Revenue
from pizza_sales;

-- Providing KPIs: 2)Average order value 
select (round(sum(total_price),2))/count(distinct order_id) as average_order
from pizza_sales;

-- Providing KPIs: 3)Total pizza sold
select sum(quantity) as Total_Pizza_Sold
from pizza_sales;

-- Providing KPIs: 4)Total Order 
select count(distinct(order_id)) as Total_orders
from pizza_sales;

-- Providing KPIs: 4)Average pizza per order
select cast(cast(sum(quantity) as decimal(10,2))/ cast(count(distinct order_id) as decimal(10,2))as decimal(10,2)) as Av_Pizza_per_Order
from pizza_sales;

--Hourly trend for total pizzas sold 
select DATEPART(HOUR,order_time) as order_hour,sum(quantity) as total_pizza_sold
from pizza_sales
group by DATEPART(HOUR,order_time)
order by DATEPART(HOUR,order_time);

--Weekly trend for total orders

select DATEPART(ISO_WEEK,order_date) as week_number, YEAR(order_date) as order_year, COUNT(distinct order_id) as total_orders
from pizza_sales
group by DATEPART(ISO_WEEK,order_date), YEAR(order_date) 
order by DATEPART(ISO_WEEK,order_date), YEAR(order_date);

--Percentage of sales by Pizza Category:
select pizza_category, sum(total_price) *100 /(select SUM(total_price) from pizza_sales) as PTS
from pizza_sales
group by pizza_category;

-- Percentage of Sales by Pizza Size:
select pizza_size, round(sum(total_price) *100 /(select SUM(total_price) from pizza_sales where datepart(quarter,order_date)=1),2) as PTS
from pizza_sales
where datepart(quarter,order_date)=1
group by pizza_size;


-- Total revenue based on each pizza size
SELECT pizza_size, 
       round(MAX(total_price_sum) OVER (PARTITION BY pizza_size),2) AS total_revenue_per_PizzaSize
FROM (
    SELECT pizza_size, SUM(total_price) AS total_price_sum
    FROM pizza_sales
    GROUP BY pizza_size
) AS subquery
ORDER BY pizza_size;


-- Total revenue based on each pizza size
select pizza_size, sum(total_price) PTS
from pizza_sales
group by pizza_size
ORDER BY pizza_size;

---Top 5 best seller by revenue, total quantity and total orders
Select top 5 pizza_name, sum(total_price) as Total_Revenue_per_PizzaNamre
From pizza_sales
Group by pizza_name
Order by sum(total_price) desc;


---Top 5 worst seller by revenue, total quantity and total orders
Select top 5 pizza_name, sum(total_price) as Total_Revenue_per_PizzaNamre
From pizza_sales
Group by pizza_name
Order by sum(total_price) ASC;
