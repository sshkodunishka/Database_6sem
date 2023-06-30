--Task 1
--ogr2ogr -progress -f "MSSQLSpatial" "MSSQL:server=DESKTOP-UC30CLB\SQLEXPRESS;database=TravelAgency;trusted_connection=true" "C:\univer\semestr_6\DB\labs\lab4\World_Countries.shp" -a_srs "EPSG:4326" -lco PRECISION=NO

--Task 2 Associate imported data with existed code
alter table Countries
	add CountryMap int constraint Country_ID_FK foreign key references world_countries(ogr_fid);

select * from Countries 


select * from dbo.world_countries where country = 'Belarus'
insert into Countries values ('Belarus', 0, 28)

select * from dbo.Countries left join dbo.world_countries on Countries.CountryMap = dbo.world_countries.ogr_fid

--Task 3 Intersection, Union, Difference

alter table Tours
	ADD tourRoute geometry;

UPDATE tours
SET tourRoute = CASE
    WHEN idTours % 3 = 0 THEN geometry::STGeomFromText('LINESTRING(-2 1, 2 1)', 0) -- horizontal every 3
    WHEN idTours % 3 = 1 THEN geometry::STGeomFromText('LINESTRING(1 -2, 1 2)', 0) -- vertical every 3
    ELSE geometry::STGeomFromText('LINESTRING(3 3, 6 6)', 0) -- oblique every 3
    END
WHERE idTours > 0;

select * from Tours

go
DECLARE @tour1Horizontal geometry;
DECLARE @tour2Vertical geometry;
DECLARE @tour3Oblique geometry;

SELECT @tour1Horizontal = tourRoute
FROM tours
WHERE idTours % 3 = 0 

SELECT @tour2Vertical = tourRoute
FROM tours
WHERE idTours % 3 = 1

SELECT @tour3Oblique = tourRoute
FROM tours
WHERE idTours % 3 = 2

PRINT @tour1Horizontal.ToString();
PRINT @tour2Vertical.ToString();
PRINT @tour3Oblique.ToString();

DECLARE @Sresult GEOMETRY;
PRINT 'Intersection between horizontal and vertical';
SELECT @Sresult = @tour1Horizontal.STIntersection(@tour2Vertical);
PRINT @Sresult.STAsText();
PRINT 'Intersection between horizontal and oblique';
SELECT @Sresult = @tour1Horizontal.STIntersection(@tour3Oblique);
PRINT @Sresult.STAsText();
PRINT '--';
PRINT 'Union between horizontal and vertical';
SELECT @Sresult = @tour1Horizontal.STUnion(@tour2Vertical);
PRINT @Sresult.STAsText();
PRINT 'Union between horizontal and oblique';
SELECT @Sresult = @tour1Horizontal.STUnion(@tour3Oblique);
PRINT @Sresult.STAsText();
PRINT '--';
PRINT 'Exception between horizontal and vertical';
SELECT @Sresult = @tour1Horizontal.STDifference(@tour2Vertical);
PRINT @Sresult.STAsText();
PRINT 'Exception between vertical and horizontal';
SELECT @Sresult = @tour2Vertical.STDifference(@tour1Horizontal);
PRINT @Sresult.STAsText();
PRINT 'Exception between horizontal and oblique';
SELECT @Sresult = @tour1Horizontal.STDifference(@tour3Oblique);
PRINT @Sresult.STAsText();
PRINT '--';
go

--Task 4 Distance
go
DECLARE @tour1Horizontal geometry;
DECLARE @tour2Vertical geometry;
DECLARE @tour3Oblique geometry;

SELECT @tour1Horizontal = tourRoute
FROM tours
WHERE idTours % 3 = 0 

SELECT @tour2Vertical = tourRoute
FROM tours
WHERE idTours % 3 = 1

SELECT @tour3Oblique = tourRoute
FROM tours
WHERE idTours % 3 = 2

PRINT @tour1Horizontal.ToString();
PRINT @tour2Vertical.ToString();
PRINT @tour3Oblique.ToString();

DECLARE @Sresult float;
PRINT 'Distance between horizontal and vertical';
SELECT @Sresult = @tour1Horizontal.STDistance(@tour2Vertical);
PRINT @Sresult;
PRINT 'Distance between horizontal and oblique';
SELECT @Sresult = @tour1Horizontal.STDistance(@tour3Oblique);
PRINT @Sresult;
PRINT '--';

--Task5 
go
DECLARE @linestring geometry = 'LINESTRING(0 0, 2 2)';
DECLARE @point geometry = 'POINT(1 1)';
SET @linestring = @linestring.STUnion(@point);
SELECT @linestring.ToString();

--Task6

--2
go
create or alter procedure addCountries
	@country nvarchar(50),
	@visa bit,
	@countryMapId int
as
begin 
insert into Countries(country, visa, CountryMap)
values(@country, @visa, @countryMapId)
end
go

select * from world_countries
exec addCountries 'Algeria', 0, 4
select * from dbo.Countries left join dbo.world_countries on Countries.CountryMap = dbo.world_countries.ogr_fid
delete from Countries where country = 'Algeria'

----3
go
CREATE or ALTER PROCEDURE CalculateTourIntersection 
    @tourId1 int,
    @tourId2 int
AS
BEGIN
    DECLARE @tour1Route geometry;
    DECLARE @tour2Route geometry;
    
    SELECT @tour1Route = tourRoute
    FROM tours
    WHERE idTours = @tourId1;

    SELECT @tour2Route = tourRoute
    FROM tours
    WHERE idTours = @tourId2;
    
    DECLARE @intersection geometry;
    SET @intersection = @tour1Route.STIntersection(@tour2Route);
    
    SELECT @intersection.ToString() AS intersection;
END

EXEC CalculateTourIntersection @tourId1 = 12, @tourId2 = 11;
EXEC CalculateTourIntersection @tourId1 = 12, @tourId2 = 13;

---4
go
CREATE or ALTER PROCEDURE GetTourDistance
    @tourId1 int,
    @tourId2 int
AS
BEGIN
    DECLARE @route1 geometry;
    DECLARE @route2 geometry;
    DECLARE @distance float;
    -- Get the tour routes for the given tour IDs
    SELECT @route1 = tourRoute
    FROM tours
    WHERE idTours = @tourId1;

    SELECT @route2 = tourRoute
    FROM tours
    WHERE idTours = @tourId2;
    -- Calculate the distance between the routes
    SET @distance = @route1.STDistance(@route2);
    -- Print the result
    PRINT @distance
END;

select * from Tours
EXEC GetTourDistance @tourId1 = 12, @tourId2 = 11;
EXEC GetTourDistance @tourId1 = 12, @tourId2 = 13;


--Task 7 Increase search on maps
CREATE SPATIAL INDEX idx_world_countries_geom
ON world_countries (ogr_geometry)
WITH (BOUNDING_BOX = (-180,-90,180,90));

