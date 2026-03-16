-- find the total number of orders
--additionally provide details such as order id, order date

select
orderId,
orderDate,
count(*) over() TotalOrders
from sales.orders;

-- find the total number of orders for each customers

select
customerid,
count(*) totalorders
from sales.orders
group by customerid;

-- find the total number of orders
--additionally provide details such as order id, order date

select
customerid,
orderId,
orderDate,
count(*) over(partition by customerid) ordersbycustomers
from sales.orders;

-- find the total number of customers
-- additionally provide all customer details

select
*,
count(*) over() totalcustomers
from sales.customers;

-- find the total number of score for the customers
-- additionally provide all customer details

select
*,
count(score) over () totalscores
from sales.customers;

-- check wther the table 'orders' contains any duplicate rows

select
orderid,
count(*) over (partition by orderid) CheckPrimaryKey
from sales.orders;

/*

Count use cases:
1. Overall analysis
2. Category Analysis
3. Quality Checks: 
   a. Identify NULLs, 
   b. Identify Duplicates

*/

-- SUM(): returns sum of values within a window

-- find the total sales across all orders and the total sales for each product.
-- Additionally, provide details such as order ID and order date.

select
orderId,
orderDate,
sales,
productid,
sum(sales) over() TotalSales,
sum(sales) over (partition by productid) TotalSalesByProduct 
from sales.orders;

-- Part to whole analysis
-- find the percentage contribution of each product'sales to total sales

select
sales,
sum(sales) over() totalsales,
round(cast(sales as float)/ sum(sales) over() * 100,2) PercentageContribution
from sales.orders;

-- AVG()

-- find the average sales for each product

select
productid,
avg(coalesce(sales,0)) AverageSales
from sales.orders
group by productid;

-- find the average sales across all orders
-- find the average sales for each product
-- additionally provide details such as orderId, orderDate

select
orderId,
orderDate,
sales,
avg(coalesce(sales,0)) over() AverageSales,
avg(coalesce(sales,0)) over(partition by productid) SalesByProduct
from sales.order;

/* the difference between these two codes is that when we are asked to perform some aggregations along with 
additional information, to ensure the granularity remains same we use window functions.
However, if we dont need to show additional info we could use simple aggregate functions (group by as per need).

avg() ignores null so we first handle the null using coalesce, then only compute average

*/

-- find all orders where sales are higher than the average sales across all orders

select 
*
from (
    select
    sales,
    avg(sales) over() averagesales
    from sales.orders
)t
where sales>averagesales;

--MIN() , MAX()

-- find the highest and lowest sales for each product
-- additionally provide info like orderid, orderdate

select
orderId,
orderDate,
ProductId,
Sales,
max(sales) over() highestsales,
min(sales) over() lowestsales,
max(sales) over(partition by product) HighestSalesByProduct,
min(sales) over(partition by product) LowestSalesByProduct
from sales.orders;

