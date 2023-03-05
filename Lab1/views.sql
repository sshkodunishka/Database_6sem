create or alter view CustomerVoucher as
select O.customer, V.voucherName
from Orders as O join Vouchers as V
on O.idVoucher = V.idVoucher;
go

create view NumberPeopleTour as
select T.tourName, V.numberOfPeople
from Vouchers V join Tours as T
on V.idTour = T.idTours
go

create view CuctomerOperator as
select O.customer, TR.name, TR.phoneNumber, T.tourName, T.descr, V.price
from Orders as O join Vouchers as V 
on O.idVoucher = V.idVoucher
join Tours as T
on V.idTour = T.idTours
join Touroperators as TR
on T.idOperator = TR.idOperator
go

select * from CustomerVoucher;
select * from NumberPeopleTour;
select * from CuctomerOperator;
