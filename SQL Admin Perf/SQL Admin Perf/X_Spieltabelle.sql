SELECT      Customers.CustomerID, Customers.CompanyName, Customers.ContactName, Customers.ContactTitle, Customers.City, Customers.Country, Orders.EmployeeID, Orders.OrderDate, Orders.Freight, Orders.ShipName, Orders.ShipCity, Orders.ShipCountry, [Order Details].OrderID, [Order Details].ProductID, 
                   [Order Details].UnitPrice, [Order Details].Quantity, Products.ProductName, Products.UnitsInStock, Employees.LastName, Employees.FirstName, Employees.BirthDate
INTO KU
FROM         Customers INNER JOIN
                   Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN
                   Employees ON Orders.EmployeeID = Employees.EmployeeID INNER JOIN
                   [Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN
                   Products ON [Order Details].ProductID = Products.ProductID


insert into ku
select * from ku

--bis 1,1 MIO DS

alter table ku add id int identity