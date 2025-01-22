create function Count (@f int) returns int     
as begin declare @rc int = 0;
set @rc=(select count(ID_���������) 
	from �������� k join ����_������ pk
		on k.�����_�������� =pk.�����_�������� where �����_����� = @f);
return @rc;
end;
go

drop function Count


declare @f int = dbo.count(1);
print '�������� � ������� ����� = 1' + cast(@f as varchar(4));
go

select �����_��������, dbo.count(�����_��������) from ��������;
go



create function func_kurs (@pr nvarchar(10)) returns char(300) 
as
begin  
declare @kr char(20);  
declare @k varchar(300) = '�������� ';  
declare ZkKurs cursor local
for select �����_�������� from �������� where �������_��������� = @pr;
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

select �����_��������, dbo.func_kurs(�����_��������) from ��������;
go

create function fun_inner (@g int, @p date) returns table       
as return
select g.�����_��������, g.������������_��������, �.����
	from  �������� g left outer join ����_������ �
		on g.�����_�������� = �.�����_��������
		where g.�����_�������� = isnull (@g, g.�����_��������) 
		and
			�.����  = isnull (@p, �.����);
go

select * from dbo.fun_inner(NULL, NULL);
select * from dbo.fun_inner(3, NULL);
select * from dbo.fun_inner(NULL, '2020-05-05');
select * from dbo.fun_inner(2, '2020-09-08');
go

create function fun (@k int) returns int  
as
begin
	declare @rc int = (select count(*) from ��������
	where �����_�������� = isnull (@k, �����_��������));
	return @rc;
end;
go

select �����_��������, dbo.fun(�����_��������) [��������] from ��������
select dbo.fun (NULL) [��������]
go
