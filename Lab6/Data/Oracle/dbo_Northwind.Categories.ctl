load data
infile '[Northwind].[dbo].[Categories].dat' "str '<EORD>'"
into table dbo_Northwind.Categories
fields terminated by '<EOFD>'
trailing nullcols
(
CategoryID ,
CategoryName  "DECODE(:CategoryName, CHR(00), ' ', :CategoryName)",
Description CHAR(2000000),
SQLDEVELOPER_CLOB_4  CHAR(2000000) 
)
