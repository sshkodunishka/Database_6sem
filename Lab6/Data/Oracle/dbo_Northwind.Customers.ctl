load data
infile '[Northwind].[dbo].[Customers].dat' "str '<EORD>'"
into table dbo_Northwind.Customers
fields terminated by '<EOFD>'
trailing nullcols
(
CustomerID  "DECODE(:CustomerID, CHR(00), ' ', :CustomerID)",
CompanyName  "DECODE(:CompanyName, CHR(00), ' ', :CompanyName)",
ContactName  "DECODE(:ContactName, CHR(00), ' ', :ContactName)",
ContactTitle  "DECODE(:ContactTitle, CHR(00), ' ', :ContactTitle)",
Address  "DECODE(:Address, CHR(00), ' ', :Address)",
City  "DECODE(:City, CHR(00), ' ', :City)",
Region  "DECODE(:Region, CHR(00), ' ', :Region)",
PostalCode  "DECODE(:PostalCode, CHR(00), ' ', :PostalCode)",
Country  "DECODE(:Country, CHR(00), ' ', :Country)",
Phone  "DECODE(:Phone, CHR(00), ' ', :Phone)",
Fax  "DECODE(:Fax, CHR(00), ' ', :Fax)"
)
