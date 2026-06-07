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