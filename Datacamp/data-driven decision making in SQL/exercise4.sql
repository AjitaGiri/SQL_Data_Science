--Groups of customers
--Use the CUBE operator to extract the content of a pivot table from the database. Create a table with the total number of male and female customers from each country.

--Create a table with the total number of customers, of all female and male customers, of the number of customers for each country and the number of men and women from each country.
SELECT gender, -- Extract information of a pivot table of gender and country for the number of customers
	   country,
	  count(*)
FROM customers
GROUP BY CUBE (gender, country)
ORDER BY country;

--Categories of movies
--Give an overview on the movies available on MovieNow. List the number of movies for different genres and release years.

--List the number of movies for different genres and the year of release on all aggregation levels by using the CUBE operator.
SELECT genre,
       year_of_release,
       count(*)
FROM movies
group by cube(genre,year_of_release)
ORDER BY year_of_release;

-- Calculate the average rating for all aggregation levels of country and genre.
SELECT 
	c.country, 
	m.genre, 
	AVG(r.rating) AS avg_rating -- Calculate the average rating 
FROM renting AS r
LEFT JOIN movies AS m
ON m.movie_id = r.movie_id
LEFT JOIN customers AS c
ON r.customer_id = c.customer_id
group by cube (c.country,m.genre); -- For all aggregation levels of country and genre

-- Exploring nationality and gender of actors
--For each movie in the database, the three most important actors are identified and listed in the table actors. This table includes the nationality and gender of the actors. We are interested in how much diversity there is in the nationalities of the actors and how many actors and actresses are in the list.

--Count the number of actors in the table actors from each country, the number of male and female actors and the total number of actors.
SELECT 
	nationality -- Select nationality of the actors
    ,gender, -- Select gender of the actors
    count(*)-- Count the number of actors
FROM actors
GROUP BY GROUPING SETS ((nationality), (gender), ()); -- Use the correct GROUPING SETS operation

--Exploring rating by country and gender
--Now you will investigate the average rating of customers aggregated by country and gender.


--Select the columns country, gender, and rating and use the correct join to combine the table renting with customer.
--Use GROUP BY to calculate the average rating over country and gender. Order the table by country and gender.
--Now, use GROUPING SETS to get the same result, i.e. the average rating over country and gender.
--Report all information that is included in a pivot table for country and gender in one SQL table.
SELECT 
	c.country, 
    c.gender,
	AVG(r.rating)
FROM renting AS r
LEFT JOIN customers AS c
ON r.customer_id = c.customer_id
-- Report all info from a Pivot table for country and gender
GROUP BY GROUPING SETS ((country, gender),(country),(gender),());
