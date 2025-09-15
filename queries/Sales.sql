/*----SALES-Crunching the Numbers----*/
/*Task 1: List the top 5 most ordered pizza types along with their quantities.*/
select pt.name, sum(quantity) as quantities
from order_details o 
inner join pizzas p on p.pizza_id = o.pizza_id
inner join pizza_types pt on pt.pizza_type_id = p.pizza_type_id
group by pt.name
order by sum(quantity) desc
limit 5;
 
/*Task 2: Determine the distribution of orders by hour of the day.*/
select *
, sum(hourly_orders) over () as total_orders
, hourly_orders *100.00/ sum(hourly_orders) over () as contri_orders
from (
select hour(time) as hr, count(distinct order_id) as hourly_orders
from orders
group by hour(time)
) as a;

/*Task 3: Determine the top 3 most ordered pizza types based on revenue.*/
select pt.name, pt.pizza_type_id, round(sum(quantity*price)) as total_revenue
from order_details o 
inner join pizzas p on p.pizza_id = o.pizza_id
inner join pizza_types pt on pt.pizza_type_id = p.pizza_type_id
group by pt.name, pt.pizza_type_id
order by total_revenue desc
limit 3;

