---- Operators
create procedure addOperator
	@name nvarchar(150),
	@phoneNumber nvarchar(11)
as
begin 
insert into Touroperators(name, phoneNumber)
values(@name, @phoneNumber)
end
go

create or alter procedure GetOperators as
begin
	select * from Touroperators
end
go 

create procedure GetOperatorByName 
	@name nvarchar(150)
as
begin
	select * from Touroperators where name = @name;
end
go

create procedure UpdateOperator
	@name nvarchar(150),
	@phoneNumber nvarchar(11)
as
begin
	update Touroperators
	set phoneNumber = @phoneNumber where name = @name
end
go

create procedure DeleteOperator
	@name nvarchar(150)
as 
begin
	delete Touroperators where name = @name;
end
go


---COUNTRIES------------------------------------------------------------
create procedure addCountries
	@country nvarchar(50),
	@visa bit
as
begin 
insert into Countries(country, visa)
values(@country, @visa)
end
go

create procedure getCountries as
begin
	select * from Countries
end
go 

create procedure getCountriesByName 
	@country nvarchar(50)
as
begin
	select * from Countries where country = @country;
end
go

create procedure UpdateCountries
	@country nvarchar(50),
	@visa bit
as
begin
	update Countries
	set visa = @visa where country = @country
end
go

create procedure DeleteCountry
	@country nvarchar(50)
as 
begin
	delete Countries where country = @country;
end
go

---- Tours----------------------------------------
create procedure AddTour
	@idCountry int,
	@idOperator int,
	@tourName nvarchar(255),
	@descr nvarchar(255)
as
begin 
insert into Tours(idCountry,idOperator, tourName, descr)
values(@idCountry,@idOperator, @tourName, @descr)
end
go

create or alter procedure GetTours as
begin
	select * from Tours
end
go 

create procedure GetTourByName 
	@tourName nvarchar(255)
as
begin
	select * from Tours where tourName = @tourName;
end
go

  create or alter procedure UpdateTour
	@idTours int,
	@idCountry int,
	@idOperator int,
	@tourName nvarchar(255),
	@descr nvarchar(255)
as
begin
	update Tours
	set idCountry = @idCountry, idOperator = @idOperator, descr = @descr, tourName = @tourName where idTours = @idTours
end
go

create or alter procedure DeleteTour
	@idTours int
as 
begin
	delete Tours where idTours = @idTours;
end
go


---Vouchers----------------------------
create procedure AddVoucher
	@idTour int,
	@voucherName nvarchar(255),
	@descr nvarchar(255),
	@price money,
	@numberOfPeople int,
	@nutrition bit,
	@accommodation bit,
	@hot bit,
	@discount int
as
begin 
insert into Vouchers(idTour,voucherName, descr, price, numberOfPeople,nutrition, accommodation,hot,discount)
values(@idTour,@voucherName, @descr,@price,@numberOfPeople,@nutrition,@accommodation,@hot,@discount )
end
go

create or alter procedure GetVouchers as
begin
	select * from Vouchers
end
go 

create procedure GetVoucherByName 
	@voucherName nvarchar(255)
as
begin
	select * from Vouchers where voucherName = @voucherName;
end
go

create procedure UpdateVoucher
	@idTour int,
	@voucherName nvarchar(255),
	@descr nvarchar(255),
	@fullPrice money,
	@price money,
	@numberOfPeople int,
	@nutrition bit,
	@accommodation bit,
	@hot bit,
	@discount int
as
begin
	update Vouchers
	set idTour = @idTour, descr = @descr, price = @price, numberOfPeople = @numberOfPeople,
	nutrition= @nutrition, accommodation = @accommodation, hot = @hot, discount = @discount where voucherName = @voucherName
end
go

create procedure DeleteVoucher
	@voucherName nvarchar(255)
as 
begin
	delete Vouchers where voucherName = @voucherName;
end
go

------Orders-------------------------------
create procedure AddOrders
	@idVoucher int,
	@customer nvarchar(255),
	@pay bit
as
begin 
insert into Orders(idVoucher,customer, pay)
values(@idVoucher,@customer, @pay)
end
go

create or alter procedure GetOrders as
begin
	select * from Orders
end
go 

create procedure GetOrderByCustomer
	@customer nvarchar(255)
as
begin
	select * from Orders where customer = @customer;
end
go

create procedure UpdateOrder
	@idVoucher int,
	@customer nvarchar(255),
	@pay bit
as
begin
	update Orders
	set idVoucher = @idVoucher, pay = @pay where customer = @customer
end
go

create procedure DeleteOrder
	@customer nvarchar(255)
as 
begin
	delete Orders where customer = @customer;
end
go


