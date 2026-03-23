-- find the products that have a price higher thand the average price of all products
select
*
from
(
    select
    productid,
    price,
    avg(price) AvgPrice
    from sales.products
)t 
where price > AvgPrice;

-- Rank customers based on their total amount of sales

select
*,
rank() over (order by TotalSales desc) CustomersRank
from 
(
    select 
    customerid,
    sum(sales) TotalSales
    from sales.orders
    group by customerid
)t
 
-- show the prduct ids, product names, prices and the total number of orders
select
    productid,
    productname,
    price
    (select 
    count(*) 
    from sales.orders) as TotalOrders
from sales.products;
 
-- show all customer details and find the total orders of each customer

select
c.*,
o.totalorders
from sales.customers c
left join (
    select
    customerid,
    count(*) totalorders
    from sales.orders
    group by customerid
) o
on c.customerid=o.customerid;

-- find the products that have a price higher than the average price of all products

select
productid,
product,
price
from sales.products
where price > (select avg(price) from sales.products);

-- show the details of orders made by customers in Germany
select
*
from sales.orders
where customerid in (
                    select
                    country
                    from sales.customers 
                    where country='Germany')

-- find female employees whose salaries are greater than the salaries of any male employees
select
EmployeeId,
FirstName,
Salary
from sales.employees
where Gender='F' and 
Salary > ANY (select Salary from sales.employees where Gender='M');

-- find female employees whose salaries are greater than the salaries of all male employees

select
EmployeeId,
FirstName,
Salary
from sales.employees
where Gender='F' and
Salary > All (select Salary from sales.employees where Gender='M');

--  Correlated subquery
-- show all customer details and find the total orders of each customer

select
*,
(select count(*) from sales.orders o where o.customerid= c.customerid) TotalSales
from sales.customer c;


-- show the details of orders made by customers in Germany
select
*
from sales.orders o
where exists (
            select
            1
            from sales.customers c
            where country='Germany'
            and c.customerid=o.customerid
        )

-- show the details of orders made by customers not in Germany
select
*
from sales.orders o
where not exists (
            select
            1
            from sales.customers c
            where country='Germany'
            and c.customerid=o.customerid
        );
