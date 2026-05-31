-- generate a sequence of numbers from 1 to 20

with series as(
    -- anchor query
    select
    1 as mynumber

    UNION ALL

    -- recursive query
    select mynumber +1
    from series
    where mynumber < 20
)
select * 
from series
option (maxrecursion 20);

-- Show the employee hierarchy by displaying  each employee's level within the organization
With CTE_Emp_Hierarchy as (

    select
    EmployeeID,
    FirstName,
    ManagerID,
    1 as Level
    from Sales.Employees
    Where ManagerID IS NULL

    UNION ALL

    Select
    e.EmployeeID,
    e.FirstName,
    e.ManagerID,
    Level+1
    from Sales.Employees as e
    inner join CTE_Emp_Hierarchy ceh
    on e.ManagerID = ceh.EmployeeID
)

select *
from
CTE_Emp_Hierarchy;
