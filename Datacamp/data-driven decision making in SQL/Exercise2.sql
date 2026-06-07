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

