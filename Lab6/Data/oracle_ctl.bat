set NLS_DATE_FORMAT=Mon dd YYYY HH:mi:ssAM
REM set NLS_TIMESTAMP_FORMAT=Mon dd YYYY HH:mi:ffAM
REM set NLS_LANGUAGE=<insert the language of your database here e.g., US7ASCII>
sqlplus dbo_Northwind/dbo_Northwind@orcl < pre_load.sql
sqlldr dbo_Northwind/dbo_Northwind@orcl control=Oracle\dbo_Northwind.Orders.ctl log=dbo_Northwind.Orders.log
sqlldr dbo_Northwind/dbo_Northwind@orcl control=Oracle\dbo_Northwind.Products.ctl log=dbo_Northwind.Products.log
sqlldr dbo_Northwind/dbo_Northwind@orcl control=Oracle\dbo_Northwind.Order_Details.ctl log=dbo_Northwind.Order_Details.log
sqlldr dbo_Northwind/dbo_Northwind@orcl control=Oracle\dbo_Northwind.CustomerCustomerDemo.ctl log=dbo_Northwind.CustomerCustomerDemo.log
sqlldr dbo_Northwind/dbo_Northwind@orcl control=Oracle\dbo_Northwind.CustomerDemographics.ctl log=dbo_Northwind.CustomerDemographics.log
sqlldr dbo_Northwind/dbo_Northwind@orcl control=Oracle\dbo_Northwind.Region.ctl log=dbo_Northwind.Region.log
sqlldr dbo_Northwind/dbo_Northwind@orcl control=Oracle\dbo_Northwind.Territories.ctl log=dbo_Northwind.Territories.log
sqlldr dbo_Northwind/dbo_Northwind@orcl control=Oracle\dbo_Northwind.EmployeeTerritories.ctl log=dbo_Northwind.EmployeeTerritories.log
sqlldr dbo_Northwind/dbo_Northwind@orcl control=Oracle\dbo_Northwind.Employees.ctl log=dbo_Northwind.Employees.log
sqlldr dbo_Northwind/dbo_Northwind@orcl control=Oracle\dbo_Northwind.Categories.ctl log=dbo_Northwind.Categories.log
sqlldr dbo_Northwind/dbo_Northwind@orcl control=Oracle\dbo_Northwind.Customers.ctl log=dbo_Northwind.Customers.log
sqlldr dbo_Northwind/dbo_Northwind@orcl control=Oracle\dbo_Northwind.Shippers.ctl log=dbo_Northwind.Shippers.log
sqlldr dbo_Northwind/dbo_Northwind@orcl control=Oracle\dbo_Northwind.Suppliers.ctl log=dbo_Northwind.Suppliers.log
sqlplus dbo_Northwind/dbo_Northwind@orcl < post_load.sql
