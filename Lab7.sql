
select * from Report


--TASK1
 --созд таблицу Report, сод. 2 столбца - id, XML-столбец

create table Report (
id INTEGER primary key identity(1,1),
xml_column XML
);




--TASK2
-- созд процедуру генер XML, д.вкл д-е из 3 соед таблиц, пром.итоги, штамп t

drop procedure generateXML

create procedure generateXML
as
declare @x XML
set @x = (Select t.tourName[назание тура], v.voucherName[название путевки], tro.name[имя оператора], 
					GETDATE() [дата]
	from Vouchers v join Tours t on v.idTour = t.idTours
	join Touroperators tro on tro.idOperator = t.idOperator
	FOR XML AUTO);
	SELECT @x
go

execute generateXML;




--TASK3
-- созд процедуру вставки этого XML в таблицу Report

create procedure InsertInReport
as
DECLARE  @s XML  
SET @s = (Select	t.tourName[назание тура], v.voucherName[название путевки], tro.name[имя оператора], 
					GETDATE() [дата]
		from Vouchers v join Tours t on v.idTour = t.idTours
	join Touroperators tro on tro.idOperator = t.idOperator
for xml raw);
--FOR XML AUTO, TYPE);
insert into Report values(@s);
go
  
  execute InsertInReport
  select * from Report;




--TASK4
-- созд. индекс над XML-столбцом в Report
create primary xml index My_XML_Index on Report(xml_column)

create xml index Second_XML_Index on Report(xml_column)
using xml index My_XML_Index for path




--TASK5
-- созд процедуру извл знач из XML-столбца в Report (параметр - знач атрибута/эл)

select * from Report

create procedure SelectData
as
select xml_column.query('/row')
	as[xml_column]
	from Report
	for xml auto, type;
go
execute SelectData



select xml_column.value('(/row/@дата)[1]', 'nvarchar(max)')
	as[xml_column]
	from Report
	for xml auto, type;






