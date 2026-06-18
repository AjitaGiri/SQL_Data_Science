-- Provide view that combines details from orders, products, customers, and employees
CREATE VIEW Sales.V_Order_Details AS (      
    SELECT
    o.OrderID,
    o.OrderDate,
    p.Product,
    p.Category,
    CONCAT(COALESCE(c.FirstName,'') ,' ' ,COALESCE(c.LastName,'')) AS CustomerName,
    c.Country,
    CONCAT(COALESCE(e.FirstName,''),'',COALESCE(e.LastName,'')) AS SalesName,
    e.Department,
    o.Sales,
    o.Quantity
    FROM Sales.Orders o
    LEFT JOIN Sales.Products p
    ON o.ProductID=p.ProductID
    LEFT JOIN Sales.Customers c
    ON o.CustomerID=c.CustomerID
    LEFT JOIN Sales.Employees e
    ON o.SalesPersonID=e.EmployeeID
)

-- EXCLUDE DATA FROM COUNTRY USA
CREATE VIEW Sales.V_Order_Details_EU AS (      
    SELECT
    o.OrderID,
    o.OrderDate,
    p.Product,
    p.Category,
    CONCAT(COALESCE(c.FirstName,'') ,' ' ,COALESCE(c.LastName,'')) AS CustomerName,
    c.Country,
    CONCAT(COALESCE(e.FirstName,''),'',COALESCE(e.LastName,'')) AS SalesName,
    e.Department,
    o.Sales,
    o.Quantity
    FROM Sales.Orders o
    LEFT JOIN Sales.Products p
    ON o.ProductID=p.ProductID
    LEFT JOIN Sales.Customers c
    ON o.CustomerID=c.CustomerID
    LEFT JOIN Sales.Employees e
    ON o.SalesPersonID=e.EmployeeID
    WHERE c.Country !='USA'
)