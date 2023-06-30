SELECT dbo.WriteTextFile(
'text1', 'D:\\univer\\Line.txt', 1)
GO

go
declare @Route CustomRoute
	set @Route = 'sad asd'
	select @Route.ToString()
go

go
declare @Route CustomRoute
	set @Route = 'sa@d asd'
	select @Route.ToString()
go