declare @num int, @symb char = 'c';    
SET IMPLICIT_TRANSACTIONS  ON   --включение неявной транзакции
CREATE table tablet(A int );     
	INSERT tablet values (1),(2),(3), (4);
	set @num = (select count(*) from tablet);
	print 'количество строк в таблице tablet: ' + cast( @num as varchar(2));
	if @symb = 'c'  commit;                
	else   rollback;                              
SET IMPLICIT_TRANSACTIONS  OFF
	
if  exists (select * from  SYS.OBJECTS where OBJECT_ID= object_id(N'DBO.tablet'))
print 'таблица tablet есть';  
else print 'таблицы tablet нет'

begin try                                               
	begin tran                                      --начало явной транзакции
		delete Операции where Наименование_операции = 'перенос';
		insert Операции values (9, 'моделирование', 'сложный', 18);
		insert Операции values (10, 'проектирование', 'средний', 15);
		commit tran;
end try
begin catch
	print 'ошибка: ' + case
	when error_number() = 2627 and patindex('%РК_Операции%', error_message()) > 0 
	then 'дублирование операции'
	else 'неизвестная ошибка: ' + cast(error_number() as varchar(5)) + ' ' + error_message()
	end;
if @@trancount > 0 rollback tran;
end catch;


declare @point varchar(32);                         --3
begin try
	begin tran
		insert Операции values (11, 'моделирование', 'сложный', 25);
		set @point = 'p1'; save tran @point;
		delete Операции where Оплата = 10;
		set @point = 'p2'; save tran @point;
		insert Операции values (12, 'проектирование', 'средний', 1);
		commit tran;
end try
begin catch
	print 'ошибка: ' + case
	when error_number() = 2627 and patindex('%РК_Операции%', error_message()) > 0 
	then 'дублирование операции'
	else 'неизвестная ошибка: ' + cast(error_number() as varchar(5)) + ' ' + error_message()
	end;
if @@trancount > 0 
begin
	print 'контрольная точка: ' + @point;
	rollback tran @point;
	commit tran;
end;
end catch;

-- A ---                                   --4
set transaction isolation level READ UNCOMMITTED --разрешено все
begin transaction 
	-------------------------- t1 ------------------
select @@SPID, 'insert Операции' 'результат', * from Операции where Номер_операции = 2;
select @@SPID, 'update Учет_работы'  'результат',  Номер_учета, Номер_операции from Учет_работы where Номер_операции = 2;
commit; 
	-------------------------- t2 -----------------
--- B ---	
begin transaction 
select @@SPID
insert Операции values (12, 'проектирование', 'средний', 1);
update Учет_работы set Количество_деталей = 5 where  Номер_операции = 2;
	-------------------------- t1 --------------------
	-------------------------- t2 --------------------
rollback;


-- A ---                                --5
set transaction isolation level READ COMMITTED --не разрешено непотвержденное чтение, неповторяющееся разрешено
begin transaction 
select count(*) from Учет_работы where Номер_операции = 3;
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
select  'update Учет_работы'  'результат', count(*) from Учет_работы where Номер_операции = 3;
commit; 


	
-- A ---                                                       --6
set transaction isolation level REPEATABLE READ --только фантомное чтение
begin transaction 
select Дата from Учет_работы where Номер_операции = 3;
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
select case 
when Дата = '2020-05-05' then 'insert  Учет_работы ' else ' ' 
end 'результат', Дата from Учет_работы where Номер_операции = 3;
commit; 

--- B ---	
begin transaction 	  
	-------------------------- t1 --------------------
insert Учет_работы values (8, 8,  4,  24, '2020-08-07');
commit; 
	-------------------------- t2 --------------------

-- A ---                                                           --7
set transaction isolation level SERIALIZABLE             --все запрещено но долго выполняется
begin transaction   
delete Учет_работы where Номер_операции = 1;  
insert Учет_работы values (17, 5, 5,  101, '2021-07-08');
update Учет_работы set Количество_деталей = '100' where Номер_операции = 2;
select Номер_операции from Учет_работы where Количество_деталей = '55';
          -------------------------- t1 --------------------
commit; 
select Номер_операции from Учет_работы where Количество_деталей = '55';
	-------------------------- t2 ------------------ 
commit; 	

--- B ---	
begin transaction 	  
delete Учет_работы where Номер_операции = 1;  
insert Учет_работы values (17, 5, 5,  101, '2021-07-08');
update Учет_работы set Количество_деталей = '100' where Номер_операции = 2;
select Номер_операции from Учет_работы where Количество_деталей = '55';
          -------------------------- t1 --------------------
commit; 
select Номер_операции from Учет_работы where Количество_деталей = '55';
      -------------------------- t2 --------------------

begin tran							                               --8 вложенная транзакция
	insert Операции values (15, 'стирка', 'средний', 5);
	begin tran
		update Учет_работы set Количество_деталей = 145 where Номер_операции = 15;
		commit;
		if @@trancount > 0 rollback;
select
	(select count(*) from Учет_работы where Номер_операции = 15) 'Учет работы',
	(select count(*) from Операции where Номер_операции = 15) 'Операции';