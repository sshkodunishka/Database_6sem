load data
infile '[Northwind].[dbo].[Orders].dat' "str '<EORD>'"
into table dbo_Northwind.Orders
fields terminated by '<EOFD>'
trailing nullcols
(
OrderID ,
CustomerID  "DECODE(:CustomerID, CHR(00), ' ', :CustomerID)",
EmployeeID ,
OrderDate "TO_TIMESTAMP(:OrderDate, 'yyyy-mm-dd HH24:mi:ss.ff3')",
RequiredDate "TO_TIMESTAMP(:RequiredDate, 'yyyy-mm-dd HH24:mi:ss.ff3')",
ShippedDate "TO_TIMESTAMP(:ShippedDate, 'yyyy-mm-dd HH24:mi:ss.ff3')",
ShipVia ,
Freight "TRANSLATE (:Freight,'1,','1')",
ShipName  "DECODE(:ShipName, CHR(00), ' ', :ShipName)",
ShipAddress  "DECODE(:ShipAddress, CHR(00), ' ', :ShipAddress)",
ShipCity  "DECODE(:ShipCity, CHR(00), ' ', :ShipCity)",
ShipRegion  "DECODE(:ShipRegion, CHR(00), ' ', :ShipRegion)",
ShipPostalCode  "DECODE(:ShipPostalCode, CHR(00), ' ', :ShipPostalCode)",
ShipCountry  "DECODE(:ShipCountry, CHR(00), ' ', :ShipCountry)"
)
