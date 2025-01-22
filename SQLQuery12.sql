CREATE procedure Proce          
as
begin
	declare @k int = (select count (*) from Операции);
	select * from Операции;
	return @k;
end;
go

drop procedure  Proce 


declare @k int = 0;
exec @k = Proce ;
print 'Kол-во операций = ' + cast(@k as varchar);
go


alter procedure Proce  @p varchar(20), @c int output             
as 
begin
	declare @k int = (select count(*) from Операции);
	print 'пaрамeтры: @p=' + @p +', @c=' + cast(@c as varchar(3)); 
	select * from Операции where Признак_сложности = @p;
	set @c = @@rowcount;
	return @k;
end;
go

declare @k int = 0, @r int = 0, @p varchar(20); 
exec @k = Proce @p ='легкий', @c = @r output; 
print 'кол-во операций всего' + cast(@k as varchar(3)); 
print 'кол-во легких операций' + cast(@p as varchar(3)) + '=' + cast(@r as varchar(3));
go

alter procedure Proce @p varchar(20)             
as 
begin
	declare @i int = (select count(*) from Операции); 
	select * from Операции where Признак_сложности  = @p;
end;
go

create table #Ta
(
    Номер_операции int primary key,
    Наименование_операции nvarchar(15),
	Признак_сложности varchar(10),
    Оплата int
);
insert into #Ta exec Proce @p = 'легкий';
select * from #Ta;
go

create procedure Mistake                       
    @kk int, @tz nvarchar(15), @op nvarchar(10), @kd int
as declare @rc int = 1;
    begin try
        insert into Операции (Номер_операции, Наименование_операции, Признак_сложности, Оплата)
        values (@kk, @tz, @op, @kd);
        return @rc;
    end try
    begin catch
        print 'номер ошибки : ' + CAST(ERROR_NUMBER() AS VARCHAR(6));
        print 'сообщение : ' + ERROR_MESSAGE();
        print 'уровень : ' + CAST(ERROR_SEVERITY() AS VARCHAR(6));
        print 'метка : ' + CAST(ERROR_STATE() AS VARCHAR(8));
        print 'номер строки : ' + CAST(ERROR_LINE() AS VARCHAR(8));
        if ERROR_PROCEDURE() IS NOT NULL 
        print 'имя процедуры: ' + ERROR_PROCEDURE();
        return -1;
    end catch;
go

declare @rc int;  
exec @rc = Mistake    @kk = 55, @tz = 'глажка', @op = 'легкий', @kd = 11;  
print 'код ошибки : ' + CAST(@rc AS VARCHAR(3));
go

create procedure REPORT @p nvarchar(10)               
   as  
   declare @rc int = 0;                            
   begin try    
      declare @kr char(20), @t char(300) = ' ';  
      declare ZkKur CURSOR  for 
      select Наименование_операции from  Операции where Признак_сложности = @p;
      if not exists ( select Наименование_операции from  Операции where Признак_сложности =  @p)
        raiserror('ошибка', 11, 1);
      else 
		open ZkKur;	  
		fetch  ZkKur into @kr;   
		print   'Среднии по сложности операции:';   
		while @@fetch_status = 0                                     
		begin 
		set @t = rtrim(@kr) + ', ' + @t;  
        set @rc = @rc + 1;       
        fetch  ZkKur into @kr; 
     end;   
print @t;        
close  ZkKur;
   return @rc;
   end try  
   begin catch              
        print 'ошибка в параметрах' 
        if error_procedure() is not null   
			print 'имя процедуры : ' + error_procedure();
        return @rc;
   end catch; 
go

declare @rc int;  
exec @rc = REPORT @p  = 'средний';  
print 'количество операций = ' + cast(@rc as varchar(3)); 
go

create  procedure InsertX                   
     @a int, @b nvarchar(15), @c nvarchar(10), @d int
as declare @rc int = 1;                            
begin try 
    set transaction isolation level SERIALIZABLE;          
    begin tran
    insert into Операции (Номер_операции, Наименование_операции, Признак_сложности, Оплата)
    values (@a, @b, @c, @d)  
    commit tran; 
    return @rc;           
end try
begin catch 
    print 'номер ошибки  : ' + cast(error_number() as varchar(6));
    print 'сообщение     : ' + error_message();
    print 'уровень       : ' + cast(error_severity()  as varchar(6));
    print 'метка         : ' + cast(error_state()   as varchar(8));
    print 'номер строки  : ' + cast(error_line()  as varchar(8));
    if error_procedure() is not  null   
                     print 'имя процедуры : ' + error_procedure();
     if @@trancount > 0 rollback tran; 
     return -1;	  
end catch;
go

declare @rc int;  
exec @rc = InsertX @a = 745, @b = 'мойка', @c = 'легкий', @d = 14;   
print 'код ошибки=' + cast(@rc as varchar(3));  
