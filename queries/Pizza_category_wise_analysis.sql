/*----Category-Wise Analysis----*/
/*Task 1: Join the necessary tables to find the total quantity of each pizza category
ordered.*/
select pt.category, sum(o.quantity) as quantities
from order_details o 
inner join pizzas p on p.pizza_id = o.pizza_id
inner join pizza_types pt on pt.pizza_type_id = p.pizza_type_id
group by pt.category;

/*Task 2: Join relevant tables to find the category-wise distribution of pizzas.*/
with total_quantity_per_category as (select pt.category, sum(o.quantity) as quantities
                                     from order_details o 
                                     inner join pizzas p on p.pizza_id = o.pizza_id
                                     inner join pizza_types pt on pt.pizza_type_id = p.pizza_type_id
                                     group by pt.category)
                                     								
select category, quantities, quantities*100/sum(quantities) over () as category_wise_distribution
from total_quantity_per_category;

/*Task 3: Group the orders by the date and calculate the average number of pizzas
ordered per day.*/
with new_avg_quantity as (select sum(quantity) as avg_quantity, date
from order_details o 
inner join orders ord on o.order_id = ord.order_id
group by date)

select avg(avg_quantity) as average_number_of_pizzas_ordered_per_day
from new_avg_quantity;