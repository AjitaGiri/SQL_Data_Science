-- subquery in sql 

-- find all the movies/film which are longer than the average length


select * 
from film f
where f.`length` > (select AVG(f.`length`) as avg_len from film f);

-- select
-- I want all the title along with the max,min and avg length

select *,
(select min(length) from film f2) as min_len,
(select max(length) from film f2) as max_len,
(select avg(length) from film f2) as avg_len
from film f;

-- having clause: filter the aggregated values

-- Find all the customers who have paid more than 100$ in total
select
p.customer_id,
sum(p.amount) as total
from payment p
group by p.customer_id
having  total >100;

-- find customers who have made payment more than 5 times

select
p.customer_id,
count(1) as payment_count
from payment p
group by p.customer_id 
having payment_count >5;

-- finding the duplicates
select c.customer_id,
COUNT(1) as record_count
from customer c
group by c.customer_id 
having record_count >1;

-- IN

-- find all the films that have ids 1,3,5,7,9
select 
f.title,
f.film_id
from film f
-- where (f.film_id = 1 or f.film_id =3 or f.film_id =5 or f.film_id =7 or f.film_id=9);
where f.film_id in (1,3,5,7,9);

select * from film f
where f.film_id  in (select film_id from film where film_id %2 !=0);


-- CTE common table expressions


