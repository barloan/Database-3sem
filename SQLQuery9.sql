use Савицкая_MyBASE

exec SP_HELPINDEX 'ОПЕРАЦИИ'               
exec SP_HELPINDEX 'Работники'
exec SP_HELPINDEX 'Учет_работы'

CREATE table #x 
(Номер_операции int, Оплата int) ;

declare @count int = 1;
while @count <= 1000
begin 
insert #x(Номер_операции, Оплата) 
	values (floor(30000*rand()), @count);
	set @count = @count + 1;
end;

select * from #x where Оплата between 3 and 10
order by Оплата;


create clustered index #x on #x(Оплата asc);

checkpoint; 
dbcc DROPCLEANBUFFERS;
drop table #x;


CREATE table #ex
	( monet int, 
      id int identity(1, 1),
      info varchar(10));
	  declare @a int = 1;
	while @a <= 10000 
	begin 
	insert #ex(monet, id)
	values(floor(30000*rand()), @a);
	set @a = @a + 1 ;
	end;

  select count(*)[количество строк] from #ex;
  select * from #ex;
  create nonclustered index #ex_noncl on #ex(monet, id); 
  select *from #ex;
  drop table #ex;
  

CREATE  table #ex_tkey
(id int, info varchar(10));
declare @b int = 1;
while @b <= 10000
begin 
insert #ex_tkey (id, info)
	values (floor(30000*rand()), @b);
	set @b = @b + 1;
end;

select * from #ex_tkey;
create index #ex_tkey on #ex_tkey(id) include (info);
select info from #ex_tkey where id > 500;
drop table #ex_tkey;



CREATE table #ex_filt 
(id int, info varchar(10));

declare @c int = 1;
while @c <= 10000
begin 
insert #ex_filt (id, info)
	values (floor(30000*rand()), @c);
	set @c = @c + 1;
end;
select * from #ex_filt;
select id from #ex_filt where id between 10 and 100;
select id from #ex_filt where id > 10 and id < 100;
select id from #ex_filt where id = 100;
create index #ex_where on #ex_filt(id) where (id < 500);
drop table #ex_filt;


CREATE table #full 
(id int,  info varchar(10));
declare @d int = 1;
while @d < 10000 
begin
insert #full (id, info)
values (floor(30000*rand()), @d);
set  @d =  @d + 1;
end;
select * from #full;
create index #full_id on #full(id);
insert top(10000) #full(id, info) select id, info from #full;

select name [Индекс], avg_fragmentation_in_percent [Фрагментация (%)]
from sys.dm_db_index_physical_stats(DB_ID(),
OBJECT_ID(N'#full'), null, null, null) ss  JOIN sys.indexes ii on ss.object_id =
ii.object_id and ss.index_id = ii.index_id  WHERE name is not null;

alter index #full_id on #full reorganize;

alter index #full_id on #full rebuild with (online = off);


CREATE table #fill 
(id int,  info varchar(10));
declare @e int = 1;
while @e < 10000
begin
insert #fill (id, info)
values (floor(30000*rand()), @e);
set @e = @e + 1;
end;

select  * from #fill;
create index #fill_id on #fill(id) with (fillfactor = 65);
insert top(50) percent into #fill(id, info) select id, info from #fill;
select name [Индекс], avg_fragmentation_in_percent [Фрагментация (%)]
from sys.dm_db_index_physical_stats(DB_ID(),
OBJECT_ID(N'#fill'), null, null, null) a join sys.indexes b on a.object_id = b.object_id and a.index_id  = b.index_id
where name is not null;
drop table #fill;
