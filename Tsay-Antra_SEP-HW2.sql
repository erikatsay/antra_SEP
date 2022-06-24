-------------------------------------------------------------------------------------------------------------------------------------
-- Antra SEP
-- Date: 2022/06/22
-- Name: Ruei-Yu Tsay
-------------------------------------------------------------------------------------------------------------------------------------
USE AdventureWorks2019
GO

-------------------------------------------------------------------------------------------------------------------------------------
-- 1. Write a query that lists the country and province names from person. CountryRegion and person. StateProvince tables. 
--    Join them and produce a result set similar to the following.
--    Country                        Province
SELECT c.Name Country, s.Name Province
FROM person.CountryRegion c JOIN person.StateProvince s ON c.CountryRegionCode = s.CountryRegionCode

-------------------------------------------------------------------------------------------------------------------------------------
-- 2. Write a query that lists the country and province names from person. CountryRegion and person.StateProvince tables 
--    and list the countries filter them by Germany and Canada. Join them and produce a result set similar to the following.
--    Country                        Province
SELECT c.Name Country, s.Name Province
FROM person.CountryRegion c JOIN person.StateProvince s ON c.CountryRegionCode = s.CountryRegionCode
WHERE c.Name IN ('Germany', 'Canada')

-------------------------------------------------------------------------------------------------------------------------------------
--    Using Northwind Database: (Use aliases for all the Joins)
USE Northwind
GO

-- 3. List all Products that has been sold at least once in last 25 years.
SELECT DISTINCT ProductName, o.OrderDate
FROM [Order Details] od JOIN Orders o On od.OrderID = o.OrderID JOIN Products p on od.ProductID=p.ProductID
WHERE DATEDIFF(year, o.OrderDate, GETDATE()) <= 25

-------------------------------------------------------------------------------------------------------------------------------------
-- 4. List top 5 locations (Zip Code) where the products sold most in last 25 years.
-- SELECT TOP 5 
-------------------------------------------------------------------------------------------------------------------------------------
-- 5. List all city names and number of customers in that city.  
SELECT City, count(DISTINCT CustomerID) [Number of customers]
FROM Customers
GROUP BY City
ORDER BY [Number of customers] DESC

-------------------------------------------------------------------------------------------------------------------------------------
-- 6. List city names which have more than 2 customers, and number of customers in that city
SELECT City, count(DISTINCT CustomerID) [Number of customers]
FROM Customers
GROUP BY City
HAVING count(DISTINCT CustomerID)>2
ORDER BY [Number of customers] DESC

-------------------------------------------------------------------------------------------------------------------------------------
-- 7. Display the names of all customers  along with the count of products they bought
SELECT c.CustomerID, c.ContactName, COUNT(od.Quantity) Total
FROM Customers c JOIN Orders o On c.CustomerID = o.CustomerID JOIN [Order Details] od on o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.ContactName
ORDER BY COUNT(od.Quantity) DESC 

-------------------------------------------------------------------------------------------------------------------------------------
-- 8. Display the customer ids who bought more than 100 Products with count of products.
SELECT c.CustomerID, COUNT(od.Quantity) Total
FROM Customers c JOIN Orders o On c.CustomerID = o.CustomerID JOIN [Order Details] od on o.OrderID = od.OrderID
GROUP BY c.CustomerID
HAVING COUNT(od.Quantity) > 100
ORDER BY COUNT(od.Quantity) DESC 

-------------------------------------------------------------------------------------------------------------------------------------
-- 9. List all of the possible ways that suppliers can ship their products. Display the results as below
--    Supplier Company Name                Shipping Company Name
--    ---------------------------------    ----------------------------------
SELECT su.CompanyName [Supplier Company Name], shi.CompanyName [Shipping Company Name]
FROM Suppliers su, Shippers shi
ORDER BY [Supplier Company Name]

-------------------------------------------------------------------------------------------------------------------------------------
-- 10. Display the products order each day. Show Order date and Product Name.
------------------------------------------------------------------------------------------------------------------------------------
-- 11. Displays pairs of employees who have the same job title.
SELECT e1.EmployeeID, e2.EmployeeID
FROM Employees e1, Employees e2
WHERE e1.Title = e2.Title AND e1.EmployeeID != e2.EmployeeID

-------------------------------------------------------------------------------------------------------------------------------------
-- 12. Display all the Managers who have more than 2 employees reporting to them.
SELECT e1.EmployeeID Manager, count(e2.ReportsTo) Report
FROM Employees e1 JOIN Employees e2 ON e1.EmployeeID = e2.ReportsTo
GROUP BY e1.EmployeeID
HAVING count(e2.ReportsTo) > 2

-------------------------------------------------------------------------------------------------------------------------------------
-- 13. Display the customers and suppliers by city. The results should have the following columns
--     City
--     Name
--     Contact Name,
--     Type (Customer or Supplier)
--     All scenarios are based on Database NORTHWIND.
-------------------------------------------------------------------------------------------------------------------------------------
-- 14. List all cities that have both Employees and Customers.
SELECT DISTINCT City
FROM Customers
WHERE City IN 
(
    SELECT DISTINCT City
    FROM Employees
)

-------------------------------------------------------------------------------------------------------------------------------------
-- 15. List all cities that have Customers but no Employee.
--     a. Use sub-query
--     b. Do not use sub-query

--a.
SELECT DISTINCT City
FROM Customers
WHERE City NOT IN
(
    SELECT DISTINCT City
    FROM Employees
)

--b.
SELECT DISTINCT Customers.City
FROM Customers LEFT JOIN Employees ON Customers.City = Employees.City
WHERE Employees.City IS NULL

-------------------------------------------------------------------------------------------------------------------------------------
-- 16. List all products and their total order quantities throughout all orders.
SELECT DISTINCT Customers.City
FROM Customers LEFT JOIN Employees ON Customers.City = Employees.City
WHERE Employees.City IS NULL

-------------------------------------------------------------------------------------------------------------------------------------
-- 17. List all Customer Cities that have at least two customers.
--     a. Use union
--     b. Use sub-query and no union

-------------------------------------------------------------------------------------------------------------------------------------
-- 18. List all Customer Cities that have ordered at least two different kinds of products.

-------------------------------------------------------------------------------------------------------------------------------------
-- 19. List 5 most popular products, their average price, and the customer city that ordered most quantity of it.

-------------------------------------------------------------------------------------------------------------------------------------
-- 20. List one city, if exists, that is the city from where the employee sold most orders (not the product quantity) is, 
--     and also the city of most total quantity of products ordered from. (tip: join  sub-query)

-------------------------------------------------------------------------------------------------------------------------------------
-- 21. How do you remove the duplicates record of a table?

-------------------------------------------------------------------------------------------------------------------------------------
-- The End Of This File
-------------------------------------------------------------------------------------------------------------------------------------