/*
Ride Acceptance Rates Across Geographic Zones

You are a Product Analyst working to understand driver ride selection challenges across different geographic zones. The team wants to identify areas where drivers are less likely to accept ride requests. Your analysis will help optimize driver matching and improve ride acceptance strategies.

Tables
fct_zone_daily_rides(zone_name, ride_date, total_requests, accepted_requests, declined_requests, acceptance_rate)

*/

-- For each geographic zone, what is the minimum acceptance rate observed during Quarter 2 2024? This information will help assess the worst-case driver acceptance performance by zone.
SELECT
zone_name,
min(acceptance_rate) as min_rate
from fct_zone_daily_rides
where ride_date between '2024-04-01' and '2024-06-30'
group by zone_name;

-- List the distinct geographic zones that had at least one day in Quarter 2 2024 with an acceptance rate below 50%. This list will be used to identify zones where drivers are generally more reluctant to accept rides.
 SELECT DISTINCT
zone_name
from fct_zone_daily_rides
where acceptance_rate < 0.5 and ride_date between '2024-04-01' and '2024-06-30'

-- Which geographic zone had the lowest ride acceptance rate on a single day in Q2 2024, while also having at least 10 declined ride requests on that same day? Recall that each row in the table represents data for a single data in a single geographic region.
 SELECT
zone_name
from fct_zone_daily_rides
where ride_date between '2024-04-01' and '2024-06-30' and declined_requests >=10
order by  acceptance_rate ASC
limit 1;
