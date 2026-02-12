select * from film;

-- select title and release_year from film
select title, release_year
from film;

-- find the distinct ratings of film
select distinct rating
from film;

-- find number of films of each rating
select rating,count(*) as record_count
from film
group by rating;

-- find films with rental_duration between 3 and 5 days
select title, rental_duration
from film
where rental_duration between 3 and 5;

-- find all the movies whose title ends in letter R
select title
from film f
where f.title like '%R';

-- find title and release year of film whoe length is longer than 90
select title, release_year
from film f
where f.length >=90;

-- find distinct city name form each customer comes from
select c.first_name,c.last_name,a.address,ci.city
from customer c
inner join address a 
on c.address_id =a.address_id 
inner join city ci 
on ci.city_id =a.city_id ;

-- find the number of customers from each city
select 
ci.city,
count(c.customer_id) as no_of_customer
from customer c
inner join address a
on c.address_id= a.address_id 
inner join city ci
on ci.city_id = a.city_id 
group by ci.city;

-- find the number of customers from each country
select 
co.country ,
count(c.customer_id ) as no_of_customer
from customer c
inner join address a
on c.address_id =a.address_id 
inner join city ci
on ci.city_id =a.city_id 
inner join country co
on co.country_id =co.country_id 
group by co.country;

-- find number of actors in each title of film
/*
select 
f.title,
count( distinct a.actor_id) as no_of_actors
from actor a
inner join film_actor fa
on a.actor_id  = fa.actor_id 
inner join film f
on f.film_id =fa.film_id 
group by f.title;
*/

select
f.title,
count (distinct a.actor_id) as no_of_actors
from film f
inner join film_actor a
on f.film_id=a.film_id
group by f.title;

-- find the minimum and maximum length of films
select 
f.title,
min(f.length) as  min_len,
max(f.length) as max_len
from film f;

-- find the min,max and average length for each category
select 
c.name,
min(f.length) as min_length,
max(f.length) as max_length,
avg(f.length) as avg_length
from film f
inner join film_category fc 
on f.film_id =fc.film_id 
inner join category c 
on c.category_id =fc.category_id 
group by c.name;


-- find the total payment made by each customer
select 
p.customer_id,
sum(p.amount) as total_payment
from payment p
group by p.customer_id ;

/*

select 
p.customer_id,
sum(p.amount) as total_payment
from payment p
group by p.customer_id ;


vs

select 
c.customer_id,
sum(p.amount) as total_payment
from payment p
inner join customer c
on p.customer_id =c.customer_id 
group by c.customer_id ;

first see if the columns i need are in same table?
if yes: no need of join
if no: perform join

join operations are costly

*/

select
p.customer_id ,
c.first_name ,
c.last_name ,
sum(p.amount ) as total_payment
from customer c
inner join payment p 
on c.customer_id = p.customer_id 
group by c.customer_id
limit 10;

