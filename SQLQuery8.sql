use ��������_MyBASE;

DECLARE @char char = 'g',
        @varchar varchar = '�',
		@datetime datetime,
		@time time,
		@int int,
		@smallint smallint,
		@tinyint tinyint,
		@numeric numeric(12,5);


set @datetime = '2024-11-11 11:34:45';
select @time = '11:34:45', 
        @int = 15,
		@smallint = 0,
		@tinyint = 0,
		@numeric = 456789.45612;


select 
       @varchar AS varchar_value,
       @datetime AS datetime_value,
       @time AS time_value;


print 'int value: ' + cast(@int AS varchar);
print 'smallint value: ' + cast(@smallint AS varchar);
print 'tinyint value: ' + cast(@tinyint AS varchar);
print 'numeric value: ' + cast(@numeric AS varchar);


declare @s float  = (select cast(sum(����) as float) from ���������), 
        @p int,
		@n int,
		@c real
		if @s > 40
		begin
		 select @p = (select cast(count(*) as int) from ���������),
		        @n = (select cast(AVG(����) as int) from ���������)
				
		 set @c = (select cast(count(*) as numeric(8, 3)) from ��������� where ���� > @n)
		 select @s '����� ����', @p '���������� ����������', @n '������� ���� �����', @c '������� �������� ������ ����������� �������'
		 end
		 else if  @s > 30 print '���� ����������'
         else if @s > 10 print '���� ������ ����� 60 � 100'
        else print '���� ������ ������� 60'
		 

print '����� ������������ �����: ' + CAST(@@ROWCOUNT AS VARCHAR(10));
print '������ SQL Server: ' + @@VERSION;
print '��������� ������������� ��������, ����������� �������� �������� �����������: ' + CAST(@@SPID AS VARCHAR(10));
print '��� ��������� ������: ' + CAST(@@ERROR AS VARCHAR(10));
print '��� �������: ' + @@SERVERNAME;
print '������� ����������� ����������: ' + CAST(@@TRANCOUNT AS VARCHAR(10));
print '�������� ���������� ���������� ����� ��������������� ������: ' + CAST(@@FETCH_STATUS AS VARCHAR(10));
print '������� ����������� ������� ���������: ' + CAST(@@NESTLEVEL AS VARCHAR(10));


declare @t int = 1, @x int = 2, @z float;
 if (@t > @x) set @z = power(sin(@t),2);
 else
 if (@t < @x) set @z = 4 * (@t + @x)
 else 
 if (@t = @x) set @z = 1 - exp(@x - 2);
 print 'z = ' + cast(@z as varchar(10));

 select *from ����_������
 declare @id int = '3';
 select ID_��������� [�����], ���� [����], datename(weekday, ����) [����_������] 
 from ����_������ where ID_��������� = @id;

 declare @d int = (select count(*) from ��������);
 if (select count(*) ��������) > 2
 begin
 print '���������� �������� ������ 2';
 print '���������� = ' + cast(@d as varchar(10));
 end;
 else
 begin
 print '���������� �������� ������ 2';
 print '���������� = ' + cast(@d as varchar(10));
 end;

 select case 
        when ���� between 0 and 1 then '�������'
		when ���� between 1 and 3 then '����������'
		when ���� between 3 and 5 then '�������������'
		when ���� between 5 and 8 then '����������'
		else '�����������'
		end ����, count(*) [����������]
		from ���������
group by case 
        when ���� between 0 and 1 then '�������'
		when ���� between 1 and 3 then '����������'
		when ���� between 3 and 5 then '�������������'
		when ���� between 5 and 8 then '����������'
		else '�����������'
		end;


create table #fruits
 (
 apple int,
 pear int,
 cherry varchar(10)
 );
 declare @W int = 0;
 while @W < 50
 begin
 insert #fruits(apple, pear, cherry)
 values (floor(10*rand()), floor(20*rand()), 'stroka' + cast(@W as varchar(10)));
 if (@W % 10 = 0)
  print @W;
  set @W = @W + 1;
  end;
  select *from #fruits
  drop table #fruits; 


declare @pp int = 1;
print  @pp+2
print  @pp -2
return 
print  @pp + 7


begin try
    update dbo.�������� set ������ = '�� ��'
        where ������ < 15
end try
begin catch
    print ERROR_NUMBER()
    print ERROR_MESSAGE()
    print ERROR_LINE()
    print ERROR_PROCEDURE()
    print ERROR_SEVERITY()
    print ERROR_STATE()
end catch