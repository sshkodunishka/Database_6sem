SELECT CASE SERVERPROPERTY('IsIntegratedSecurityOnly')
WHEN 1 THEN 'Windows Authentication'
WHEN 0 THEN 'Mixed Mode Authentication'
END as [Authentication Mode]

--2. Создать уч. записи, роли, юзеры, привилегии
create Login KristinaSh with password='1111';--логин
create user Kristina_User for login KristinaSh;--юзер, привяз. к логину
create user JustUser without login;--юзер
create role user_role;--роль

-- привилегии
grant select, insert, update, delete on orders to user_role;
revoke update on orders from user_role;
EXEC sp_addrolemember @rolename = 'user_role', @membername = 'Kristina_User';

--3. Продем. заимствование прав для процедуры
create login John with password = 'john';
create login Jane with password = 'jane';
create user John for login John;
create user Jane for login Jane;

exec sp_addrolemember 'db_datareader', 'John';
exec sp_addrolemember 'db_ddladmin', 'John';
deny select on orders to Jane;
go
create procedure Us_GetOrders
with execute as 'John'
as select * from Orders;

alter authorization on Us_GetOrders to John;
grant execute on Us_GetOrders to Jane;

--
setuser 'Jane';
exec Us_GetOrders;
select * from orders;
setuser;

---- С Е Р В Е Р Н Ы Й А У Д И Т ----

--4. Создать серверный аудит
use master;

create server audit CAudit
to file(
filepath = 'C:\univer\semestr_6\DB\labs\Lab10',
maxsize = 0 mb,
max_rollover_files = 0,
reserve_disk_space = off
) with ( queue_delay = 1000, on_failure = continue);

create server audit PAudit to application_log;
create server audit AAudit to security_log;

--
select * from sys.server_audits;


--5. Задать для серв. аудита спецификации
create server audit specification ServerAuditSpecification1
for server audit CAudit
add (database_change_group)
with (state=on)

--6. Запустить серверный аудит, показать журнал аудита
alter server audit CAudit with (state=on);

create database primer;
drop database primer;

select statement from fn_get_audit_file('C:\univer\semestr_6\DB\labs\Lab10\*', null, null);

---- А У Д И Т Б А З Ы Д А Н Н Ы Х ----

--7. Создать объекты аудита БД + спец + запуск + журнал
create database audit specification DatabaseAuditSpecification1
for server audit CAudit
add (insert on dbo.Countries by dbo)
with (state=on);

select * from Countries;
delete from Countries where country='AAA';
insert into Countries(country, visa, CountryMap) values ('AAA', 1, 5);

select statement from fn_get_audit_file('C:\univer\semestr_6\DB\labs\Lab10\*', null, null);


--10. Остановить адуит БД и сервера
alter server audit CAudit with (state=off);
alter server audit PAudit with (state=off);
alter server audit AAudit with (state=off);


---- Ш И Ф Р О В А Н И Е ----

--11. Создать ассим. ключ шифрования
use TravelAgency;
create asymmetric key SampleAKey
with algorithm = rsa_2048
encryption by password = 'Pas45!!~~';

--12. Зашифр и расш- данные при пом ключа
declare @plaintext nvarchar(21);
declare @ciphertext nvarchar (256);

set @plaintext = 'this is a sample text';
print @plaintext;

set @ciphertext = EncryptByAsymKey(AsymKey_ID('SampleAKey'), @plaintext);
print @ciphertext;

set @plaintext = DecryptByAsymKey(AsymKey_ID('SampleAKey'), @ciphertext, N'Pas45!!~~');
print @plaintext;


--13. Создать сертификат
create certificate SampleCert
encryption by password = N'pa$$W0RD'
with subject = N'Sample Certificate',
expiry_date = N'2024-02-02';


--14. Зашифр и расшиф данные при пом. сертификата.
declare @plain_text nvarchar(58);
set @plain_text = 'this is certificate encryption text';
print @plain_text;

declare @cipher_text nvarchar(256);
set @cipher_text = EncryptByCert(Cert_ID('SampleCert'), @plain_text);
print @cipher_text;

set @plain_text = CAST(DecryptByCert(Cert_ID('SampleCert'), @cipher_text, N'pa$$W0RD') as nvarchar(58));
print @plain_text;


--15. Создать симм. ключ шифрования
create symmetric key SKey
with algorithm = AES_256
encryption by password = N'PA$$W0RD';

open symmetric key SKey
decryption by password = N'PA$$W0RD';

create symmetric key SData
with algorithm = AES_256
encryption by symmetric key SKey;

open symmetric key SData
decryption by symmetric key SKey;


--16. Зашифр и расшифр данные при пом. ключа
declare @plain_tex nvarchar(512);
set @plain_tex = 'open the symmetric key with which to encrypt the data';
print @plain_tex;

declare @cipher_tex nvarchar(1024);
set @cipher_tex = EncryptByKey(Key_GUID('SData'), @plain_tex);
print @cipher_tex;

set @plain_tex = CAST(DecryptByKey(@cipher_tex) as nvarchar(512));
print @plain_tex;

close symmetric key SData;
close symmetric key SKey;

--17. Продем. прозрачное шифрование БД
use master;
create master key encryption by password = 'p@$$wOrd';

create certificate LabCert
with subject = 'certificate to encrypt Lab10 DB ',
expiry_date = '2024-02-02';


use TravelAgency;
create database encryption key
with algorithm = AES_256
encryption by server certificate LabCert;
go
SELECT @@VERSION;
alter database Sklad
set encryption on;
go

--удалить шифрование из БД
alter database Sklad
set encryption off;
go


--18. Продем. хеширование (MD2, MD4, MD5, SHA1, SHA2)

--
select HashBytes('SHA1', 'open the symmetric key with which to encrypt the data');
select HashBytes('MD4', 'open the symmetric key with which to encrypt the data');


--19. Продем применение ЭЦП при помощи сертификата.

--подписывает текст сертификатом и возвращает подпись
select * from sys. certificates;
select SIGNBYCERT(258, N'univer', N'pa$$W0RD') as ЭЦП;--сертификат
--0 - изменены, 1 - не изменены
select VERIFYSIGNEDBYCERT(258, 'univer', 0x0106000000000009010000003C3F43E10E6AB971BC1D92B51ED83521C4A4EB53);

select * from sys. asymmetric_keys;
select SIGNBYASymKey(256, N'univer', N'Pas45!!~~') as ЭЦП;--ас.ключ
select VERIFYSIGNEDBYASYMKEY(256, N'univer', 0x010005020400000064D5BBEF754A4D34A96DC40BC7DF7ED949E2C77F42DC3AA52828CE375FABEB106224D619BEBD037BBC5A912A50451DA29EA7E39C62504BC6379835B49412B1D49A586C03F0993E2293F03982D5B41E33F9F290D6A4487D7098E8758C728796272F35A366080F24DCB7DD2FF22C86EC92E800781E418D8E9F77E11F1EB10F9FDC59518993D59BFE0081274367169841876C224CD1EDAF1EC0D228FF39B6922CEFD384C308B702C012C936C3984BCBB0D85383585C41EDBB19D020E116261004527C1056FF465C30D77471247ADCBDBA1FDF6FABB4BEA1A37D56086D017B170CD584B92C01A676349E7A0713A62D85A54EFF24315FDD7E3ADE9D89052B89133948);


--20. Сделать резервную копию необходимых ключей и сертификатов.
backup certificate SampleCert
to file = N'C:\univer\semestr_6\DB\labs\Lab10\BackupSampleCert.cer'
with private key(
file = N'C:\univer\semestr_6\DB\labs\Lab10\BackupSampleCert.pvk',
encryption by password = N'pa$$W0RD',
decryption by password = N'pa$$W0RD');

use master;
BACKUP MASTER KEY TO FILE = 'C:\univer\semestr_6\DB\labs\Lab10\BackupMasterKey.key'
ENCRYPTION BY PASSWORD = 'p@$$wOrd';