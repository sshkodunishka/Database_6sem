load data
infile '[Northwind].[dbo].[Suppliers].dat' "str '<EORD>'"
into table dbo_Northwind.Suppliers
fields terminated by '<EOFD>'
trailing nullcols
(
SupplierID ,
CompanyName  "DECODE(:CompanyName, CHR(00), ' ', :CompanyName)",
ContactName  "DECODE(:ContactName, CHR(00), ' ', :ContactName)",
ContactTitle  "DECODE(:ContactTitle, CHR(00), ' ', :ContactTitle)",
Address  "DECODE(:Address, CHR(00), ' ', :Address)",
City  "DECODE(:City, CHR(00), ' ', :City)",
Region  "DECODE(:Region, CHR(00), ' ', :Region)",
PostalCode  "DECODE(:PostalCode, CHR(00), ' ', :PostalCode)",
Country  "DECODE(:Country, CHR(00), ' ', :Country)",
Phone  "DECODE(:Phone, CHR(00), ' ', :Phone)",
Fax  "DECODE(:Fax, CHR(00), ' ', :Fax)",
HomePage CHAR(2000000)
)
