/*----Operational Insights----*/
/*Task 1: Calculate the percentage contribution of each pizza type to total revenue.*/
with rev as (select pt.name, pt.pizza_type_id, round(sum(quantity*price)) as total_revenue
from order_details o 
inner join pizzas p on p.pizza_id = o.pizza_id
inner join pizza_types pt on pt.pizza_type_id = p.pizza_type_id
group by pt.name, pt.pizza_type_id)

select name, round(total_revenue/ (select sum(quantity*price) as total_revenue 
					   from pizzas p 
                       left join order_details o on p.pizza_id = o.pizza_id)*100, 2) as percentage_contribution
from rev;

/*Task 2: Analyze the cumulative revenue generated over time.*/
with final as (
select o.date, round(sum(p.price * od.quantity),2) as rev
from orders as o
left join order_details as od on od.order_id = o.order_id
left join pizzas as p on p.pizza_id = od.pizza_id
group by o.date
)

select *
, round(sum(rev) over (order by date rows between unbounded preceding and current row), 0) as cumm_total
from final;

/*Task 3: Determine the top 3 most ordered pizza types based on revenue for each pizza category.*/
select * from (
select * 
, dense_rank() over (partition by category order by rev desc) as rn
from (
select pt.category, pt.name, round(sum(od.quantity * p.price), 2) as rev
from pizza_types as pt
left join pizzas as p on p.pizza_type_id = pt.pizza_type_id
left join order_details as od on od.pizza_id = p.pizza_id
group by pt.category, pt.name
) as a
) as a1
where rn <= 3;
