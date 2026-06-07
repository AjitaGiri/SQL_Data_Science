-- Exploring the table renting
-- The table renting includes all records of movie rentals. Each record has a unique ID renting_id. It also contains information about customers (customer_id) and which movies they watched (movie_id). Furthermore, customers can give a rating after watching the movie, and the day the movie was rented is recorded.
select * from renting;

-- Now select only those columns from renting which are needed to calculate the average rating per movie.
SELECT renting.movie_id,  -- Select all columns needed to compute the average rating per movie
       renting.rating
FROM renting;

-- Working with dates
-- For the analysis of monthly or annual changes, it is important to select data from specific time periods. You will select records from the table renting of movie rentals. The format of dates is 'YYYY-MM-DD'.
-- 1. Select all movies rented on October 9th, 2018.
SELECT *
FROM renting
where date_renting = '2018-10-9'; -- Movies rented on October 9th, 2018

-- 2. Select all records of movie rentals between beginning of April 2018 till end of August 2018.
SELECT *
FROM renting
WHERE date_renting BETWEEN '2018-04-01' AND '2018-08-31'; -- from beginning April 2018 to end August 2018

-- 3. Put the most recent records of movie rentals on top of the resulting table and order them in decreasing order.
SELECT *
FROM renting
WHERE date_renting BETWEEN '2018-04-01' AND '2018-08-31'
ORDER BY date_renting DESC; -- Order by recency in decreasing order

--Selecting movies
-- The table movies contains all movies available on the online platform.
-- 1.Select all movies which are not dramas.
SELECT *
FROM movies
where genre <> 'Drama'; -- All genres except drama
-- 2.Select the movies 'Showtime', 'Love Actually' and 'The Fighter'.
SELECT *
FROM movies
where title in ('Showtime', 'Love Actually' , 'The Fighter'); -- Select all movies with the given titles
-- 3.Order the movies by increasing renting price.
SELECT *
FROM movies
order by renting_price desc ; -- Order the movies by increasing renting price

-- Select from renting
-- Only some users give a rating after watching a movie. Sometimes it is interesting to explore only those movie rentals where a rating was provided.

-- Select from table renting all movie rentals from 2018.
--Filter only those records which have a movie rating.
SELECT *
FROM renting
WHERE date_renting between '2018-01-01' and '2018-12-31' -- Renting in 2018
AND rating is not null; -- Rating exists

-- Summarizing customer information
--In most business decisions customers are analyzed in groups, such as customers per country or customers per age group.


-- Count the number of customers born in the 80s.
SELECT count(*) -- Count the total number of customers
FROM customers
WHERE date_of_birth between '1980-01-01' and '1989-12-31'; -- Select customers born between 1980-01-01 and 1989-12-31

--Count the number of customers from Germany.
SELECT count(*)   -- Count the total number of customers
FROM customers
where country='Germany'; -- Select all customers from Germany

--Count the number of countries where MovieNow has customers.
SELECT count(distinct country)  -- Count the number of countries
FROM customers;

-- Ratings of movie 25
-- The movie ratings give us insight into the preferences of our customers. Report summary statistics, such as the minimum, maximum, average, and count, of ratings for the movie with ID 25.

--Select all movie rentals of the movie with movie_id 25 from the table renting.
--For those records, calculate the minimum, maximum and average rating and count the number of ratings for this movie.
SELECT min(rating) as min_rating, -- Calculate the minimum rating and use alias min_rating
	   max(rating) as max_rating, -- Calculate the maximum rating and use alias max_rating
	   avg(rating) as avg_rating, -- Calculate the average rating and use alias avg_rating
	   count(rating) number_ratings -- Count the number of ratings and use alias number_ratings
FROM renting
where movie_id=25; -- Select all records of the movie with ID 25

-- Examining annual rentals
--You are asked to provide a report about the development of the company. Specifically, your manager is interested in the total number of movie rentals, the total number of ratings and the average rating of all movies since the beginning of 2019.

Select * -- Select all records of movie rentals since January 1st 2019
from renting
where date_renting>='2019-01-01'

SELECT 
	COUNT(*), -- This will count the total number of rented movies
	AVG(rating) -- This will calculate the average rating
FROM renting
WHERE date_renting >= '2019-01-01'; -- Filter for rentals since 2019

SELECT 
	COUNT(*) as number_renting, -- Give it the column name number_renting
	AVG(rating) as average_rating -- Give it the column name average_rating
FROM renting
WHERE date_renting >= '2019-01-01';

SELECT 
	COUNT(*) AS number_renting,
	AVG(rating) AS average_rating, 
  count(rating) AS number_ratings -- Add the total number of ratings here.
FROM renting
WHERE date_renting >= '2019-01-01';