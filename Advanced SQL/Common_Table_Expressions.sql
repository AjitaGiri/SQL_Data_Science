-- find the total sales per customer

with CTE_total_sale as(
    select
    customer_id,
    sum(sales) as total_sales
    from Sales.Orders
    group by customer_id 
)
-- Main query
select 
c.customer_id,
c.first_name,
c.last_name,
clo.last_order
from Sales.Customers c
left join CTE_total_sale cts
on c.customer_id= cts.customer_id;

-- Multiple standalone CTE
-- step 1: find the total sales per customer
-- step 2: Find the last order date for each customer

with CTE_total_sale as(
    select
    customer_id,
    sum(sales) as total_sales
    from Sales.Orders
    group by customer_id 
),
CTE_last_order as (
    select
    customer_id,
    max(order_date) as last_order
    from Sales.orders
    group by customer_order
)
-- Main query
select 
c.customer_id,
c.first_name,
c.last_name,
clo.last_order
from Sales.Customers c
left join CTE_total_sale cts
on c.customer_id= cts.customer_id
left join CTE_last_order  clo
on c.customer_id=clo.customer_id;
