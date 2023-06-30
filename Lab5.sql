
ALTER TABLE Vouchers
ADD node hierarchyid;

ALTER TABLE Vouchers
ADD position int null

ALTER TABLE Vouchers
			--выдает уровень hierachyid
ADD LEVEL as node.GetLevel() Persisted


select * from Vouchers

update Vouchers
                     --возвращает корень иерархии
set node=hierarchyid::GetRoot(),position=2
where idVoucher =3;

go;


select LEVEL=node from Vouchers

insert into Vouchers

create or alter procedure gethierarchyById @id hierarchyid
as
begin
																			--является ли потомком
select node.ToString()[string], node.GetLevel()[level], * from Vouchers where node.IsDescendantOf(@id) = 1;
end;

select * from Vouchers

exec gethierarchyById '/';
exec gethierarchyById '/2/';
go;


select * from Vouchers

create or alter procedure insertValue
@hid hierarchyid, @idTour int, @voucherName nvarchar(255), @descr nvarchar(255), @price money, @numberOfPeople int, @nutrition bit, @accommodation bit, @hot bit, @discount int
as
begin
declare @LCV hierarchyid
begin transaction
		select @LCV=max(node)
		from Vouchers where
		node.GetAncestor(1)=@HID;
		INSERT INTO Vouchers(node,idTour,voucherName,descr, price, numberOfPeople, nutrition, accommodation, hot, discount) 
		values(@HID.GetDescendant(@LCV,NULL),@idTour,@voucherName,@descr,@price,@numberOfPeople,@nutrition,@accommodation,@hot,@discount);
					commit;
end;


exec insertValue '/2/2/', 1,'AAA111','iusghskhvskdlm', 500 , 2, 1, 1, 0, 15

create or alter procedure MoveBranche  @oldparent hierarchyid,
							@newparent hierarchyid
as begin
DECLARE children_cursor CURSOR FOR  
	SELECT node FROM Vouchers
		WHERE node.GetAncestor(1) = @OldParent; 
		
DECLARE @ChildId hierarchyid;  
	OPEN children_cursor  
		FETCH NEXT FROM children_cursor INTO @ChildId;	
		
WHILE @@FETCH_STATUS = 0  
BEGIN  
START:  
    DECLARE @NewId hierarchyid;  
    SELECT @NewId = @NewParent.GetDescendant(MAX(node), NULL)  
    FROM Vouchers WHERE node.GetAncestor(1) = @NewParent;  

    UPDATE Vouchers
							--перемещает узел от старого к новому
    SET node = node.GetReparentedValue(@ChildId, @NewId)  
		WHERE node.IsDescendantOf(@ChildId) = 1;  

    IF @@error <> 0 GOTO START  
        FETCH NEXT FROM children_cursor INTO @ChildId;  
END  
CLOSE children_cursor;  
DEALLOCATE children_cursor;  
end;


exec gethierarchyById '/';
exec MoveBranche '/2/', '/1/';