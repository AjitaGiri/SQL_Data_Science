/*
Subscriber Growth in Emerging Markets

Tables

fact_marketing_spend(spend_id, country_id, campaign_date, amount_spent)
fact_daily_subscriptions(subscription_id, country_id, signup_date, num_new_subscribers)
dimension_country(country_id, country_name)

As a Data Analyst on the Netflix Marketing Data Team,
you are tasked with analyzing the efficiency of marketing
spend in various emerging markets. Your analysis will 
focus on understanding the allocation of marketing budgets 
and the resulting subscriber acquisition. The end goal is to 
provide insights that will guide the team in optimizing
marketing strategies and budget distribution across different 
countries.

*/

-- Retrieve the total marketing spend in each country for Q1 2024 to help inform budget distribution across regions.

SELECT
c.country_name,
sum(f.amount_spent) TotalSpend
from fact_marketing_spend f
inner join dimension_country c
on f.country_id= c.country_id
WHERE f.campaign_date BETWEEN '2024-01-01' and '2024-03-31'
group by c.country_name;

-- List the number of new subscribers acquired in each country (with name) during January 2024, renaming the subscriber count column to 'new_subscribers' for clearer reporting purposes.

 SELECT
dc.country_name,
sum(ds.num_new_subscribers) new_subscribers
from fact_daily_subscriptions ds
inner join dimension_country dc
on ds.country_id = dc.country_id
WHERE  ds.signup_date between '2024-01-01' and '2024-01-31'
group by dc.country_name

--Determine the average marketing spend per new subscriber for each country in Q1 2024 by rounding up to the nearest whole number to evaluate campaign efficiency.
SELECT
   dc.country_name,
   sum(fms.amount_spent) totalspent,
   sum(fds.num_new_subscribers) totalnewsubscriber,
   ceil( sum(fms.amount_spent)/ sum(fds.num_new_subscribers)) avgspentpernewsubscriber
from fact_marketing_spend fms
inner join fact_daily_subscriptions fds
  on fms.campaign_date = fds.signup_date and fms.country_id=
   fds.country_id
   inner join dimension_country dc
   on fms.country_id = dc.country_id
where fms.campaign_date between '2024-01-01' and '2024-03-31'
group by dc.country_name