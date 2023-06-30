load data
infile '[Northwind].[dbo].[Territories].dat' "str '<EORD>'"
into table dbo_Northwind.Territories
fields terminated by '<EOFD>'
trailing nullcols
(
TerritoryID  "DECODE(:TerritoryID, CHR(00), ' ', :TerritoryID)",
TerritoryDescription  "DECODE(:TerritoryDescription, CHR(00), ' ', :TerritoryDescription)",
RegionID 
)
