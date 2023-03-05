create trigger UpdatePrice
	on Vouchers
	after insert
	as
	begin try
		update Vouchers set price= price * 1.1 
		commit;
	end try
	begin catch
		rollback
		select ('Error') as ErrorMessage;
	end catch
	go		

exec GetVouchers
exec AddVoucher @idTour = 5, @voucherName = 'HJL152', @descr = 'Description of VNK124', @fullPrice = '6500', @price = '6110', @numberOfPeople = 2, @nutrition = 1, @accommodation = 1, @hot = 1, @discount = 6
exec GetVouchers

create trigger DeleteVouchers
	on Tours
	after delete
	as
	begin try
		delete Vouchers where idTour =(select idTours from deleted)
		commit;
	end try
	begin catch
		rollback
		select ('Error') as ErrorMessage;
	end catch
	go	

	create trigger UpdateFullPrice
	on Vouchers
	after insert
	as
	begin try
		update Vouchers set fullPrice= fullPrice * 1.1 
		commit;
	end try
	begin catch
		rollback
		select ('Error') as ErrorMessage;
	end catch
	go	