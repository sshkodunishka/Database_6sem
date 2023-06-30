load data
infile '[Northwind].[dbo].[EmployeeTerritories].dat' "str '<EORD>'"
into table dbo_Northwind.EmployeeTerritories
fields terminated by '<EOFD>'
trailing nullcols
(
EmployeeID ,
TerritoryID  "DECODE(:TerritoryID, CHR(00), ' ', :TerritoryID)"
)
