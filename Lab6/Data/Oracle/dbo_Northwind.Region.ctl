load data
infile '[Northwind].[dbo].[Region].dat' "str '<EORD>'"
into table dbo_Northwind.Region
fields terminated by '<EOFD>'
trailing nullcols
(
RegionID ,
RegionDescription  "DECODE(:RegionDescription, CHR(00), ' ', :RegionDescription)"
)
