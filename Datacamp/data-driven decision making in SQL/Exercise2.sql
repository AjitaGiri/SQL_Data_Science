-- Create a table with a row for each country and columns for the country name and the date when the first customer account was created.
-- Use the alias first_account for the column with the dates.
-- Order by date in ascending order.
SELECT country, -- For each country report the earliest date when an account was created
	min(date_account_start) AS first_account
FROM customers
GROUP BY country
ORDER BY first_account;

SELECT movie_id, 
       avg(rating)    -- Calculate average rating per movie
FROM renting
group by movie_id;

SELECT movie_id, 
       AVG(rating) AS avg_rating, -- Use as alias avg_rating
       count(rating) as number_rating,                -- Add column for number of ratings with alias number_rating
       count(renting_id) as number_renting                -- Add column for number of movie rentals with alias number_renting
FROM renting
GROUP BY movie_id;

SELECT movie_id, 
       AVG(rating) AS avg_rating,
       COUNT(rating) AS number_ratings,
       COUNT(*) AS number_renting
FROM renting
GROUP BY movie_id
order by avg_rating asc; -- Order by average rating in decreasing order

-- Group the data in the table renting by customer_id and report the customer_id, the average rating, the number of ratings and the number of movie rentals.
--Select only customers with more than 7 movie rentals.
--Order the resulting table by the average rating in ascending order.

SELECT customer_id, -- Report the customer_id
      avg(rating),  -- Report the average rating per customer
      count(rating),  -- Report the number of ratings per customer
      count(movie_id)  -- Report the number of movie rentals per customer
FROM renting
GROUP BY customer_id
having count(movie_id)>7 -- Select only customers with more than 7 movie rentals
ORDER BY avg(rating); -- Order by the average rating in ascending order

-- Join renting and customers
--For many analyses it is necessary to add customer information to the data in the table renting.

-- Augment the table renting with all columns from the table customers with a LEFT JOIN.
--Use as alias' for the tables r and c respectively.
SELECT * -- Join renting with customers
FROM renting r
LEFT JOIN customers c
ON r.customer_id=c.customer_id;

SELECT *
FROM renting AS r
LEFT JOIN customers AS c
ON r.customer_id = c.customer_id
where c.country='Belgium'; -- Select only records from customers coming from Belgium

SELECT avg(r.rating) -- Average ratings of customers from Belgium
FROM renting AS r
LEFT JOIN customers AS c
ON r.customer_id = c.customer_id
WHERE c.country='Belgium';

-- Aggregating revenue, rentals and active customers
-- The management of MovieNow wants to report key performance indicators (KPIs) for the performance of the company in 2018. They are interested in measuring the financial successes as well as user engagement. Important KPIs are, therefore, the revenue coming from movie rentals, the number of movie rentals and the number of active customers.

SELECT 
	SUM(m.renting_price), 
	COUNT(*), 
	COUNT(DISTINCT r.customer_id)
FROM renting AS r
LEFT JOIN movies AS m
ON r.movie_id = m.movie_id
-- Only look at movie rentals in 2018
WHERE date_renting between '2018-01-01' and '2018-12-31' ;

 SELECT m.title, -- Create a list of movie titles and actor names
       a.name
FROM actsin ai
LEFT JOIN movies AS m
ON m.movie_id = ai.movie_id
LEFT JOIN actors AS a
ON a.actor_id = ai.actor_id;
