use Савицкая_MyBASE
select Учет_работы.Номер_операции ,
       max(Оплата) [Максимальная зарплата],
	   count(*)  [Количество операций]
from  Операции  Inner Join  Учет_работы
on Операции.Номер_операции = Учет_работы.Номер_операции 
and Учет_работы.Количество_деталей > 7 Group by Учет_работы.Номер_операции 


select *
from (select Case when Оплата between 1 and 10 then 'оплата до 10'
 when Оплата between 10 and 25 then 'оплата 10 до 25'
 else 'оплата больше 25'
 end [Пределы_оплат], COUNT(*) [Количество]
from Операции group by
 Case
 when Оплата between 1 and 10 then 'оплата до 10'
 when Оплата between 10 and 25 then 'от 10 до 25'
 else 'оплата больше 25'
 end) as T
    order by 
	case [Пределы_оплат]
        when  'оплата до 10' then 3
		when  'от 10 до 25' then 2
		when  'оплата больше 25' then 1
		else 0
		end


select g.Фамилия, g.Имя, g.Стаж,
       s.Количество_деталей,
	   f.Наименование_операции,
	   ROUND(avg(cast(g.Стаж as float(4))),2) [Средний_стаж]
	   from Работники g inner join Учет_работы s
	   on g.ID_работника = s.ID_работника
	   inner join Операции f
	   on f.Номер_операции = s.Номер_операции
	   where g.Стаж > 3
group by g.Фамилия, g.Имя, g.Стаж,
         s.Количество_деталей,
	     f.Наименование_операции


select p1.Наименование_операции, p1.Оплата, 
 (select count(*) from Операции p2
  where p2.Наименование_операции = p1.Наименование_операции
   and p2.Оплата = p1.Оплата) [Количество]
 from Операции p1
 group by p1.Наименование_операции, p1.Оплата
 having Оплата < 25 or Оплата > 8

select Фамилия, Район,  SUM(ID_работника) Количество_работников
 from Работники
 where Район in ('Фрунзенский', 'Центральный')
 group by rollup (Фамилия,ID_работника, Район) 


select Фамилия, Район,  SUM(ID_работника) Количество_работников
 from Работники
 where Район in ('Фрунзенский', 'Центральный')
 group by cube (Фамилия,ID_работника, Район) 

select ID_работника, MIN(Стаж) Минимальный_стаж
 from Работники 
 where Пол = 'м' 
 group by ID_работника
 union
 select ID_работника, MIN(Стаж) Минимальный_стаж
 from Работники 
 where Пол = 'ж' 
 group by ID_работника


select ID_работника, MIN(Стаж) Минимальный_стаж
 from Работники 
 where Пол = 'м' 
 group by ID_работника
 intersect
 select ID_работника, MIN(Стаж) Минимальный_стаж
 from Работники 
 where Пол = 'ж' 
 group by ID_работника


select ID_работника, MIN(Стаж) Минимальный_стаж
 from Работники 
 where Пол = 'м' 
 group by ID_работника
 except 
 select ID_работника, MIN(Стаж) Минимальный_стаж
 from Работники 
 where Пол = 'ж' 
 group by ID_работника