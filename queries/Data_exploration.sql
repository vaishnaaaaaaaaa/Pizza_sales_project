/*PROJECT ON PIZZA SALES*/
/*----Data Exploration----*/
use pizza_sales;
/*Task 1: Retrieve the total number of orders placed.*/
select count(distinct order_id) as total_orders
from order_details;

/*Task 2: Calculate the total revenue generated from pizza sales.*/
select round(sum(o.quantity*p.price), 2) as total_revenue
from order_details o 
left join pizzas p on o.pizza_id = p.pizza_id;

/*Task 3: Identify the highest-priced pizza.*/
select pt.name, p.price
from pizzas as p
left join pizza_types as pt on pt.pizza_type_id = p.pizza_type_id
order by price desc
limit 1;

/*Task 4: Identify the most common pizza size ordered.*/
select p.size, count(p.size) as size_count
from order_details o 
left join pizzas p on o.pizza_id = p.pizza_id
group by p.size
order by size_count desc 
limit 1;
