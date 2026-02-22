-- 	q1.
	select * from film;
	
-- q2
	select * from actor;

-- q3
select a.first_name, a.last_name from actor a;

-- q4
select upper(concat(a.first_name,' ', a.last_name)) as ActorName
from actor a;

-- q5
select 
a.actor_id,
a.first_name,
a.last_name
from actor a 
where a.first_name ='Joe';

-- q6
select distinct 
c.name 
from category c;

-- q7
select distinct 
l.name
from language l;

-- q8
select 
cu.first_name,
cu.last_name ,
c.city 
from customer cu
inner join address a
on cu.address_id =a.address_id 
inner join city c
on a.city_id =c.city_id 
where c.city='Dallas';

-- q9
select 
f.title,
f.release_year 
from film f 
where f.release_year >='2006';

-- q10
select
*
from staff s 
where s.active = 1;

-- q11
select 
* from customer c 
where c.active =1;

-- q12
select 
f.title 
from film f 
where f.rental_duration >3;

-- q13
select
-- concat(a.last_name,' ',a.first_name) 
a.first_name ,
a.last_name 
from actor a 
where a.last_name like '%LI%'
order by a.last_name ,a.first_name ;

-- q14
select
c.country_id ,
c.country
from country c 
where c.country in ('Afghanistan','Bangladesh','China')



-- q15 
select 
f.title,
f.`length` 
from film f 
order by f.`length` desc 
limit 5;

-- q16
select 
*
from customer c 
order by c.first_name, c.last_name 
limit 10;

-- q17
select
f.title,
f.rental_rate 
from film f 
where f.rental_rate < 2.00;

-- q18
select
f.title
from film f
where f.title like '%DOG%';

-- q19
select
*
from customer c 
order by c.create_date desc
limit 1;

-- q20
select f.title,
f.rental_rate
from film f
order by f.rental_rate asc
limit 10;

-- q21
select 
count(*) as no_of_customers
from customer c 

-- q22
select
r.customer_id ,
count(r.rental_id ) as no_of_rentals
from rental r 
group by r.customer_id ;

-- q23
select 
f.rating,
count(f.film_id ) as no_of_films
from film f 
group by f.rating ;

-- q24
select
AVG(f.rental_rate) as average_rental
from film f;

-- q25
select 
max(p.amount) as highest_payment
from payment p ;

-- q26
select 
f.language_id ,
count(f.film_id ) as no_of_film
from film f 
group by f.language_id ;


-- q27
select
f.rating ,
avg(f.`length` ) as average_length
from film f
group by f.rating;




 




