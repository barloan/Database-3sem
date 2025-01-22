create function Count (@f int) returns int     
as begin declare @rc int = 0;
set @rc=(select count(ID_работника) 
	from Операции k join Учет_работы pk
		on k.Номер_операции =pk.Номер_операции where Номер_учета = @f);
return @rc;
end;
go

drop function Count


declare @f int = dbo.count(1);
print 'Операции с номером учета = 1' + cast(@f as varchar(4));
go

select Номер_операции, dbo.count(Номер_операции) from Операции;
go



create function func_kurs (@pr nvarchar(10)) returns char(300) 
as
begin  
declare @kr char(20);  
declare @k varchar(300) = 'Операции ';  
declare ZkKurs cursor local
for select Номер_операции from Операции where Признак_сложности = @pr;
open ZkKurs;	  
fetch  ZkKurs into @kr;   	 
while @@fetch_status = 0                                     
begin 
	set @k = @k + ', ' + rtrim(@kr);         
	FETCH  ZkKurs into @kr; 
end;    
return @k;
end;  
go

select Номер_операции, dbo.func_kurs(Номер_операции) from Операции;
go

create function fun_inner (@g int, @p date) returns table       
as return
select g.Номер_операции, g.Наименование_операции, р.Дата
	from  Операции g left outer join Учет_работы р
		on g.Номер_операции = р.Номер_операции
		where g.Номер_операции = isnull (@g, g.Номер_операции) 
		and
			р.Дата  = isnull (@p, р.Дата);
go

select * from dbo.fun_inner(NULL, NULL);
select * from dbo.fun_inner(3, NULL);
select * from dbo.fun_inner(NULL, '2020-05-05');
select * from dbo.fun_inner(2, '2020-09-08');
go

create function fun (@k int) returns int  
as
begin
	declare @rc int = (select count(*) from Операции
	where Номер_операции = isnull (@k, Номер_операции));
	return @rc;
end;
go

select Номер_операции, dbo.fun(Номер_операции) [Операция] from Операции
select dbo.fun (NULL) [Операции]
go
