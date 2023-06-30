load data
infile '[Northwind].[dbo].[Order Details].dat' "str '<EORD>'"
into table dbo_Northwind.Order_Details
fields terminated by '<EOFD>'
trailing nullcols
(
OrderID ,
ProductID ,
UnitPrice "TRANSLATE (:UnitPrice,'1,','1')",
Quantity ,
Discount 
)
