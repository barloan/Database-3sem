use ��������_MyBASE

declare @nomer int, @operation nvarchar(30), @t char(300) = '';
declare Kursor cursor for select �����_��������, ������������_�������� from ��������;
 
open Kursor;
fetch Kursor into @nomer, @operation;
print '��������'; 
while @@fetch_status = 0
	begin
	set @t = rtrim(@nomer) + ',' + rtrim(@operation);
	fetch Kursor into @nomer, @operation;
	end;
	print @t;
	close Kursor;
	deallocate Kursor;


declare @nomer1 int, @operation1 nvarchar(30);
declare LocalKurs cursor local 
	for select �����_��������, ������������_�������� from ��������;
open LocalKurs;
fetch LocalKurs into @nomer1,@operation1;
print '1.' + cast(@nomer1 as varchar) + ' ' + cast(@operation1 as varchar);
go
declare @nomer2 int, @operation2 nvarchar(30);
fetch LocalKurs into @nomer2,@operation2;
print '2.' + cast(@nomer2 as varchar) + ' ' + cast(@operation2 as varchar);
go
close LocalKurs;
deallocate LocalKurs;


declare @nomer3 int, @operation3 nvarchar(30);
declare LocalKurs cursor global
	for select �����_��������, ������������_�������� from ��������;
open LocalKurs;
fetch LocalKurs into @nomer3,@operation3;
print '1.' + cast(@nomer3 as varchar) + ' ' + cast(@operation3 as varchar);
go
declare @nomer4 int, @operation4 nvarchar(30);
fetch LocalKurs into @nomer4, @operation4;
print '2.' + cast(@nomer4 as varchar) + ' ' + cast(@operation4 as varchar);
go
close LocalKurs;
deallocate LocalKurs;



declare  @id int, @op nvarchar(30), @tn nvarchar(30);
declare Stat cursor local static 
	for select �����_��������, ������������_��������, ������ from dbo.�������� where  ������ = 5;
open Stat;
print '���������� �����: ' + cast(@@KurSOR_ROWS as varchar(5)); 
update �������� set ������ = 60 where ������������_�������� = '������';
delete �������� where �����_�������� = 1;
insert ��������(�����_��������, ������������_��������, �������_���������, ������)
	values (8, '������', '������', 24);
fetch Stat into @id, @op, @tn;
while @@fetch_status = 0                                    
    begin 
	print cast(@id as varchar) + ' '+ @op + ' '+ @tn ; 
        fetch Stat into @id, @op, @tn; 
    end;          
close Stat;
deallocate Stat;


DECLARE  @rowNum int, @nk int; 
DECLARE Kur cursor local dynamic SCROLL  for SELECT row_number() over (order by �����_��������) N, �����_�������� FROM dbo.�������� 
		                 where ������ = 5;
	OPEN Kur;
	FETCH  Kur into  @rowNum, @nk;                 
	print '��������� ������        : ' + cast(@rowNum as varchar(3)) + ' ' + cast(@nk as varchar);       
	FETCH FIRST from  Kur into @rowNum, @nk; 
	print '��������� ������        : ' +  cast(@rowNum as varchar(3)) + ' ' + cast(@nk as varchar); 
	FETCH  PRIOR from  Kur into @rowNum, @nk; 
	print '���������� ������       : ' +  cast(@rowNum as varchar(3)) + ' ' + cast(@nk as varchar); 
	FETCH  ABSOLUTE 2 from Kur into @rowNum, @nk; 
	print '������ ������           : ' +  cast(@rowNum as varchar(3)) + ' ' + cast(@nk as varchar); 
	FETCH  LAST from  Kur into @rowNum, @nk;       
	print '��������� ������        : ' +  cast(@rowNum as varchar(3)) + ' ' + cast(@nk as varchar);  
	FETCH  NEXT from  Kur into @rowNum, @nk; 
	print '������ ������ �� ������ : ' +  cast(@rowNum as varchar(3)) + ' ' + cast(@nk as varchar); 
	FETCH  RELATIVE -1 from  Kur into @rowNum, @nk; 
	print '���� ������ ����� �� �������: ' +  cast(@rowNum as varchar(3)) + ' ' + cast(@nk as varchar); 
      CLOSE Kur;


declare @kodik int, @type char(20), @amount int;     
DECLARE Kurs cursor local dynamic                               
        for SELECT �����_��������, ������������_��������, ������ from �������� FOR UPDATE;
OPEN Kurs;
fetch Kurs into @kodik, @type, @amount;
select * from ��������;
DELETE �������� where current of Kurs;
select * from ��������;
fetch Kurs into @kodik, @type, @amount;
UPDATE �������� set ������ = ������ + 10 where CURRENT OF Kurs;
select * from ��������;
CLOSE Kurs;
INSERT �������� (�����_��������, ������������_��������, �������_���������, ������) 
             values (10, '��������', '�������', 10); 

select * from ��������;                                               
DELETE �������� where �����_�������� = 5 AND ������ = 10;
Update �������� set ������ = ������ + 100 where �����_�������� = 5 AND ������ = 10;
select * from ��������;
