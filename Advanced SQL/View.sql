-- find the running total of sales for each month
CREATE VIEW V_MONTHLY_SUMMARY AS
(
    SELECT
    DATETRUNC(month,OrderDate) OrderMonth,
    SUM(Sales) TotalSales,
    COUNT(OrderID) TotalOrders,
    SUM(Quantity) TotalQuantities
    FROM Sales.Orders
    GROUP BY DATETRUNC(month,OrderDate)
)

SELECT
OrderMonth,
TotalSales,
SUM(TotalSales) OVER (PARTITION BY OrderMonth ORDER BY OrderMonth ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) AS Running_total
FROM V_MONTHLY_SUMMARY


