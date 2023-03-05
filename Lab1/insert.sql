exec addOperator @name = 'Anton Borisov', @phoneNumber = '804412563985';
exec addOperator @name = 'Anton Dimitriady', @phoneNumber = '804412563985';
exec addOperator @name = 'Evgeniy Sorogovets', @phoneNumber = '80291569874';
exec addOperator @name = 'Aleksander Waldaycew', @phoneNumber = '80449988774';
exec addOperator @name = 'Ivan Ivanov', @phoneNumber = '80298563245';
exec addOperator @name = 'Anton Tkachov', @phoneNumber = '80445896315';

exec UpdateCountries @country = 'German', @visa = 1;
exec addCountries @country = 'Austria', @visa = 0;
exec addCountries @country = 'England', @visa = 0;
exec addCountries @country = 'Lithuania', @visa = 1;
exec addCountries @country = 'France', @visa = 1;
exec addCountries @country = 'Greece', @visa = 0;

exec AddTour @idCountry = 1, @idOperator = 1, @tourName = 'Cheel', @descr= 'Good trip';
exec AddTour @idCountry = 2, @idOperator = 1005, @tourName = 'Tour in German', @descr= 'Coooooool';
exec AddTour @idCountry = 1005, @idOperator = 1006, @tourName = 'Tour in France', @descr= 'Lovvvvee';
exec AddTour @idCountry = 1004, @idOperator = 1002, @tourName = 'Tour in Lithuania', @descr= 'Bear';
exec AddTour @idCountry = 1006, @idOperator = 1004, @tourName = 'Tour in Greece', @descr= 'Songs';
exec AddTour @idCountry = 1002, @idOperator = 2, @tourName = 'Tour in Austria', @descr= 'Cofee';
exec AddTour @idCountry = 1003, @idOperator = 1003, @tourName = 'Tour in England', @descr= 'Breackfest';

exec AddVoucher @idTour = 1, @voucherName = 'HGJ123', @descr = 'Description of HGJ123', @fullPrice = '1500', @price = '1500', @numberOfPeople = 1, @nutrition = 1, @accommodation = 1, @hot = 1, @discount = 0
exec AddVoucher @idTour = 3, @voucherName = 'KLH745', @descr = 'Description of KLH745', @fullPrice = '3000', @price = '2700', @numberOfPeople = 1, @nutrition = 1, @accommodation = 1, @hot =1 , @discount = 10
exec AddVoucher @idTour = 4, @voucherName = 'BMG523', @descr = 'Description of BMG523', @fullPrice = '5600', @price = '4760', @numberOfPeople = 1, @nutrition = 1, @accommodation = 1, @hot = 0, @discount = 15
exec AddVoucher @idTour = 2, @voucherName = 'GBM856', @descr = 'Description of GBM856', @fullPrice = '8200', @price = '8200', @numberOfPeople = 2, @nutrition = 1, @accommodation = 1, @hot = 0, @discount = 0
exec AddVoucher @idTour = 7, @voucherName = 'YJL856', @descr = 'Description of YJL856', @fullPrice = '4200', @price = '4200', @numberOfPeople = 1, @nutrition = 1, @accommodation = 1, @hot = 1, @discount = 0
exec AddVoucher @idTour = 6, @voucherName = 'WDF856', @descr = 'Description of WDF856', @fullPrice = '1000', @price = '900', @numberOfPeople = 1, @nutrition = 0, @accommodation = 0, @hot = 1, @discount = 10
exec AddVoucher @idTour = 5, @voucherName = 'VNK124', @descr = 'Description of VNK124', @fullPrice = '6500', @price = '6110', @numberOfPeople = 2, @nutrition = 1, @accommodation = 1, @hot = 1, @discount = 6

exec AddOrders 	@idVoucher = 1, @customer = 'Egor Ivanovski', @pay = 1
exec AddOrders 	@idVoucher = 2, @customer = 'Shkoda Kristina', @pay = 1
exec AddOrders 	@idVoucher = 4, @customer = 'Shkoda Tatiana', @pay = 1
exec AddOrders 	@idVoucher = 5, @customer = 'Yury Bogdan', @pay = 1
exec AddOrders 	@idVoucher = 7, @customer = 'Nataly Shkoda', @pay = 1
exec AddOrders 	@idVoucher = 8, @customer = 'Anna Pawlova', @pay = 0
exec AddOrders 	@idVoucher = 8, @customer = 'Artur Muzuk', @pay = 1
exec AddOrders 	@idVoucher = 3, @customer = 'Konstantin Gaew', @pay = 0


exec GetTours;
exec GetOperators;
exec getCountries;
exec GetVouchers;
exec GetOrders;
