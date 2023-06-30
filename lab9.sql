

select * from orders;
select * from Vouchers;


--1.����� �������
		select	distinct(Vouchers.idVoucher), Vouchers.voucherName as name_of_voucher, 
			COUNT(orders.idVoucher) OVER (partition by orders.idVoucher)
			as number_voucher from orders
			join Vouchers ON Orders.idVoucher = Vouchers.idVoucher;

		
--����� � ����� ������� ������� (%)
SELECT distinct(o.idVoucher),v.voucherName,
	count(*) over () as general_count, 
	COUNT(*) OVER (PARTITION BY o.idVoucher) AS personal_count, 
	COUNT(*) OVER (PARTITION BY o.idVoucher) * 100.0 / COUNT(*) OVER () AS OrderRatio
FROM Orders as o join Vouchers as v on v.idVoucher = o.idVoucher



--����� � ��������� ������� �������

WITH OrderCounts AS (
  SELECT v.voucherName, o.idVoucher, COUNT(*) AS OrderCount
  FROM Orders as o join Vouchers as v on o.idVoucher = v.idVoucher
  GROUP BY o.idVoucher, v.voucherName
), MaxOrderCounts AS (
  SELECT idVoucher, MAX(OrderCount) OVER () AS MaxOrderCount
  FROM OrderCounts
)
SELECT OrderCounts.voucherName, OrderCounts.idVoucher,OrderCount, MaxOrderCount, CAST(OrderCount AS float) / MaxOrderCount AS Ratio
FROM OrderCounts
JOIN MaxOrderCounts ON OrderCounts.idVoucher = MaxOrderCounts.idVoucher;

--3.��������� ����������� ������� �� ��������.
--ROW_NUMBER ��������� ���������� �������������� � ������, ������� � 1 � � ����� 1

SELECT *
FROM (
  SELECT *, ROW_NUMBER() OVER (ORDER BY idOrder) AS RowNum
  FROM Orders
) AS T
WHERE T.RowNum <= 4;
--���������
DECLARE @PageSize INT = 2; -- ���������� ����� �� ��������
DECLARE @PageNumber INT = 1; -- ����� ������� ��������

WITH OrderedOrders AS (
    SELECT *, ROW_NUMBER() OVER (ORDER BY idOrder) AS RowNum
    FROM Orders
)
SELECT *
FROM OrderedOrders
WHERE RowNum BETWEEN (@PageNumber - 1) * @PageSize + 1 AND @PageNumber * @PageSize;

-- ������� �� ��������� ��������
SET @PageNumber = @PageNumber + 1;

WITH OrderedOrders AS (
    SELECT *, ROW_NUMBER() OVER (ORDER BY idOrder) AS RowNum
    FROM Orders
)
SELECT *
FROM OrderedOrders
WHERE RowNum BETWEEN (@PageNumber - 1) * @PageSize + 1 AND @PageNumber * @PageSize;

SELECT * FROM Orders ORDER BY idOrder OFFSET 2 ROWS FETCH NEXT 2 ROWS ONLY;
--------------------
SELECT *
FROM (
    SELECT *, ROW_NUMBER() OVER (ORDER BY idOrder) AS rownum
    FROM Orders
) AS T
WHERE rownum BETWEEN 1 AND 2;

--����������
create or alter procedure str(@str int, @number int)
as
begin
SELECT *
FROM (
  SELECT 
    ROW_NUMBER() OVER (ORDER BY idOrder) AS rownum, 
    *
  FROM Orders
) AS t
WHERE t.rownum BETWEEN (@str-1)*@number+1 AND @number*@str; -- ��� ������ ������ ��������
end;
EXECUTE [str]3, 2;

--4. ROW_NUMBER() ��� �������� ���������� (� partition ���� ��� ���� �����������)

	select count(*) from orders;
	select * from orders;


	delete x from (
	  select *, rn=row_number() over (partition by idOrder, idVoucher, customer, pay order by idOrder)
	  from orders
	) x
	where rn > 1;




--5.������� ��� ������� ������� 

SELECT Orders.customer, COUNT(*) AS times_visited, Countries.country
FROM Orders
JOIN (
  SELECT Vouchers.idVoucher, Tours.idCountry
  FROM Countries
  LEFT JOIN Tours ON Countries.idCountry = Tours.idCountry
  LEFT JOIN Vouchers ON Tours.idTours = Vouchers.idTour
  LEFT JOIN Orders ON Vouchers.idVoucher = Orders.idVoucher
  WHERE Countries.idCountry IN (
    SELECT TOP 3 idCountry
    FROM Countries
    ORDER BY idCountry
  )
  GROUP BY Vouchers.idVoucher, Tours.idCountry
  HAVING COUNT(*) > 0
) AS subquery ON Orders.idVoucher = subquery.idVoucher
JOIN Countries ON subquery.idCountry = Countries.idCountry
GROUP BY Orders.customer, Countries.country
ORDER BY times_visited DESC;


--������������

SELECT idVoucher, customer, ROW_NUMBER() OVER (ORDER BY customer) AS RowNum
FROM Orders;