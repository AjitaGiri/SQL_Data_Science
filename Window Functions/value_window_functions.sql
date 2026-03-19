-- Value window functions: lead, lag, first_value, last_value

-- Analyze the month-over-month performance by finding the percentage change in sales between the current and previous months

select
*,
currentmonthsales - previousmonthsales as MoM_Sales,
round(cast((currentmonthsales - previousmonthsales) as float)/previousmonthsales * 100,1) as MoM_Percentage
from (
    select
    month(orderdate) ordermonth,
    sum(sales) currentmonthsales,
    lag(sum(sales)) over (order by month(orderdate)) previousmonthsales
    from sales.orders
    group by month(sales)
)t

-- customer rentention analysis

-- analyze customer loyalty, rank customers based on the average days between their orders

select
customerid,
avg(daysuntilnextorder) avgdays,
rank() over ( order by avg(daysuntilnextorder)) RankAvg
from(
    select
    orderid,
    customerid,
    orderdate currentorder,
    lead(orderdate) over (partition by customerid order by orderdate) nextorder
    lead(orderdate) over (partition by customerid order by orderdate)) daysuntilnextorder
    datediff(day,orderdate,)
    from sales.orders
    order by customerid, orderdate
)t 
group by customerid;

-- find the lowest and highest sales for each product

select
orderid,
productid,
sales,
min(sales) over (partition by productid) lowestsales,
max(sales) over ( partition by productid) highestsales
from sales.orders

-- advanced approach
select
    orderid,
    productid,
    sales,
    first_value(sales) over (partition by productid order by sales) lowestsales,
    last_value(sales) over (partition by productid order by sales rows between current row and unbounded following) highestsales
from sales.orders;
