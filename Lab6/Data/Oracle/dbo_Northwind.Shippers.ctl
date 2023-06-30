load data
infile '[Northwind].[dbo].[Shippers].dat' "str '<EORD>'"
into table dbo_Northwind.Shippers
fields terminated by '<EOFD>'
trailing nullcols
(
ShipperID ,
CompanyName  "DECODE(:CompanyName, CHR(00), ' ', :CompanyName)",
Phone  "DECODE(:Phone, CHR(00), ' ', :Phone)"
)
