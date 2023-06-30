load data
infile '[Northwind].[dbo].[CustomerDemographics].dat' "str '<EORD>'"
into table dbo_Northwind.CustomerDemographics
fields terminated by '<EOFD>'
trailing nullcols
(
CustomerTypeID  "DECODE(:CustomerTypeID, CHR(00), ' ', :CustomerTypeID)",
CustomerDesc CHAR(2000000)
)
