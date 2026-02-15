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


-- CTE (Common Table Expressions)

with w1 as 
(select c.customer_id, sum(p.amount)  as total_amount from payment p inner join customer c on c.customer_id =p.customer_id group by c.customer_id),
w2 as 
(select c.customer_id, min(p.amount) as min_amount from payment p inner join customer c on p.customer_id =c.customer_id group by c.customer_id )
select * from w1 inner join w2 on w1.customer_id =w2.customer_id ;



-- Window Functions
select *, sum(p.amount) over (partition by p.customer_id order by p.payment_date) from payment p;

-- rank and dense rank [imp]
-- find the customer who have paid second highest amount

select * from(
with w1 as 
( select p.customer_id, sum(p.amount) as total_amount from payment p group by p.customer_id)
select *,rank() over (order by total_amount desc) as rn from w1) temp where rn=2;

select * from(
with w1 as 
( select p.customer_id, sum(p.amount) as total_amount from payment p group by p.customer_id)
select *,dense_rank() over (order by total_amount desc) as rn from w1) temp where rn=4;

-- order by
select * from customer c order by c.first_name;

select * from customer c order by c.first_name desc;

-- view in database
create view V_Customer_Payment as
select 
c.customer_id,
c.first_name,
c.last_name,
c.email,
sum(p.amount) as total_amount
from payment p 
inner join customer c on p.customer_id =c.customer_id
group by c.customer_id,
c.first_name,
c.last_name,
c.email;

select * from V_Customer_Payment;
