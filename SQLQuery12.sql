CREATE procedure Proce          
as
begin
	declare @k int = (select count (*) from ��������);
	select * from ��������;
	return @k;
end;
go

drop procedure  Proce 


declare @k int = 0;
exec @k = Proce ;
print 'K��-�� �������� = ' + cast(@k as varchar);
go


alter procedure Proce  @p varchar(20), @c int output             
as 
begin
	declare @k int = (select count(*) from ��������);
	print '�a���e���: @p=' + @p +', @c=' + cast(@c as varchar(3)); 
	select * from �������� where �������_��������� = @p;
	set @c = @@rowcount;
	return @k;
end;
go

declare @k int = 0, @r int = 0, @p varchar(20); 
exec @k = Proce @p ='������', @c = @r output; 
print '���-�� �������� �����' + cast(@k as varchar(3)); 
print '���-�� ������ ��������' + cast(@p as varchar(3)) + '=' + cast(@r as varchar(3));
go

alter procedure Proce @p varchar(20)             
as 
begin
	declare @i int = (select count(*) from ��������); 
	select * from �������� where �������_���������  = @p;
end;
go

create table #Ta
(
    �����_�������� int primary key,
    ������������_�������� nvarchar(15),
	�������_��������� varchar(10),
    ������ int
);
insert into #Ta exec Proce @p = '������';
select * from #Ta;
go

create procedure Mistake                       
    @kk int, @tz nvarchar(15), @op nvarchar(10), @kd int
as declare @rc int = 1;
    begin try
        insert into �������� (�����_��������, ������������_��������, �������_���������, ������)
        values (@kk, @tz, @op, @kd);
        return @rc;
    end try
    begin catch
        print '����� ������ : ' + CAST(ERROR_NUMBER() AS VARCHAR(6));
        print '��������� : ' + ERROR_MESSAGE();
        print '������� : ' + CAST(ERROR_SEVERITY() AS VARCHAR(6));
        print '����� : ' + CAST(ERROR_STATE() AS VARCHAR(8));
        print '����� ������ : ' + CAST(ERROR_LINE() AS VARCHAR(8));
        if ERROR_PROCEDURE() IS NOT NULL 
        print '��� ���������: ' + ERROR_PROCEDURE();
        return -1;
    end catch;
go

declare @rc int;  
exec @rc = Mistake    @kk = 55, @tz = '������', @op = '������', @kd = 11;  
print '��� ������ : ' + CAST(@rc AS VARCHAR(3));
go

create procedure REPORT @p nvarchar(10)               
   as  
   declare @rc int = 0;                            
   begin try    
      declare @kr char(20), @t char(300) = ' ';  
      declare ZkKur CURSOR  for 
      select ������������_�������� from  �������� where �������_��������� = @p;
      if not exists ( select ������������_�������� from  �������� where �������_��������� =  @p)
        raiserror('������', 11, 1);
      else 
		open ZkKur;	  
		fetch  ZkKur into @kr;   
		print   '������� �� ��������� ��������:';   
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
        print '������ � ����������' 
        if error_procedure() is not null   
			print '��� ��������� : ' + error_procedure();
        return @rc;
   end catch; 
go

declare @rc int;  
exec @rc = REPORT @p  = '�������';  
print '���������� �������� = ' + cast(@rc as varchar(3)); 
go

create  procedure InsertX                   
     @a int, @b nvarchar(15), @c nvarchar(10), @d int
as declare @rc int = 1;                            
begin try 
    set transaction isolation level SERIALIZABLE;          
    begin tran
    insert into �������� (�����_��������, ������������_��������, �������_���������, ������)
    values (@a, @b, @c, @d)  
    commit tran; 
    return @rc;           
end try
begin catch 
    print '����� ������  : ' + cast(error_number() as varchar(6));
    print '���������     : ' + error_message();
    print '�������       : ' + cast(error_severity()  as varchar(6));
    print '�����         : ' + cast(error_state()   as varchar(8));
    print '����� ������  : ' + cast(error_line()  as varchar(8));
    if error_procedure() is not  null   
                     print '��� ��������� : ' + error_procedure();
     if @@trancount > 0 rollback tran; 
     return -1;	  
end catch;
go

declare @rc int;  
exec @rc = InsertX @a = 745, @b = '�����', @c = '������', @d = 14;   
print '��� ������=' + cast(@rc as varchar(3));  
