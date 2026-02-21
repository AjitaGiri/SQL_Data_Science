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






