create table TR_Grup                                       
(
    ID int identity, --номер
    STMT varchar(20) check (STMT in ('INS', 'DEL', 'UPD')),
    TRNNAME varchar(50), --имя триггера
    C varchar(300) --комментарий
);
go

create trigger TR_Oper 
on Операции after INSERT
as 
begin
    declare @a1 int, @a2 nvarchar(10), @a3 nvarchar(15), @a4 int;
    declare @in varchar(300);
    print 'Операция вставки';
    select @a1 = [Номер_операции], @a2 = [Наименование_операции], @a3 = [Признак_сложности], @a4 = [Оплата] from INSERTED;
    set @in = cast(@a1 as varchar(20)) + ' ' + cast(@a2 as varchar(20)) + ' ' + cast(@a3 as varchar(20)) + ' ' + cast(@a4 as varchar(20));
    insert into TR_Grup(STMT, TRNNAME, C) values('INS','TRIG_Ins', @in);
end;
go

insert into Операции (Номер_операции, Наименование_операции, Признак_сложности, Оплата) values (27, 'трансформация', 'средний', 3);
insert into Операции (Номер_операции, Наименование_операции, Признак_сложности, Оплата) values (78, 'перебор', 'сложный', 2);
insert into Операции (Номер_операции, Наименование_операции, Признак_сложности, Оплата) values (99, 'выкладка', 'легкий', 1);

select * from TR_Grup;
go
  
create trigger TRIG_Del    
on Операции after INSERT
as 
begin
    declare @a1 int, @a2 nvarchar(10), @a3 nvarchar(15), @a4 int;
    declare @in varchar(300);
    print 'Операция удаления';
	select @a1 = [Номер_операции], @a2 = [Наименование_операции], @a3 = [Признак_сложности], @a4 = [Оплата] from DELETED;
    set @in = cast(@a1 as varchar(20)) + ' ' + cast(@a2 as varchar(20)) + ' ' + cast(@a3 as varchar(20)) + ' ' + cast(@a4 as varchar(20));
    insert into TR_Grup(STMT, TRNNAME, C) values('DEL','TRIG_Del', @in);
end;
go
delete from Операции where Номер_операции = 18;
go

create trigger TRIG_Upd                  
on Операции after UPDATE
as 
begin
    declare @a1 int, @a2 nvarchar(10), @a3 nvarchar(15), @a4 int;
    declare @in varchar(300);
    print 'Операция обновления';
    select @a1 = [Номер_операции], @a2 = [Наименование_операции], @a3 = [Признак_сложности], @a4 = [Оплата] from DELETED;
    set @in = cast(@a1 as varchar(20)) + ' ' + cast(@a2 as varchar(20)) + ' ' + cast(@a3 as varchar(20)) + ' ' + cast(@a4 as varchar(20));
    insert into TR_Grup(STMT, TRNNAME, C) values('UPD','TRIG_Upd', @in);
end;
go

update Операции set Оплата = 15 where Номер_операции= 16;
go

create trigger TRIG_Grup on Операции after INSERT, DELETE, UPDATE              
as 
begin
    declare @a1 int, @a2 nvarchar(10), @a3 nvarchar(15), @a4 int;
    declare @in varchar(300);
    declare @ins int = (select count(*) from inserted),
            @del int = (select count(*) from deleted); 
    
    if @ins > 0 and @del = 0  
    begin 
        print 'Событие: INSERT';
		select @a1 = [Номер_операции], @a2 = [Наименование_операции], @a3 = [Признак_сложности], @a4 = [Оплата] from INSERTED;
		set @in = cast(@a1 as varchar(20)) + ' ' + cast(@a2 as varchar(20)) + ' ' + cast(@a3 as varchar(20)) + ' ' + cast(@a4 as varchar(20));
		insert into TR_Grup(STMT, TRNNAME, C) values('INS','TRIG_Grup', @in);
    end 
    else if @ins = 0 and @del > 0  
    begin 
        print 'Событие: DELETE';
		select @a1 = [Номер_операции], @a2 = [Наименование_операции], @a3 = [Признак_сложности], @a4 = [Оплата] from DELETED;
		set @in = cast(@a1 as varchar(20)) + ' ' + cast(@a2 as varchar(20)) + ' ' + cast(@a3 as varchar(20)) + ' ' + cast(@a4 as varchar(20));
		insert into TR_Grup(STMT, TRNNAME, C) values('DEL','TRIG_Grup', @in);
    end 
    else if @ins > 0 and @del > 0  
    begin 
        print 'Событие: UPDATE'; 
        select @a1 = [Номер_операции], @a2 = [Наименование_операции], @a3 = [Признак_сложности], @a4 = [Оплата] from INSERTED;
		set @in = cast(@a1 as varchar(20)) + ' ' + cast(@a2 as varchar(20)) + ' ' + cast(@a3 as varchar(20)) + ' ' + cast(@a4 as varchar(20));
        select @a1 = [Номер_операции], @a2 = [Наименование_операции], @a3 = [Признак_сложности], @a4 = [Оплата] from DELETED;
		set @in = cast(@a1 as varchar(20)) + ' ' + cast(@a2 as varchar(20)) + ' ' + cast(@a3 as varchar(20)) + ' ' + cast(@a4 as varchar(20));
        insert into TR_Grup(STMT, TRNNAME, C) values('UPD','TRIG_Grup', @in);
    end;
end;
go

insert into Операции (Номер_операции, Наименование_операции, Признак_сложности, Оплата) values (22, 'стройка', 'средний', 97);
insert into Операции (Номер_операции, Наименование_операции, Признак_сложности, Оплата) values (23, 'преобразование', 'легкий', 45);
delete from Операции where Номер_операции = 37;
update Операции set Оплата = 5 where Номер_операции = 22;
select * from TR_Grup;
go

create trigger AUD_AFTER_UPDA on Операции after UPDATE             
	as print 'AUD_AFTER_UPDATE_A';
return;
go 

create trigger AUD_AFTER_UPDB on Операции after UPDATE  
	as print 'AUD_AFTER_UPDATE_B';
return;
go  

create trigger AUD_AFTER_UPDC on Операции after UPDATE  
	as print 'AUD_AFTER_UPDATE_C';
return;
go    

select t.name, e.type_desc 
from sys.triggers t join sys.trigger_events e 
	on t.object_id = e.object_id  
		where OBJECT_NAME(t.parent_id) = 'Операции' and 
									e.type_desc = 'UPDATE';

exec SP_SETTRIGGERORDER @triggername = 'AUD_AFTER_UPDC', 
                        @order = 'First', @stmttype = 'UPDATE';

exec SP_SETTRIGGERORDER @triggername = 'AUD_AFTER_UPDA', 
                        @order = 'Last', @stmttype = 'UPDATE';
go

create trigger Grup_Tran                             
	on Операции after INSERT, DELETE, UPDATE
as 
begin
    declare @c int = (select sum(Оплата) from Операции);
    if (@c > 1000)
    begin
        raiserror('Оплата не может быть больше 1000 ', 10, 1);
        rollback;
    end;
end;
go

update Операции set Оплата = 999
							where Номер_операции = 2;
go

create trigger Grup_ISTESD_OF        
	on Операции instead of DELETE
		as raiserror (N'Удаление запрещено', 10, 1);
return;
go

delete from Операции where Номер_операции = 7;
go

create trigger DDL on database                     
	for DDL_DATABASE_LEVEL_EVENTS as   
begin
    declare @t varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]', 'varchar(50)');
    declare @t1 varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]', 'varchar(50)');
    declare @t2 varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectType)[1]', 'varchar(50)'); 
    if @t1 = 'Операции' 
    begin
        print 'Тип события: ' + @t;
        print 'Имя объекта: ' + @t1;
        print 'Тип объекта: ' + @t2;
        raiserror(N'операции с таблицей Операции запрещены', 16, 1);  
        rollback;    
    end;
end;
go

alter table Операции Drop Column Оплата;