load data
infile '[Northwind].[dbo].[CustomerCustomerDemo].dat' "str '<EORD>'"
into table dbo_Northwind.CustomerCustomerDemo
fields terminated by '<EOFD>'
trailing nullcols
(
CustomerID  "DECODE(:CustomerID, CHR(00), ' ', :CustomerID)",
CustomerTypeID  "DECODE(:CustomerTypeID, CHR(00), ' ', :CustomerTypeID)"
)
