--correlated query

--Analyzing customer behavior
--A new advertising campaign is going to focus on customers who rented fewer than 5 movies. Use a correlated query to extract all customer information for the customers of interest.

--First, count number of movie rentals for customer with customer_id=45. Give the table renting the alias r.
-- Count movie rentals of customer 45
select
count(*)
from renting
where customer_id=45

-- Select customers with less than 5 movie rentals
SELECT *
FROM customers as c
WHERE 5 >
	(SELECT count(*)
	FROM renting as r
	WHERE r.customer_id = c.customer_id);

-- Movies and ratings with correlated queries
Report a list of movies that received the most attention on the movie platform, (i.e. report all movies with more than 5 ratings and all movies with an average rating higher than 8).

	SELECT *
FROM movies AS m
WHERE 8 < (
    SELECT AVG(r.rating)
    FROM renting AS r
    WHERE r.movie_id = m.movie_id
);


--Young actors not coming from the USA
--As you've just seen, the operators UNION and INTERSECT are powerful tools when you work with two or more tables. Identify actors who are not from the USA and actors who were born after 1990.

SELECT name, 
       nationality, 
       year_of_birth
FROM actors
WHERE nationality <> 'USA'
 -- Select all actors who are not from the USA and all actors who are born after 1990
UNION
SELECT name, 
       nationality, 
       year_of_birth
FROM actors
WHERE year_of_birth > 1990;

Select all actors who are not from the USA and who are also born after 1990.
SELECT name, 
       nationality, 
       year_of_birth
FROM actors
WHERE nationality <> 'USA'
intersect-- Select all actors who are not from the USA and who are also born after 1990
SELECT name, 
       nationality, 
       year_of_birth
FROM actors
WHERE year_of_birth > 1990;

--Dramas with high ratings
--The advertising team has a new focus. They want to draw the attention of the customers to dramas. Make a list of all movies that are in the drama genre and have an average rating higher than 9.
SELECT movie_id
FROM movies
WHERE genre = 'Drama'
intersect -- Select the IDs of all dramas with average rating higher than 9
SELECT movie_id
FROM renting
GROUP BY movie_id
HAVING AVG(rating)>9;

SELECT *
FROM movies
where movie_id in -- Select all movies of genre drama with average rating higher than 9
   (SELECT movie_id
    FROM movies
    WHERE genre = 'Drama'
    INTERSECT
    SELECT movie_id
    FROM renting
    GROUP BY movie_id
    HAVING AVG(rating)>9);

    --Customers with at least one rating
Having active customers is a key performance indicator for MovieNow. Make a list of customers who gave at least one rating.
SELECT *
FROM customers as c -- Select all customers with at least one rating
WHERE exists
	(SELECT *
	FROM renting AS r
	WHERE rating IS NOT NULL 
	AND r.customer_id = c.customer_id);

    