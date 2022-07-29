-------------------------------------------------------------------------------
-- SEP Full Stack July VA
-- ASSIGNMENT 2 SQL 
-------------------------------------------------------------------------------
USE AdventureWorks2019
GO

-------------------------------------------------------------------------------
-- 1. Write a query that lists the country and province names from person.CountryRegion 
-- and person.StateProvince tables. Join them and produce a result set similar to
-- the following.
--     Country                        Province
-------------------------------------------------------------------------------
SELECT c.Name AS Country, s.Name AS Province
FROM person.CountryRegion AS c JOIN person.StateProvince AS s ON c.CountryRegionCode = s.CountryRegionCode

-------------------------------------------------------------------------------
-- 2. Write a query that lists the country and province names from person.CountryRegion 
-- and person.StateProvince tables and list the countries filter them by Germany
-- and Canada. Join them and produce a result set similar to the following.
--     Country                        Province
-------------------------------------------------------------------------------
SELECT c.Name AS Country, s.Name AS Province
FROM person.CountryRegion AS c JOIN person.StateProvince AS s ON c.CountryRegionCode = s.CountryRegionCode
WHERE c.Name IN ('Germany', 'Canada')

-------------------------------------------------------------------------------
--  Using Northwind Database: (Use aliases for all the Joins)
-------------------------------------------------------------------------------
USE Northwind
GO

-------------------------------------------------------------------------------
-- 3. List all Products that has been sold at least once in last 25 years.
-------------------------------------------------------------------------------
SELECT DISTINCT p.ProductName, o.OrderDate
FROM Orders o JOIN [Order Details] od ON o.OrderID = od.OrderID JOIN Products p ON od.ProductID = p.ProductID
WHERE  DATEDIFF(year, o.RequiredDate, GETDATE()) < 25

-------------------------------------------------------------------------------
-- 4. List top 5 locations (Zip Code) where the products sold most in last 25 years.
-------------------------------------------------------------------------------
SELECT TOP 5 c.City +'('+ c.PostalCode +')' AS locations, SUM(od.Quantity) AS Quantity
FROM Orders o LEFT JOIN [Order Details] od ON o.OrderID=od.OrderID LEFT JOIN Customers c ON o.CustomerID=c.CustomerID
WHERE c.PostalCode IS NOT NULL
GROUP BY c.City, c.PostalCode
ORDER BY SUM(od.Quantity) DESC

-------------------------------------------------------------------------------
-- 5. List all city names and number of customers in that city.     
-------------------------------------------------------------------------------
SELECT City, count(CustomerID) AS [Number Of Customers]
FROM Customers
GROUP BY City

-------------------------------------------------------------------------------
-- 6. List city names which have more than 2 customers, and number of customers
-- in that city
-------------------------------------------------------------------------------
SELECT City, count(CustomerID) AS [Number Of Customers]
FROM Customers
GROUP BY City
HAVING count(CustomerID) > 2

-------------------------------------------------------------------------------
-- 7. Display the names of all customers along with the  count of products they
-- bought
-------------------------------------------------------------------------------
SELECT c.ContactName, ISNULL(SUM(od.Quantity), 0)
FROM Customers c LEFT JOIN Orders o ON c.CustomerID=o.CustomerID LEFT JOIN [Order Details] od ON o.OrderID=od.OrderID
GROUP BY c.ContactName

-------------------------------------------------------------------------------
-- 8. Display the customer ids who bought more than 100 Products with count of products.
-------------------------------------------------------------------------------
SELECT c.CustomerID, SUM(od.Quantity) AS [Count of Products]
FROM Customers c LEFT JOIN Orders o ON c.CustomerID=o.CustomerID LEFT JOIN [Order Details] od ON o.OrderID=od.OrderID
GROUP BY c.CustomerID
HAVING SUM(od.Quantity) > 100
ORDER BY [Count of Products]

-------------------------------------------------------------------------------
-- 9. List all of the possible ways that suppliers can ship their products. Display 
-- the results as below
--     Supplier Company Name                Shipping Company Name
--     ---------------------------------            ----------------------------------
-------------------------------------------------------------------------------
SELECT su.CompanyName, shi.CompanyName
FROM Suppliers su CROSS JOIN Shippers shi 

-------------------------------------------------------------------------------
-- 10. Display the products order each day. Show Order date and Product Name.
-------------------------------------------------------------------------------
SELECT DISTINCT o.OrderDate, p.ProductName
FROM Orders o LEFT JOIN [Order Details] od ON o.OrderID=od.OrderID JOIN Products p ON od.ProductID=p.ProductID
ORDER BY o.OrderDate

-------------------------------------------------------------------------------
-- 11. Displays pairs of employees who have the same job title.
-------------------------------------------------------------------------------
SELECT e1.EmployeeID, e1.FirstName + ' ' + e1.LastName AS [Employee Name], e2.EmployeeID, e2.FirstName + ' ' + e2.LastName AS [Employee Name]
FROM Employees e1 CROSS JOIN Employees e2
WHERE e1.Title = e2.Title AND e1.EmployeeID!=e2.EmployeeID

-------------------------------------------------------------------------------
-- 12. Display all the Managers who have more than 2 employees reporting to them.
-------------------------------------------------------------------------------
SELECT e1.EmployeeID, count(e2.EmployeeID) AS [Number of Employees]
FROM Employees e1 JOIN Employees e2 ON e1.EmployeeID = e2.ReportsTo
GROUP BY e1.EmployeeID
HAVING count(e2.EmployeeID)>2

-------------------------------------------------------------------------------
-- 13. Display the customers and suppliers by city. The results should have the 
-- following columns

-- City
-- Name
-- Contact Name,
-- Type (Customer or Supplier)
-- All scenarios are based on Database NORTHWIND.
-------------------------------------------------------------------------------/
SELECT c.City, c.CompanyName AS 'Name', c.ContactName, 'Customer' AS 'Type'
FROM Customers c
UNION
SELECT s.City, s.CompanyName AS 'Name', s.ContactName, 'Supplier' AS 'Type'
FROM Suppliers s
ORDER BY City

-------------------------------------------------------------------------------
-- 14. List all cities that have both Employees and Customers.
-------------------------------------------------------------------------------
SELECT DISTINCT City
FROM Employees
WHERE City IN (
    SELECT DISTINCT City 
    FROM Customers
)

-------------------------------------------------------------------------------
-- 15. List all cities that have Customers but no Employee.
-------------------------------------------------------------------------------
-- a. Use sub-query
SELECT DISTINCT City
FROM Customers
WHERE City NOT IN (
    SELECT DISTINCT City 
    FROM Employees
)

-- b. Do not use sub-query
SELECT DISTINCT c.City
FROM Customers c LEFT JOIN Employees e ON c.City=e.City
WHERE e.EmployeeID IS NULL

-------------------------------------------------------------------------------
-- 16. List all products and their total order quantities throughout all orders.
-------------------------------------------------------------------------------
SELECT p.ProductID, p.ProductName , SUM(od.Quantity) AS Quantities
FROM Orders o JOIN [Order Details] od ON o.OrderID = od.OrderID JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.ProductID, p.ProductName

-------------------------------------------------------------------------------
-- 17. List all Customer Cities that have at least two customers.
-------------------------------------------------------------------------------
-- a. Use union
-- Hints: We can use having to filter on aggregated columns, for the one using union, you can union the result set where num of customer = 0 and customer = 1
SELECT DISTINCT City
FROM Customers
WHERE City NOT IN(
SELECT c.city
FROM Customers c
GROUP BY c.city
HAVING count(c.CustomerID)=0
UNION
SELECT c.city
FROM Customers c
GROUP BY c.city
HAVING count(c.CustomerID)=1)

-- b. Use no union
SELECT c.city
FROM Customers c
GROUP BY c.city
HAVING count(c.CustomerID) >= 2

-------------------------------------------------------------------------------
-- 18. List all Customer Cities that have ordered at least two different kinds of
-- products.
-------------------------------------------------------------------------------
SELECT c.city, count( DISTINCT od.productID) AS [Number of Kinds]
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.City
HAVING count( DISTINCT od.productID) >= 2
ORDER BY [Number of Kinds]

-------------------------------------------------------------------------------
-- 19. List 5 most popular products, their average price, and the customer city 
-- that ordered most quantity of it.
-------------------------------------------------------------------------------
-- List 5 most popular products
SELECT TOP 5 p.ProductID ,p.ProductName, SUM(od.Quantity) Quantity
FROM Orders o JOIN [Order Details] od ON o.OrderID = od.OrderID JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY SUM(od.Quantity) DESC

-- Their average price
SELECT AVG(dt.UnitPrice)
FROM (SELECT TOP 5 p.ProductID ,p.UnitPrice, SUM(od.Quantity) Quantity
FROM Orders o JOIN [Order Details] od ON o.OrderID = od.OrderID JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.ProductID, p.UnitPrice
ORDER BY SUM(od.Quantity) DESC) dt

-- The customer city that ordered most quantity of it.
SELECT TOP 1 c.City, SUM(od.Quantity)
FROM Orders o JOIN [Order Details] od ON o.OrderID = od.OrderID JOIN Products p ON od.ProductID = p.ProductID JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE p.ProductID IN (SELECT TOP 5 p.ProductID
FROM Orders o JOIN [Order Details] od ON o.OrderID = od.OrderID JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.ProductID
ORDER BY SUM(od.Quantity) DESC)
GROUP BY c.City
ORDER BY SUM(od.Quantity) DESC

-------------------------------------------------------------------------------
-- 20. List one city, if exists, that is the city from where the employee sold most 
-- orders (not the product quantity) is, and also the city of most total quantity
-- of products ordered from. (tip: join  sub-query)
-------------------------------------------------------------------------------
SELECT dt.City
FROM (SELECT TOP 1 e.City
FROM Orders o JOIN Employees e ON o.EmployeeID = e.EmployeeID
GROUP BY e.City
ORDER BY COUNT(o.OrderID) DESC) dt
WHERE dt.City IN (
    SELECT TOP 1 o.ShipCity
    FROM Orders o JOIN [Order Details] od ON o.OrderID=od.OrderID
    GROUP BY o.ShipCity
    ORDER BY SUM(od.Quantity) DESC
)

-------------------------------------------------------------------------------
-- 21. How do you remove the duplicates record of a table?
-- Reference: https://www.sqlservertutorial.net/sql-server-basics/delete-duplicates-sql-server/
-------------------------------------------------------------------------------
-- ANS:

-- Ideas:
-- Use ROW_NUMBER() to number rows that are identical, 
-- then remove the rows that have numbers greater than 1 (The duplicate rows).

-- Example code from Reference Website:
-- WITH cte AS (
--     SELECT 
--         contact_id, 
--         first_name, 
--         last_name, 
--         email, 
--         ROW_NUMBER() OVER (
--             PARTITION BY 
--                 first_name, 
--                 last_name, 
--                 email
--             ORDER BY 
--                 first_name, 
--                 last_name, 
--                 email
--         ) row_num
--      FROM 
--         sales.contacts
-- )
-- DELETE FROM cte
-- WHERE row_num > 1;

-------------------------------------------------------------------------------
-- The end of this file
-------------------------------------------------------------------------------