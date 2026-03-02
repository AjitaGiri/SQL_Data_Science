/*
As a Data Analyst for the Walmart Photo Center team,
you are tasked with evaluating the performance of personalized photo gifts....
*/

-- For each personalized photo gift product, what is the total quantity purchased in April 2024? This result will provide a clear measure of product pefromace for our inverntory strategies.

Select f.product_id,
sum(f.quantity) as total_quantity
from fct_photo_gift_sales f
where f.purachase_date >='2024-04-01' and f.purchase_date < '2024-05-01'
group by f.product_id;

-- what is the maximum number of personalized photo gifts purchased in a single transaction during April 2024? This information will highlight peak purchasing behavior for individual transactions.

select 
f.transaction_id,
sum(f.quantity) as total_product
from fct.photo_gift_sales f
where f.puchase_date >= '2024-04-01' and f.purchase_date < '2024-05-01'
group by f.transaction_id
order by total_product desc
limit 1;

-- What is the overall average number of personalized photo gifts purchased per customer during April 2024? That is, for each customer, calculate the total number of personalized photo gifts they purchased in April 2024- then return the average of those values across all customer.
select 
avg(total_product)
from ( 
    select f.customer_id,
    sum(f.quantity) as total_product
    from fct_photo_gift_sales f
    where f.purchase_date between '2024-04-01' and '2024-04-30'
    group by f.customer_id
);