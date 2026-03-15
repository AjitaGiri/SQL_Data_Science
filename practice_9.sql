/*
Top-Rated Listings

Tables

listings(id, name, neighborhood, rating, price, is_superhost)

*/

-- Airbnb wants to feature top-rated listings on their homepage. Write a query to return the name, neighborhood, and rating of all listings with a rating of 4.5 or higher.

SELECT
l.name,
  l.neighborhood,
  l.rating
from listings l
where l.rating >=4.5;


