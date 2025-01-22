declare @num int, @symb char = 'c';    
SET IMPLICIT_TRANSACTIONS  ON   --��������� ������� ����������
CREATE table tablet(A int );     
	INSERT tablet values (1),(2),(3), (4);
	set @num = (select count(*) from tablet);
	print '���������� ����� � ������� tablet: ' + cast( @num as varchar(2));
	if @symb = 'c'  commit;                
	else   rollback;                              
SET IMPLICIT_TRANSACTIONS  OFF
	
if  exists (select * from  SYS.OBJECTS where OBJECT_ID= object_id(N'DBO.tablet'))
print '������� tablet ����';  
else print '������� tablet ���'

begin try                                               
	begin tran                                      --������ ����� ����������
		delete �������� where ������������_�������� = '�������';
		insert �������� values (9, '�������������', '�������', 18);
		insert �������� values (10, '��������������', '�������', 15);
		commit tran;
end try
begin catch
	print '������: ' + case
	when error_number() = 2627 and patindex('%��_��������%', error_message()) > 0 
	then '������������ ��������'
	else '����������� ������: ' + cast(error_number() as varchar(5)) + ' ' + error_message()
	end;
if @@trancount > 0 rollback tran;
end catch;


declare @point varchar(32);                         --3
begin try
	begin tran
		insert �������� values (11, '�������������', '�������', 25);
		set @point = 'p1'; save tran @point;
		delete �������� where ������ = 10;
		set @point = 'p2'; save tran @point;
		insert �������� values (12, '��������������', '�������', 1);
		commit tran;
end try
begin catch
	print '������: ' + case
	when error_number() = 2627 and patindex('%��_��������%', error_message()) > 0 
	then '������������ ��������'
	else '����������� ������: ' + cast(error_number() as varchar(5)) + ' ' + error_message()
	end;
if @@trancount > 0 
begin
	print '����������� �����: ' + @point;
	rollback tran @point;
	commit tran;
end;
end catch;

-- A ---                                   --4
set transaction isolation level READ UNCOMMITTED --��������� ���
begin transaction 
	-------------------------- t1 ------------------
select @@SPID, 'insert ��������' '���������', * from �������� where �����_�������� = 2;
select @@SPID, 'update ����_������'  '���������',  �����_�����, �����_�������� from ����_������ where �����_�������� = 2;
commit; 
	-------------------------- t2 -----------------
--- B ---	
begin transaction 
select @@SPID
insert �������� values (12, '��������������', '�������', 1);
update ����_������ set ����������_������� = 5 where  �����_�������� = 2;
	-------------------------- t1 --------------------
	-------------------------- t2 --------------------
rollback;


-- A ---                                --5
set transaction isolation level READ COMMITTED --�� ��������� ��������������� ������, ��������������� ���������
begin transaction 
select count(*) from ����_������ where �����_�������� = 3;
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
select  'update ����_������'  '���������', count(*) from ����_������ where �����_�������� = 3;
commit; 


	
-- A ---                                                       --6
set transaction isolation level REPEATABLE READ --������ ��������� ������
begin transaction 
select ���� from ����_������ where �����_�������� = 3;
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
select case 
when ���� = '2020-05-05' then 'insert  ����_������ ' else ' ' 
end '���������', ���� from ����_������ where �����_�������� = 3;
commit; 

--- B ---	
begin transaction 	  
	-------------------------- t1 --------------------
insert ����_������ values (8, 8,  4,  24, '2020-08-07');
commit; 
	-------------------------- t2 --------------------

-- A ---                                                           --7
set transaction isolation level SERIALIZABLE             --��� ��������� �� ����� �����������
begin transaction   
delete ����_������ where �����_�������� = 1;  
insert ����_������ values (17, 5, 5,  101, '2021-07-08');
update ����_������ set ����������_������� = '100' where �����_�������� = 2;
select �����_�������� from ����_������ where ����������_������� = '55';
          -------------------------- t1 --------------------
commit; 
select �����_�������� from ����_������ where ����������_������� = '55';
	-------------------------- t2 ------------------ 
commit; 	

--- B ---	
begin transaction 	  
delete ����_������ where �����_�������� = 1;  
insert ����_������ values (17, 5, 5,  101, '2021-07-08');
update ����_������ set ����������_������� = '100' where �����_�������� = 2;
select �����_�������� from ����_������ where ����������_������� = '55';
          -------------------------- t1 --------------------
commit; 
select �����_�������� from ����_������ where ����������_������� = '55';
      -------------------------- t2 --------------------

begin tran							                               --8 ��������� ����������
	insert �������� values (15, '������', '�������', 5);
	begin tran
		update ����_������ set ����������_������� = 145 where �����_�������� = 15;
		commit;
		if @@trancount > 0 rollback;
select
	(select count(*) from ����_������ where �����_�������� = 15) '���� ������',
	(select count(*) from �������� where �����_�������� = 15) '��������';