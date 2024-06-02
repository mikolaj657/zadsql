-- 1. Wyświetl nazwy produktów oraz kategorie, do których należą, które były zamawiane przez klientów z miasta "Buenos Aires".
SELECT DISTINCT p.ProductName, c.CategoryName
FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID
JOIN OrderDetails od ON p.ProductID = od.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
JOIN Customers cu ON o.CustomerID = cu.CustomerID
WHERE cu.City = 'Buenos Aires';

-- 2. Znajdź pracowników, którzy zrealizowali zamówienia na produkty z co najmniej sześciu różnych kategorii.
SELECT e.EmployeeID, e.FirstName, e.LastName
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
JOIN Categories c ON p.CategoryID = c.CategoryID
GROUP BY e.EmployeeID, e.FirstName, e.LastName
HAVING COUNT(DISTINCT c.CategoryID) >= 6;

-- 3. Wyświetl listę dostawców, którzy dostarczyli produkty zamówione przez klientów z Ameryki Północnej i Południowej.
SELECT DISTINCT s.SupplierID, s.CompanyName
FROM Suppliers s
JOIN Products p ON s.SupplierID = p.SupplierID
JOIN OrderDetails od ON p.ProductID = od.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
JOIN Customers cu ON o.CustomerID = cu.CustomerID
JOIN Territories t ON cu.TerritoryID = t.TerritoryID
JOIN Regions r ON t.RegionID = r.RegionID
WHERE r.RegionDescription IN ('North America', 'South America');

-- 4. Znajdź klientów, którzy złożyli zamówienia na produkty, których cena jednostkowa przekracza $200.
SELECT DISTINCT cu.CustomerID, cu.CompanyName
FROM Customers cu
JOIN Orders o ON cu.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE p.UnitPrice > 200;

-- 5. Wyświetl średnią wartość zamówienia złożonego przez klientów z każdego miasta w roku 1996.
SELECT cu.City, AVG(od.UnitPrice * od.Quantity) AS AverageOrderValue
FROM Customers cu
JOIN Orders o ON cu.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
WHERE YEAR(o.OrderDate) = 1996
GROUP BY cu.City;