BEGIN dbo_Northwind.CLOBTOBLOB_sqldeveloper('Categories', 'SQLDEVELOPER_CLOB_4', 'Picture'); END;
/
BEGIN dbo_Northwind.CLOBTOBLOB_sqldeveloper('Employees', 'SQLDEVELOPER_CLOB_15', 'Photo'); END;
/
WHENEVER SQLERROR CONTINUE;
ALTER TABLE dbo_Northwind.Territories ENABLE CONSTRAINT PK_Territories;
ALTER TABLE dbo_Northwind.Products ENABLE CONSTRAINT PK_Products;
ALTER TABLE dbo_Northwind.Orders ENABLE CONSTRAINT PK_Orders;
ALTER TABLE dbo_Northwind.CustomerCustomerDemo ENABLE CONSTRAINT PK_CustomerCustomerDemo;
ALTER TABLE dbo_Northwind.CustomerDemographics ENABLE CONSTRAINT PK_CustomerDemographics;
ALTER TABLE dbo_Northwind.Region ENABLE CONSTRAINT PK_Region;
ALTER TABLE dbo_Northwind.Order_Details ENABLE CONSTRAINT PK_Order_Details;
ALTER TABLE dbo_Northwind.EmployeeTerritories ENABLE CONSTRAINT PK_EmployeeTerritories;
ALTER TABLE dbo_Northwind.Employees ENABLE CONSTRAINT PK_Employees;
ALTER TABLE dbo_Northwind.Suppliers ENABLE CONSTRAINT PK_Suppliers;
ALTER TABLE dbo_Northwind.Categories ENABLE CONSTRAINT PK_Categories;
ALTER TABLE dbo_Northwind.Shippers ENABLE CONSTRAINT PK_Shippers;
ALTER TABLE dbo_Northwind.Customers ENABLE CONSTRAINT PK_Customers;
ALTER TABLE dbo_Northwind.Employees ENABLE CONSTRAINT FK_Employees_Employees;
ALTER TABLE dbo_Northwind.Orders ENABLE CONSTRAINT FK_Orders_Customers;
ALTER TABLE dbo_Northwind.Orders ENABLE CONSTRAINT FK_Orders_Employees;
ALTER TABLE dbo_Northwind.Products ENABLE CONSTRAINT FK_Products_Categories;
ALTER TABLE dbo_Northwind.Products ENABLE CONSTRAINT FK_Products_Suppliers;
ALTER TABLE dbo_Northwind.Order_Details ENABLE CONSTRAINT FK_Order_Details_Orders;
ALTER TABLE dbo_Northwind.CustomerCustomerDemo ENABLE CONSTRAINT FK_CustomerCustomerDemo;
ALTER TABLE dbo_Northwind.CustomerCustomerDemo ENABLE CONSTRAINT FK_CustomerCustomerDemo_Custom;
ALTER TABLE dbo_Northwind.Territories ENABLE CONSTRAINT FK_Territories_Region;
ALTER TABLE dbo_Northwind.EmployeeTerritories ENABLE CONSTRAINT FK_EmployeeTerritories_Employe;
ALTER TABLE dbo_Northwind.Orders ENABLE CONSTRAINT FK_Orders_Shippers;
ALTER TABLE dbo_Northwind.EmployeeTerritories ENABLE CONSTRAINT FK_EmployeeTerritories_Territo;
ALTER TABLE dbo_Northwind.Order_Details ENABLE CONSTRAINT FK_Order_Details_Products;
ALTER TABLE dbo_Northwind.Products ENABLE CONSTRAINT CK_UnitsOnOrder;
ALTER TABLE dbo_Northwind.Products ENABLE CONSTRAINT CK_UnitsInStock;
ALTER TABLE dbo_Northwind.Products ENABLE CONSTRAINT CK_ReorderLevel;
ALTER TABLE dbo_Northwind.Products ENABLE CONSTRAINT CK_Products_UnitPrice;
ALTER TABLE dbo_Northwind.Order_Details ENABLE CONSTRAINT CK_Quantity;
ALTER TABLE dbo_Northwind.Order_Details ENABLE CONSTRAINT CK_Discount;
ALTER TABLE dbo_Northwind.Order_Details ENABLE CONSTRAINT CK_UnitPrice;
ALTER TRIGGER dbo_Northwind.Orders_OrderID_TRG ENABLE;
ALTER TRIGGER dbo_Northwind.Products_ProductID_TRG ENABLE;
ALTER TRIGGER dbo_Northwind.Suppliers_SupplierID_TRG ENABLE;
ALTER TRIGGER dbo_Northwind.Shippers_ShipperID_TRG ENABLE;
ALTER TRIGGER dbo_Northwind.CK_Birthdate_SYSDTRG ENABLE;
ALTER TRIGGER dbo_Northwind.Categories_CategoryID_TRG ENABLE;
ALTER TRIGGER dbo_Northwind.Employees_EmployeeID_TRG ENABLE;