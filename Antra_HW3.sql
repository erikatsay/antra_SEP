-------------------------------------------------------------------------------
-- SEP Full Stack July VA
-- ASSIGNMENT 3 SQL 
-------------------------------------------------------------------------------
-- Write queries for following scenarios
-- Use Northwind database. All questions are based on assumptions described by the 
-- Database Diagram sent to you yesterday. When inserting, make up info if necessary. 
-- Write query for each step. Do not use IDE. BE CAREFUL WHEN DELETING DATA OR DROPPING TABLE.
USE Northwind
GO

-------------------------------------------------------------------------------
-- 1. Create a view named “view_product_order_[your_last_name]”, list all products
-- and total ordered quantity for that product.
-------------------------------------------------------------------------------
-- Create a view
CREATE VIEW view_product_order_Tsay
AS
SELECT p.ProductID, p.ProductName, SUM(od.Quantity) Quantity
FROM Orders o JOIN [Order Details] od ON o.OrderID=od.OrderID JOIN Products p ON od.ProductID=p.ProductID
GROUP BY p.ProductID, p.ProductName

GO

-- Use the VIEW
SELECT * 
FROM view_product_order_Tsay

GO

-------------------------------------------------------------------------------
-- 2. Create a stored procedure “sp_product_order_quantity_[your_last_name]”
-- that accept product id as an input and total quantities of order as output parameter.
-------------------------------------------------------------------------------
-- Create a stored procedure
CREATE PROC sp_product_order_quantity_Tsay
@productID INT,
@totalQuantities INT OUT
AS
BEGIN
SELECT @totalQuantities = SUM(Quantity)
FROM [Order Details]
WHERE ProductID = @productID
GROUP BY ProductID
END

-- Use the stored procedure
BEGIN
DECLARE @test INT
EXEC sp_product_order_quantity_Tsay 23, @test OUT
PRINT @test
END

GO

-------------------------------------------------------------------------------
-- 3. Create a stored procedure “sp_product_order_city_[your_last_name]” that 
-- accept product name as an input and top 5 cities that ordered most that product 
-- combined with the total quantity of that product ordered from that city as output.
-------------------------------------------------------------------------------
-- Create a stored procedure
CREATE PROC sp_product_order_city_Tsay
@productNAme VARCHAR(50)
AS
BEGIN
SELECT TOP 5 o.ShipCity City, SUM(od.Quantity) Quantity
FROM Orders o JOIN [Order Details] od ON o.OrderID=od.OrderID JOIN Products p ON od.ProductID=p.ProductID
WHERE p.ProductName = @productNAme
GROUP BY o.ShipCity
ORDER BY SUM(od.Quantity) DESC
END

GO

-- Use the stored procedure
DECLARE @cities TABLE (CITY VARCHAR(50), Quantity INT)
INSERT INTO @cities EXEC sp_product_order_city_Tsay 'Chai'
SELECT *
FROM @cities

GO

-------------------------------------------------------------------------------
-- 4. Create 2 new tables “people_your_last_name” “city_your_last_name”. City 
-- table has two records: {Id:1, City: Seattle}, {Id:2, City: Green Bay}. People has
-- three records: {id:1, Name: Aaron Rodgers, City: 2}, {id:2, Name: Russell Wilson, 
-- City:1}, {Id: 3, Name: Jody Nelson, City:2}. Remove city of Seattle. If there was
-- anyone from Seattle, put them into a new city “Madison”. Create a view “Packers_your_name”
-- lists all people from Green Bay. If any error occurred, no changes should be made to DB.
-- (after test) Drop both tables and view.
-------------------------------------------------------------------------------
--(1)Create 2 new tables “people_your_last_name” “city_your_last_name”.
CREATE TABLE city_Tsay (
    Id INT Primary Key, 
    City varchar(50)
)

CREATE TABLE people_Tsay (
    Id INT Primary Key, 
    Name VARCHAR(50), 
    City INT FOREIGN KEY REFERENCES city_Tsay(Id)
)

--(2)City table has two records: 
--      {Id:1, City: Seattle}, 
--      {Id:2, City: Green Bay}. 
-- People has three records: 
--      {id:1, Name: Aaron Rodgers, City: 2},
--      {id:2, Name: Russell Wilson, City:1},
--      {Id: 3, Name: Jody Nelson, City:2}.
INSERT INTO city_Tsay VALUES(1, 'Seattle')
INSERT INTO city_Tsay VALUES(2, 'Green Bay')

INSERT INTO people_Tsay VALUES(1, 'Aaron Rodgers', 2)
INSERT INTO people_Tsay VALUES(2, 'Russell Wilson', 1)
INSERT INTO people_Tsay VALUES(3, 'Jody Nelson', 2)

--(3)Remove city of Seattle. If there was
-- anyone from Seattle, put them into a new city “Madison”.
-- 
-- Method 1:
UPDATE city_Tsay
SET City = 'Madison'
WHERE City = 'Seattle'

-- Method 2:
INSERT INTO city_Tsay VALUES(3, 'Madison')

UPDATE people_Tsay
SET City = (
    SELECT Id
    FROM city_Tsay
    WHERE City = 'Madison'
)
FROM people_Tsay p JOIN city_Tsay c ON p.City = c.Id 
WHERE c.City = 'Seattle'

DELETE FROM city_Tsay
WHERE City = 'Seattle'

GO

--(4)Create a view “Packers_your_name” lists all people from Green Bay.
-- If any error occurred, no changes should be made to DB.
CREATE VIEW Packers_Tsay
AS 
SELECT p.NAME
FROM people_Tsay p JOIN city_Tsay c ON p.City=c.Id
WHERE c.City = 'Green Bay'

GO

--(5)Drop both tables and view.
DROP TABLE city_Tsay
DROP TABLE people_Tsay
DROP VIEW Packers_Tsay

GO
-------------------------------------------------------------------------------
-- 5. Create a stored procedure “sp_birthday_employees_[you_last_name]” that
-- creates a new table “birthday_employees_your_last_name” and fill it with all employees
-- that have a birthday on Feb. (Make a screen shot) drop the table. Employee table
-- should not be affected.
-------------------------------------------------------------------------------
-- Create a stored procedure
CREATE PROC sp_birthday_employees_Tsay
AS
BEGIN

SELECT e.BirthDate
INTO birthday_employees_Tsay 
FROM Employees e
WHERE MONTH(e.BirthDate) = 2

DROP TABLE birthday_employees_Tsay
END

GO
-------------------------------------------------------------------------------
-- 6. How do you make sure two tables have the same data?
-- Reference: https://dwgeek.com/quick-best-way-compare-two-tables-sql.html/
-------------------------------------------------------------------------------
-- ANS:
-- Use MINUS.
-- If table1 MINUS table2 returns empty rows and table2 MINUS table1 returns emtpy rows.
-- Then, the two tables are identical.

-------------------------------------------------------------------------------
-- End of this file
-------------------------------------------------------------------------------