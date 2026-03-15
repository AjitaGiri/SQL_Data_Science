/*
One Touch Conversion Performance for Mobile Shoppers

As a Product Analyst on the PayPal One Touch team,
you are investigating mobile checkout conversion rates
for the One Touch login feature.
Your team wants to understand how different login methods impact transaction completion across mobile platforms. You will use transaction data to evaluate login method performance and user engagement.

Tables

fct_mobile_transactions(transaction_id, user_id,
transaction_date, login_method, transaction_status)

*/

-- For our analysis of the PayPal One Touch feature, what is the total number of mobile transactions that used One Touch during July 2024? You might notice that the login_method doesn't have consistent capitalization, so make sure to account for this in your query!
SELECT
count(f.transaction_id) as no_of_transactions
from fct_mobile_transactions f
where lower(f.login_method) = 'one touch' and 
  f.transaction_date BETWEEN '2024-07-01' and '2024-07-31' ;

-- To determine user adoption of the One Touch feature, how many distinct users had sucesssful mobile transactions using One Touch during July 2024? Rename the column for user counts to 'Unique_Users'. This information will support our investigation of transaction engagement.

 SELECT 
count(DISTINCT f.user_id) as Unique_Users
from fct_mobile_transactions f
where lower(f.login_method)='one touch' AND
f.transaction_date between '2024-07-01' and '2024-07-31'
   AND f.transaction_status='Success';

-- We want to understand the adoption of One Touch vs. Standard features. How many of successful transactions were there in July 2024 respectively for One Touch and Standard? Recall that the data in login_method has inconsistent capitalization, so we want to handle for this!
select
lower(f.login_method) as login_method,
count(f.transaction_id) as no_of_successful_transactions
from fct_mobile_transactions f
where (lower(f.login_method)='one touch' AND lower(f.login_method)='standard') 
AND f.transaction_date between '2024-07-01' and '2024-07-31'
AND f.transaction_status='Success'
group by lower(f.login_method);
