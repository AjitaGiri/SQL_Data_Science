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


-- Nested CTEs
 with CTE_total_sale as(
    select
    customer_id,
    sum(sales) as total_sales
    from Sales.Orders
    group by customer_id 
),
--  Rank customers based on total sales per customer
CTE_Customer_Rank as(
    select 
    customer_id,
    total_sales,
    rank() over (order by total_sales DESC) as customer_rank
    from CTE_total_sale
),
-- segment customers based on their total sales (Nested CTE)
CTE_Customer_Segments as(
    select
    customer_id,
    case
    when total_sales>100 then 'High'
    when total_sales >50 then 'Medium'
    else 'Low'
    end Customersegments
    from CTE_total_sale
)
select 
c.customer_id,
c.first_name,
c.last_name,
clo.customer_rank,
cse.Customersegments
from Sales.Customers c
left join CTE_total_sale cts
on c.customer_id= cts.customer_id
left join CTE_Customer_Rank  clo
on c.customer_id=clo.customer_id;
left join CTE_Customer_Segment cse
on c.customer_id = cse.customer_id
