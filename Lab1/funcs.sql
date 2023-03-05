alter FUNCTION CountTour(@idCountry int)
RETURNS int
AS
-- Returns the stock level for the product.
BEGIN
    DECLARE @res int;
    SELECT @res = count(idTours) 
    FROM Tours
    WHERE Tours.idCountry = @idCountry;
     IF (@res IS NULL)
        SET @res = 0;
    RETURN @res;
END;

go
select dbo.CountTour(2);
go

create function SelectTours (@idCountry int)
	returns nvarchar(255)
	begin
		return (select tourName from Tours where idTours=@idCountry);
	end

select dbo.SelectTours(2);

go

create function SelectNumberOperator (@name nvarchar(150))
	returns nvarchar(255)
	begin
		return (select phoneNumber from Touroperators where name=@name);
	end

select dbo.SelectNumberOperator('Kristina Shkoda');