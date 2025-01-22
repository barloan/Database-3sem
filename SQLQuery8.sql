use Савицкая_MyBASE;

DECLARE @char char = 'g',
        @varchar varchar = 'г',
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


declare @s float  = (select cast(sum(Стаж) as float) from Работники), 
        @p int,
		@n int,
		@c real
		if @s > 40
		begin
		 select @p = (select cast(count(*) as int) from Работники),
		        @n = (select cast(AVG(Стаж) as int) from Работники)
				
		 set @c = (select cast(count(*) as numeric(8, 3)) from Работники where Стаж > @n)
		 select @s 'Общий стаж', @p 'Колиечство работников', @n 'Средний срок стажа', @c 'Процент работник стажем превышающий средний'
		 end
		 else if  @s > 30 print 'Стаж работников'
         else if @s > 10 print 'Цена заказа между 60 и 100'
        else print 'Цена заказа дешевле 60'
		 

print 'число обработанных строк: ' + CAST(@@ROWCOUNT AS VARCHAR(10));
print 'версия SQL Server: ' + @@VERSION;
print 'системный идентификатор процесса, назначенный сервером текущему подключению: ' + CAST(@@SPID AS VARCHAR(10));
print 'код последней ошибки: ' + CAST(@@ERROR AS VARCHAR(10));
print 'имя сервера: ' + @@SERVERNAME;
print 'уровень вложенности транзакции: ' + CAST(@@TRANCOUNT AS VARCHAR(10));
print 'проверка результата считывания строк результирующего набора: ' + CAST(@@FETCH_STATUS AS VARCHAR(10));
print 'уровень вложенности текущей процедуры: ' + CAST(@@NESTLEVEL AS VARCHAR(10));


declare @t int = 1, @x int = 2, @z float;
 if (@t > @x) set @z = power(sin(@t),2);
 else
 if (@t < @x) set @z = 4 * (@t + @x)
 else 
 if (@t = @x) set @z = 1 - exp(@x - 2);
 print 'z = ' + cast(@z as varchar(10));

 select *from Учет_работы
 declare @id int = '3';
 select ID_работника [номер], Дата [день], datename(weekday, Дата) [День_недели] 
 from Учет_работы where ID_работника = @id;

 declare @d int = (select count(*) from Операции);
 if (select count(*) Операции) > 2
 begin
 print 'Количество операций больше 2';
 print 'Количество = ' + cast(@d as varchar(10));
 end;
 else
 begin
 print 'Количество операций меньше 2';
 print 'Количество = ' + cast(@d as varchar(10));
 end;

 select case 
        when Стаж between 0 and 1 then 'новичок'
		when Стаж between 1 and 3 then 'начинающий'
		when Стаж between 3 and 5 then 'продолжнающий'
		when Стаж between 5 and 8 then 'специалист'
		else 'долгожитель'
		end Стаж, count(*) [Количество]
		from Работники
group by case 
        when Стаж between 0 and 1 then 'новичок'
		when Стаж between 1 and 3 then 'начинающий'
		when Стаж between 3 and 5 then 'продолжнающий'
		when Стаж between 5 and 8 then 'специалист'
		else 'долгожитель'
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
    update dbo.Операции set Оплата = 'не то'
        where Оплата < 15
end try
begin catch
    print ERROR_NUMBER()
    print ERROR_MESSAGE()
    print ERROR_LINE()
    print ERROR_PROCEDURE()
    print ERROR_SEVERITY()
    print ERROR_STATE()
end catch