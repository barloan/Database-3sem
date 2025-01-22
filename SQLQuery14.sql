create table TR_Grup                                       
(
    ID int identity, --�����
    STMT varchar(20) check (STMT in ('INS', 'DEL', 'UPD')),
    TRNNAME varchar(50), --��� ��������
    C varchar(300) --�����������
);
go

create trigger TR_Oper 
on �������� after INSERT
as 
begin
    declare @a1 int, @a2 nvarchar(10), @a3 nvarchar(15), @a4 int;
    declare @in varchar(300);
    print '�������� �������';
    select @a1 = [�����_��������], @a2 = [������������_��������], @a3 = [�������_���������], @a4 = [������] from INSERTED;
    set @in = cast(@a1 as varchar(20)) + ' ' + cast(@a2 as varchar(20)) + ' ' + cast(@a3 as varchar(20)) + ' ' + cast(@a4 as varchar(20));
    insert into TR_Grup(STMT, TRNNAME, C) values('INS','TRIG_Ins', @in);
end;
go

insert into �������� (�����_��������, ������������_��������, �������_���������, ������) values (27, '�������������', '�������', 3);
insert into �������� (�����_��������, ������������_��������, �������_���������, ������) values (78, '�������', '�������', 2);
insert into �������� (�����_��������, ������������_��������, �������_���������, ������) values (99, '��������', '������', 1);

select * from TR_Grup;
go
  
create trigger TRIG_Del    
on �������� after INSERT
as 
begin
    declare @a1 int, @a2 nvarchar(10), @a3 nvarchar(15), @a4 int;
    declare @in varchar(300);
    print '�������� ��������';
	select @a1 = [�����_��������], @a2 = [������������_��������], @a3 = [�������_���������], @a4 = [������] from DELETED;
    set @in = cast(@a1 as varchar(20)) + ' ' + cast(@a2 as varchar(20)) + ' ' + cast(@a3 as varchar(20)) + ' ' + cast(@a4 as varchar(20));
    insert into TR_Grup(STMT, TRNNAME, C) values('DEL','TRIG_Del', @in);
end;
go
delete from �������� where �����_�������� = 18;
go

create trigger TRIG_Upd                  
on �������� after UPDATE
as 
begin
    declare @a1 int, @a2 nvarchar(10), @a3 nvarchar(15), @a4 int;
    declare @in varchar(300);
    print '�������� ����������';
    select @a1 = [�����_��������], @a2 = [������������_��������], @a3 = [�������_���������], @a4 = [������] from DELETED;
    set @in = cast(@a1 as varchar(20)) + ' ' + cast(@a2 as varchar(20)) + ' ' + cast(@a3 as varchar(20)) + ' ' + cast(@a4 as varchar(20));
    insert into TR_Grup(STMT, TRNNAME, C) values('UPD','TRIG_Upd', @in);
end;
go

update �������� set ������ = 15 where �����_��������= 16;
go

create trigger TRIG_Grup on �������� after INSERT, DELETE, UPDATE              
as 
begin
    declare @a1 int, @a2 nvarchar(10), @a3 nvarchar(15), @a4 int;
    declare @in varchar(300);
    declare @ins int = (select count(*) from inserted),
            @del int = (select count(*) from deleted); 
    
    if @ins > 0 and @del = 0  
    begin 
        print '�������: INSERT';
		select @a1 = [�����_��������], @a2 = [������������_��������], @a3 = [�������_���������], @a4 = [������] from INSERTED;
		set @in = cast(@a1 as varchar(20)) + ' ' + cast(@a2 as varchar(20)) + ' ' + cast(@a3 as varchar(20)) + ' ' + cast(@a4 as varchar(20));
		insert into TR_Grup(STMT, TRNNAME, C) values('INS','TRIG_Grup', @in);
    end 
    else if @ins = 0 and @del > 0  
    begin 
        print '�������: DELETE';
		select @a1 = [�����_��������], @a2 = [������������_��������], @a3 = [�������_���������], @a4 = [������] from DELETED;
		set @in = cast(@a1 as varchar(20)) + ' ' + cast(@a2 as varchar(20)) + ' ' + cast(@a3 as varchar(20)) + ' ' + cast(@a4 as varchar(20));
		insert into TR_Grup(STMT, TRNNAME, C) values('DEL','TRIG_Grup', @in);
    end 
    else if @ins > 0 and @del > 0  
    begin 
        print '�������: UPDATE'; 
        select @a1 = [�����_��������], @a2 = [������������_��������], @a3 = [�������_���������], @a4 = [������] from INSERTED;
		set @in = cast(@a1 as varchar(20)) + ' ' + cast(@a2 as varchar(20)) + ' ' + cast(@a3 as varchar(20)) + ' ' + cast(@a4 as varchar(20));
        select @a1 = [�����_��������], @a2 = [������������_��������], @a3 = [�������_���������], @a4 = [������] from DELETED;
		set @in = cast(@a1 as varchar(20)) + ' ' + cast(@a2 as varchar(20)) + ' ' + cast(@a3 as varchar(20)) + ' ' + cast(@a4 as varchar(20));
        insert into TR_Grup(STMT, TRNNAME, C) values('UPD','TRIG_Grup', @in);
    end;
end;
go

insert into �������� (�����_��������, ������������_��������, �������_���������, ������) values (22, '�������', '�������', 97);
insert into �������� (�����_��������, ������������_��������, �������_���������, ������) values (23, '��������������', '������', 45);
delete from �������� where �����_�������� = 37;
update �������� set ������ = 5 where �����_�������� = 22;
select * from TR_Grup;
go

create trigger AUD_AFTER_UPDA on �������� after UPDATE             
	as print 'AUD_AFTER_UPDATE_A';
return;
go 

create trigger AUD_AFTER_UPDB on �������� after UPDATE  
	as print 'AUD_AFTER_UPDATE_B';
return;
go  

create trigger AUD_AFTER_UPDC on �������� after UPDATE  
	as print 'AUD_AFTER_UPDATE_C';
return;
go    

select t.name, e.type_desc 
from sys.triggers t join sys.trigger_events e 
	on t.object_id = e.object_id  
		where OBJECT_NAME(t.parent_id) = '��������' and 
									e.type_desc = 'UPDATE';

exec SP_SETTRIGGERORDER @triggername = 'AUD_AFTER_UPDC', 
                        @order = 'First', @stmttype = 'UPDATE';

exec SP_SETTRIGGERORDER @triggername = 'AUD_AFTER_UPDA', 
                        @order = 'Last', @stmttype = 'UPDATE';
go

create trigger Grup_Tran                             
	on �������� after INSERT, DELETE, UPDATE
as 
begin
    declare @c int = (select sum(������) from ��������);
    if (@c > 1000)
    begin
        raiserror('������ �� ����� ���� ������ 1000 ', 10, 1);
        rollback;
    end;
end;
go

update �������� set ������ = 999
							where �����_�������� = 2;
go

create trigger Grup_ISTESD_OF        
	on �������� instead of DELETE
		as raiserror (N'�������� ���������', 10, 1);
return;
go

delete from �������� where �����_�������� = 7;
go

create trigger DDL on database                     
	for DDL_DATABASE_LEVEL_EVENTS as   
begin
    declare @t varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]', 'varchar(50)');
    declare @t1 varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]', 'varchar(50)');
    declare @t2 varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectType)[1]', 'varchar(50)'); 
    if @t1 = '��������' 
    begin
        print '��� �������: ' + @t;
        print '��� �������: ' + @t1;
        print '��� �������: ' + @t2;
        raiserror(N'�������� � �������� �������� ���������', 16, 1);  
        rollback;    
    end;
end;
go

alter table �������� Drop Column ������;