use practice_db;

create table customers(
id int not null,
first_name varchar(50) not null,
country varchar(25),
score int,
primary  key (id)
);

insert into customers (id,first_name,country,score) values 
(1,'Ajita','Nepal',350),
(2,'Jake','USA',900),
(3,'John','UK',750),
(4,'Oscar','Australia',500);

insert into customers (id,first_name,country,score) values 
(5,'Radha','UK',505);

select * from customers;

create table orders (
order_id int not null,
customer_id int not null,
order_date date,
sales int,
foreign key (customer_id) references customers(id));

insert into orders (order_id, customer_id,order_date,sales) values 
(1001,1,'2021-01-11',35),
(1002,2,'2021-04-05',15),
(1003,3,'2021-06-18',20),
(1004,4,'2021-08-31',10);

select * from orders;

-- inner join
/* Get all the customers along with their orders, 
 but only for customers who have placed an order*/

select 
     c.id,
     c.first_name,
     o.order_id,
     o.sales 
from customers as c
inner join orders as o
on c.id=o.customer_id;

-- left outer join
/* returns all rows from left table and only matching rows from right table */

/* get all customers along with their orders, including those without orders */

select 
    c.id,
    c.first_name,
    o.order_id,
    o.sales
    from customers as c
    left join orders as o
    on c.id=o.customer_id;

/* Get all customers along with their orders, 
 including orders without matching customers*/

select
*
from orders as o
left join customers as c
on o.customer_id = c.id;


-- Full join
/* Get all customers and all order, even if there's no match
select *
from customers as c
full join orders as o
on c.id=o.customer_id;

mariadb doesnot support full join */


/* Advanced SQL JOINS*/

/* Get all customers who haven't placed any order*/

select *
from customers as c
left join orders as o
on c.id=o.customer_id
where o.customer_id is null;


/* Get all orders without matching customers */

select *
from customers as c
right join orders as o
on c.id=o.customer_id
where c.id is null;


/* Get all customers along with their orders,
  but only for customers who have placed an order [without using inner join]
 */

select *
from customers as c
left join orders as o
on c.id=o.customer_id
where o.customer_id is not null;

select *
from customers as c
inner join orders as o
on c.id=o.customer_id;
 
-- CROSS JOIN
-- COMBINES every row from left with every row to right
-- like cartesian product








