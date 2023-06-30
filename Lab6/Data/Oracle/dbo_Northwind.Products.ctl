load data
infile '[Northwind].[dbo].[Products].dat' "str '<EORD>'"
into table dbo_Northwind.Products
fields terminated by '<EOFD>'
trailing nullcols
(
ProductID ,
ProductName  "DECODE(:ProductName, CHR(00), ' ', :ProductName)",
SupplierID ,
CategoryID ,
QuantityPerUnit  "DECODE(:QuantityPerUnit, CHR(00), ' ', :QuantityPerUnit)",
UnitPrice "TRANSLATE (:UnitPrice,'1,','1')",
UnitsInStock ,
UnitsOnOrder ,
ReorderLevel ,
Discontinued 
)
