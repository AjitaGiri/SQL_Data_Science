-- You are a Product Analyst on the Uber Eats team investigating delivery partner performance. The team wants to understand how accurately delivery partners are meeting expected delivery times. Your goal is to evaluate current tracking precision and identify potential improvements.

/*Tables

fct_orders(order_id, delivery_partner_id, delivery_partner_name, expected_delivery_time, actual_delivery_time, order_date)
*/

-- What is the percentage of orders delivered on time in January 2024? Consider an order on time if its actual_delivery_time is less than or equal to its expected_delivery_time. This will help us assess overall tracking precision.
select 
  (count(CASE
  when f.actual_delivery_time <= f.expected_delivery_time then f.order_id 
  end) * 100 /count(f.order_id)) as precent_orders  from fct_orders f
  where f.order_date between '2024-01-01' and '2024-01-31'


-- List the top 5 delivery partners in January 2024 ranked by the highest percentage of on-time deliveries. Use the delivery_partner_name field from the records. This will help us identify which partners perform best.
 SELECT
f.delivery_partner_name,
   count( CASE
   when f.actual_delivery_time<= f.expected_delivery_time 
   then f.order_id
   END)/count( f.order_id) as best_performer
from fct_orders f
where f.order_date between '2024-01-01' and '2024-01-31'
group by f.delivery_partner_name
order by best_performer DESC
limit 5;

-- Identify the delivery partner(s) in January 2024 whose on-time delivery percentage is below 50%. Return their partner names in uppercase. We need to work with these delivery partners to improve their on-time delivery rates.
 select
  UPPER(f.delivery_partner_name) as upper
from fct_orders f
where f.order_date between '2024-01-01' and '2024-01-31'
group by UPPER(f.delivery_partner_name)
having count(CASE
   when f.actual_delivery_time <= f.expected_delivery_time
   then f.order_id
   end)*100/count(f.order_id) <50

