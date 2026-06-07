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

SELECT rm.title, -- Report the income from movie rentals for each movie 
       sum(rm.renting_price) AS income_movie
FROM
       (SELECT m.title,  
               m.renting_price
       FROM renting AS r
       LEFT JOIN movies AS m
       ON r.movie_id=m.movie_id) AS rm
group by rm.title
ORDER BY income_movie desc; -- Order the result by decreasing income

SELECT a.gender, -- Report for male and female actors from the USA 
       min(a.year_of_birth), -- The year of birth of the oldest actor
       max(a.year_of_birth) -- The year of birth of the youngest actor
FROM
   (select * -- Use a subsequen SELECT to get all information about actors from the USA
   from actors 
   where nationality='USA') AS a -- Give the table the name a
GROUP BY a.gender;

SELECT m.title, 
COUNT(*),
AVG(r.rating)
FROM renting AS r
LEFT JOIN customers AS c
ON c.customer_id = r.customer_id
LEFT JOIN movies AS m
ON m.movie_id = r.movie_id
WHERE c.date_of_birth BETWEEN '1970-01-01' AND '1979-12-31'
GROUP BY m.title
having count(*) >1 -- Remove movies with only one rental
order by avg(r.rating) desc; -- Order with highest rating first

--Identify favorite actors for Spain
--You're now going to explore actor popularity in Spain. Use as alias the first letter of the table, except for the table actsin use ai instead.
SELECT a.name,  c.gender,
       COUNT(*) AS number_views, 
       AVG(r.rating) AS avg_rating
FROM renting as r
LEFT JOIN customers AS c
ON r.customer_id = c.customer_id
LEFT JOIN actsin as ai
ON r.movie_id = ai.movie_id
LEFT JOIN actors as a
ON ai.actor_id = a.actor_id

GROUP BY a.name, c.gender -- For each actor, separately for male and female customers
HAVING AVG(r.rating) IS NOT NULL AND count(*)>5 -- Report only actors with more than 5 movie rentals
ORDER BY avg_rating DESC, number_views DESC;

--  report the favorite actors only for customers from Spain.
SELECT a.name,  c.gender,
       COUNT(*) AS number_views, 
       AVG(r.rating) AS avg_rating
FROM renting as r
LEFT JOIN customers AS c
ON r.customer_id = c.customer_id
LEFT JOIN actsin as ai
ON r.movie_id = ai.movie_id
LEFT JOIN actors as a
ON ai.actor_id = a.actor_id
where c.country='Spain' -- Select only customers from Spain
GROUP BY a.name, c.gender
HAVING AVG(r.rating) IS NOT NULL 
  AND COUNT(*) > 5 
ORDER BY avg_rating DESC, number_views DESC;

-- KPIs per country
-- In chapter 1 you were asked to provide a report about the development of the company. This time you have to prepare a similar report with KPIs for each country separately. Your manager is interested in the total number of movie rentals, the average rating of all movies and the total revenue for each country since the beginning of 2019.

-- Calculate the number of movie rentals.
--Calculate the average rating.
--Calculate the revenue from movie rentals.
--Report these KPIs for each country.
SELECT 
	c.country ,                  -- For each country report
	count(*) AS number_renting, -- The number of movie rentals
	avg(r.rating) AS average_rating, -- The average rating
	sum(m.renting_price) AS revenue         -- The revenue from movie rentals
FROM renting AS r
LEFT JOIN customers AS c
ON c.customer_id = r.customer_id
LEFT JOIN movies AS m
ON m.movie_id = r.movie_id
WHERE date_renting >= '2019-01-01'
group by c.country;

