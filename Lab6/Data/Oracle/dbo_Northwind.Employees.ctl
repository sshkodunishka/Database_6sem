load data
infile '[Northwind].[dbo].[Employees].dat' "str '<EORD>'"
into table dbo_Northwind.Employees
fields terminated by '<EOFD>'
trailing nullcols
(
EmployeeID ,
LastName  "DECODE(:LastName, CHR(00), ' ', :LastName)",
FirstName  "DECODE(:FirstName, CHR(00), ' ', :FirstName)",
Title  "DECODE(:Title, CHR(00), ' ', :Title)",
TitleOfCourtesy  "DECODE(:TitleOfCourtesy, CHR(00), ' ', :TitleOfCourtesy)",
BirthDate "TO_TIMESTAMP(:BirthDate, 'yyyy-mm-dd HH24:mi:ss.ff3')",
HireDate "TO_TIMESTAMP(:HireDate, 'yyyy-mm-dd HH24:mi:ss.ff3')",
Address  "DECODE(:Address, CHR(00), ' ', :Address)",
City  "DECODE(:City, CHR(00), ' ', :City)",
Region  "DECODE(:Region, CHR(00), ' ', :Region)",
PostalCode  "DECODE(:PostalCode, CHR(00), ' ', :PostalCode)",
Country  "DECODE(:Country, CHR(00), ' ', :Country)",
HomePhone  "DECODE(:HomePhone, CHR(00), ' ', :HomePhone)",
Extension  "DECODE(:Extension, CHR(00), ' ', :Extension)",
SQLDEVELOPER_CLOB_15  CHAR(2000000) ,
Notes CHAR(2000000),
ReportsTo ,
PhotoPath CHAR(510) "DECODE(:PhotoPath, CHR(00), ' ', :PhotoPath)"
)
