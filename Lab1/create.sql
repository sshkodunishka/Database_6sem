create database TravelAgency;
use TravelAgency;

create  table Tours(
idTours int IDENTITY PRIMARY KEY,
idCountry int,
idOperator int,
tourName nvarchar(255),
descr nvarchar(255),
FOREIGN KEY(idCountry) REFERENCES Countries(idCountry),
FOREIGN KEY(idOperator) REFERENCES Touroperators(idOperator)
)

create table Vouchers(
idVoucher int IDENTITY PRIMARY KEY,
idTour int,
voucherName nvarchar(255),
descr nvarchar(255),
fullPrice money,
price money,
numberOfPeople int,
nutrition bit,
accommodation bit,
hot bit,
discount int,
FOREIGN KEY(idTour) REFERENCES Tours(idTours)
)

create table Orders(
idOrder int IDENTITY PRIMARY KEY,
idVoucher int,
customer nvarchar(255),
pay bit,
FOREIGN KEY(idVoucher) REFERENCES Vouchers(idVoucher),
)

create table Countries(
idCountry int IDENTITY PRIMARY KEY,
country nvarchar(50),
visa bit
);

alter table Touroperators(
idOperator int IDENTITY PRIMARY KEY,
name nvarchar(150),
phoneNumber nvarchar(11),
);