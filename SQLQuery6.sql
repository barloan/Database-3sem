use ��������_MyBASE
select ����_������.�����_�������� ,
       max(������) [������������ ��������],
	   count(*)  [���������� ��������]
from  ��������  Inner Join  ����_������
on ��������.�����_�������� = ����_������.�����_�������� 
and ����_������.����������_������� > 7 Group by ����_������.�����_�������� 


select *
from (select Case when ������ between 1 and 10 then '������ �� 10'
 when ������ between 10 and 25 then '������ 10 �� 25'
 else '������ ������ 25'
 end [�������_�����], COUNT(*) [����������]
from �������� group by
 Case
 when ������ between 1 and 10 then '������ �� 10'
 when ������ between 10 and 25 then '�� 10 �� 25'
 else '������ ������ 25'
 end) as T
    order by 
	case [�������_�����]
        when  '������ �� 10' then 3
		when  '�� 10 �� 25' then 2
		when  '������ ������ 25' then 1
		else 0
		end


select g.�������, g.���, g.����,
       s.����������_�������,
	   f.������������_��������,
	   ROUND(avg(cast(g.���� as float(4))),2) [�������_����]
	   from ��������� g inner join ����_������ s
	   on g.ID_��������� = s.ID_���������
	   inner join �������� f
	   on f.�����_�������� = s.�����_��������
	   where g.���� > 3
group by g.�������, g.���, g.����,
         s.����������_�������,
	     f.������������_��������


select p1.������������_��������, p1.������, 
 (select count(*) from �������� p2
  where p2.������������_�������� = p1.������������_��������
   and p2.������ = p1.������) [����������]
 from �������� p1
 group by p1.������������_��������, p1.������
 having ������ < 25 or ������ > 8

select �������, �����,  SUM(ID_���������) ����������_����������
 from ���������
 where ����� in ('�����������', '�����������')
 group by rollup (�������,ID_���������, �����) 


select �������, �����,  SUM(ID_���������) ����������_����������
 from ���������
 where ����� in ('�����������', '�����������')
 group by cube (�������,ID_���������, �����) 

select ID_���������, MIN(����) �����������_����
 from ��������� 
 where ��� = '�' 
 group by ID_���������
 union
 select ID_���������, MIN(����) �����������_����
 from ��������� 
 where ��� = '�' 
 group by ID_���������


select ID_���������, MIN(����) �����������_����
 from ��������� 
 where ��� = '�' 
 group by ID_���������
 intersect
 select ID_���������, MIN(����) �����������_����
 from ��������� 
 where ��� = '�' 
 group by ID_���������


select ID_���������, MIN(����) �����������_����
 from ��������� 
 where ��� = '�' 
 group by ID_���������
 except 
 select ID_���������, MIN(����) �����������_����
 from ��������� 
 where ��� = '�' 
 group by ID_���������