-- Often rented movies
-- Your manager wants you to make a list of movies excluding those which are hardly ever watched. This list of movies will be used for advertising. List all movies with more than 5 views using a nested query which is a powerful tool to implement selection conditions.
SELECT movie_id
FROM renting
GROUP BY movie_id
HAVING COUNT(*) > 5

-- Select all information about movies with more than 5 views.
SELECT *
FROM movies
where movie_id in   -- Select movie IDs from the inner query
	(SELECT movie_id
	FROM renting
	GROUP BY movie_id
	HAVING COUNT(*) > 5)

-- Frequent customers
--Report a list of customers who frequently rent movies on MovieNow.

-- List all customer information for customers who rented more than 10 movies
SELECT *
FROM customers
where customer_id in           -- Select all customers with more than 10 movie rentals
	(SELECT customer_id
	FROM renting
	GROUP BY customer_id
	having count(*)>10);

-- Movies with rating above average
-- For the advertising campaign your manager also needs a list of popular movies with high ratings. Report a list of movies with rating above average.
SELECT movie_id, 
       avg(rating)
FROM renting
group by movie_id
having avg(rating) >          -- Of movies with rating above average
	(SELECT AVG(rating)
	FROM renting);

-- The advertising team only wants a list of movie titles. Report the movie titles of all movies with average rating higher than the total average.
SELECT title -- Report the movie titles of all movies with average rating higher than the total average
FROM movies
WHERE movie_id in
	(SELECT movie_id
	 FROM renting
     GROUP BY movie_id
     HAVING AVG(rating) > 
		(SELECT AVG(rating)
		 FROM renting));
		 