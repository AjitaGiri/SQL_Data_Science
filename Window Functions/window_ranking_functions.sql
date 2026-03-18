-- rank the orders based on their sales from highest to lowest

select
    orderid,
    productid,
    sales,
    row_number() over(order by sales desc) SalesRank_Row, -- doesn't handle ties
    rank() over(order by sales desc) SalesRank_Rank, --skips the rank when ties
    dense_rank() over(order by sales desc) SalesRank_denserank -- doesn't skip rank when ties occur
from sales.orders;

-- find the top highest sales for each product
select * 
from (
select
    orderid,
    productid,
    sales,
    row_number() over(partition by productid order by sales desc) RankByProduct
from sales.orders;
)t where RankByProduct=1

-- find the lowest 2 customers based on their total sales

select
*
from(
    select
        customerid,
        sum(sales) totalsales,
        row_number() over(order by sum(sales)) rankcustomers
    from sales.orders
    group by customerid
)t where rankcustomers <=2;

-- assign unique ids to the rows of 'oders archieve' table

select
row_number() over(order by orderid, orderdate) uniqueId,
*
from sales.ordersarchieve;

-- identify duplicates
--identify duplicate rows and return a clean result without any duplicates

select 
* 
from (
    select
    row_number() over(partition by orderid order by creationtime desc) rn,
    *
    from sales.ordersarchieve
)t where rn=1;

-- NTILE(n) : create buckets; useful for data segmentation

select
*,
case
when Buckets =1 then 'high'
when Buckets=2 then 'medium'
when Buckets=3 then 'low'
end
from (
    select
    orderid,
    sales,
    ntile(3) over (order by sales desc) Buckets
    from sales.orders
)t

-- Percentage Based Ranking
-- find the products that fall within the highest 40% of the prices.

select
*
concat(DistRank * 100, '%') DistRankPerc
from (
    select
    product,
    price,
    cume_dist() over (order by price desc) DistRank
    from sales.products
)t
where DistRank<=0.4;

