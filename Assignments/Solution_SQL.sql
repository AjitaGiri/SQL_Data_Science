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


-- q28
select 
s.staff_id ,
s.first_name,
s.last_name,
a.address 
from staff s 
inner join address a 
on s.address_id = a.address_id;

-- q29
select
s.staff_id ,
s.first_name ,
s.last_name ,
sum(p.amount ) as total_amount
from staff s 
inner join payment p 
on s.staff_id =p.staff_id 
where p.payment_date >= '2005-08-01' and p.payment_date < '2005-09-01'
group by 
s.staff_id ,
s.first_name ,
s.last_name ;

-- q30
select 
f.film_id,
f.title,
count(fa.actor_id ) as no_of_actors
from film f 
inner join film_actor fa 
on f.film_id =fa.film_id 
group by f.film_id ,f.title;

-- q31
select
s2.store_id ,
count(s2.staff_id) as no_of_active_staff
from staff s2 
where s2.active =1
group by s2.store_id 
order by no_of_active_staff desc
limit 1;

-- q32
select 
c.customer_id ,
c.first_name ,
c.last_name ,
a.address,
a.postal_code ,
c2.city ,
c3.country 
from customer c 
inner join address a 
on c.address_id =a.address_id 
inner join city c2 
on a.city_id =c2.city_id 
inner join country c3 
on c2.country_id =c3.country_id ;

-- q33
select 
c3.country ,
count(c.customer_id) as no_of_customer
from customer c 
inner join address a 
on c.address_id =a.address_id 
inner join city c2 
on a.city_id =c2.city_id 
inner join country c3 
on c2.country_id =c3.country_id 
group by c3.country;

-- q34
select 
c2.city ,
count(c.customer_id) as no_of_customer
from customer c 
inner join address a 
on c.address_id =a.address_id 
inner join city c2 
on a.city_id =c2.city_id 
group by c2.city ;

-- q35
select
c.customer_id ,
c.first_name ,
c.last_name,
f.title 
from customer c 
inner join rental r 
on c.customer_id = r.customer_id 
inner join inventory i 
on r.inventory_id =i.inventory_id 
inner join film f 
on i.film_id =f.film_id;

-- q36
select
c.customer_id ,
c.first_name ,
c.last_name
from customer c 
left  join rental r 
on c.customer_id = r.customer_id 
where r.rental_id is null;

-- Q37
select 
count(*) as num_copies
from film f 
inner join inventory i 
on f.film_id =i.film_id
where f.title = 'Hunchback Impossible';

-- q38
select
c.customer_id ,
c.first_name ,
c.last_name ,
sum(p.amount) as total_amount
from customer c 
inner join payment p 
on c.customer_id =p.customer_id 
group by c.customer_id ,
c.first_name ,
c.last_name 
order by c.last_name;


-- q39
select
c.customer_id ,
c.first_name ,
c.last_name,
count(r.rental_date ) as rentals
from customer c
inner join rental r 
on c.customer_id =r.customer_id 
group by c.customer_id ,
c.first_name ,
c.last_name 
having count(r.rental_id )>5;

-- q40
select 
f.film_id,
f.title
from  film f 
left join inventory i 
on f.film_id =i.film_id 
left join rental r 
on i.inventory_id =r.inventory_id 
where r.rental_id is null;

-- q41

select
c.customer_id ,
c.first_name ,
c.last_name 
from customer c 
left join payment p 
on c.customer_id =p.customer_id 
where p.payment_id is null;

-- q42

select
a.actor_id ,
a.first_name ,
a.last_name 
from film f
inner join film_actor fa 
on f.film_id =fa.film_id 
inner join actor a 
on fa.actor_id =a.actor_id 
where f.title ='ACADEMY DINOSAUR';

-- q43

with rental_count_per_customer as(
select
c.customer_id ,
c.first_name ,
c.last_name,
count(r.rental_id) as num_rentals
from customer c 
inner join rental r 
on c.customer_id =r.customer_id 
group by c.customer_id,c.first_name ,c.last_name 
) 
select 
*
from rental_count_per_customer 
where num_rentals > (select avg(num_rentals) from rental_count_per_customer)

-- q44
select
f.film_id ,
f.title,
f.rental_rate 
from film f
where f.rental_rate = ( select max(f2.rental_rate ) from film f2 );

-- q45

select
fc.category_id,
count(fc.film_id ) as no_of_film
from film_category fc 
group by fc.category_id 
order by no_of_film desc 
limit 1;

-- q46
--  using join
select
a.actor_id ,
a.first_name ,
a.last_name ,
f.title 
from film f 
inner join film_actor fa 
on f.film_id =fa.film_id 
inner join actor a 
on fa.actor_id =a.actor_id 
where f.title ='Alone Trip';

-- using subquery
select 
a.actor_id ,
a.first_name ,
a.last_name 
from actor a
where a.actor_id in ( 
select fa.actor_id
from film_actor fa 
where fa.film_id = (
select f.film_id
from film f 
where f.title='Alone Trip'
)
);


-- q47

select 
f.film_id,
f.title,
f.`length` ,
case 
	when f.`length`  < 60 then 'Short'
	when f.`length`  between 60 and 120 then 'Medium'
	else 'Long' 
end as category
from film f ;

-- q48

select
p.payment_id ,
p.amount,
case 
	when p.amount > 5 then 'High'
	else 'Low'
end as payment_flag
from payment p 

-- q49

select 
c3.country ,
count(c.customer_id ) as no_of_customers
from customer c 
inner  join address a 
on c.address_id =a.address_id 
inner join city c2 
on a.city_id =c2.city_id 
inner join country c3 
on c2.country_id =c3.country_id 
group by c3.country 
having count(c.customer_id )>20;

-- q50
with payment_per_customer as (
	select 
	c.store_id,
	c.customer_id ,
	c.first_name ,
	c.last_name,
	count(p.payment_id ) as num_payment
from  customer c
inner join payment p 
on  p.customer_id = c.customer_id
group by c.store_id,c.customer_id ,c.first_name , c.last_name 
)
select 
	ppc.store_id ,
	ppc.customer_id ,
	ppc.first_name ,
	ppc.last_name ,
	ppc.num_payment 
from payment_per_customer ppc
where ppc.num_payment = ( 
	select max(num_payment) 
	from payment_per_customer 
	where store_id =ppc.store_id
)










 



 




