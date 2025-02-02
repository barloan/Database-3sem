
select p.�����_��������, p.������, t.�����_�����, t.����������_�������
from �������� p join ����_������ t
on p.�����_�������� = t.�����_��������
where p.�������_��������� = '������' for xml RAW('������'),
root('����������'), elements

select [����].�����_�������� [��������], 
[����].������ [������],
[����].�����_����� [����],
[����].����������_������� [������]
from �������� [����] join ����_������ [����]
on [����].�����_�������� = [����].�����_��������
	where [����].�������_��������� in ('������', '�������')
	order by [������] for xml AUTO,
	root('����������'), elements

select [����].�����_�������� [��������], 
[����].������ [������],
[����].�����_����� [����],
[����].����������_������� [������]
from �������� [����] join ����_������ [����]
on [����].�����_�������� = [����].�����_��������
	where [����].�������_��������� in ('������', '�������')
	order by [������] for xml PATH('������'),
	root('����������'), elements


	declare @n int,
       @x varchar(2000) = '<?xml version="1.0" encoding="windows-1251" ?>
       <��������>
       <�����_��������="96" ������������_��������="������" �������_���������="���������" ������="0" />
       <�����_��������="97" ������������_��������="��������" �������_���������="������" ������="11" />
       <�����_��������="98" ������������_��������="���������" �������_���������="������" ������="5" />
       </��������>';

exec sp_xml_preparedocument @n output, @x;  -- ���������� ���������
insert �������� ([�����_��������], [������������_��������], [�������_���������], [������])
select �����_��������, ������������_��������, �������_���������, ������
from openxml(@n, '/��������/�����_��������', 2)
     with (�����_�������� int,
           ������������_�������� nvarchar(100) ,
           �������_��������� nvarchar(100),
           ������ int '������')



drop table ����������
create table ����������
(     �����������  nvarchar(50) primary key,
	  �����  xml         -- ������� XML-����  
 );
 insert into ���������� (�����������,  �����)
    values ('���������', '<�����>  <������>��������</������>
	           <�����>�����</�����>  <�����>������</�����>
	           <���>52</���>    </�����>'); 
insert into ���������� (�����������,  �����)
    values ('���������', '<�����>   <������>��������</������>
	          <�����>�����</�����>  <�����>�������������</�����>
	          <���>35</���> </�����>'); 

update ���������� 
        set ����� = '<�����> <������>��������</������> 
             <�����>�����</�����> <�����>�������������</�����>
             <���>45</���> </�����>' 
                where �����.value('(/�����/���)[1]','varchar(10)') = 35;

select �����������, 
     �����.value('(/�����/������)[1]','varchar(10)') [������],
     �����.query('/�����') [�����] --���������� ��������� XML-������.
             from  ����������;       




create xml schema collection Operation as
N'<?xml version="1.0" encoding="utf-16" ?>
<xs:schema attributeFormDefault="unqualified"
           elementFormDefault="qualified"
           xmlns:xs="http://www.w3.org/2001/XMLSchema">
    <xs:element name="��������">
        <xs:complexType>
            <xs:sequence>
                <xs:element name="�����_��������" type="xs:int" />
                <xs:element name="������������_��������" type="xs:string" />
                <xs:element name="�������_���������" type="xs:string" />
                <xs:element name="������" type="xs:int" />
            </xs:sequence>
        </xs:complexType>
    </xs:element>
</xs:schema>';


drop table ���������
create table ���������
(
    ID_�������� int identity(1000,1) primary key,
    INFO xml(Operation)  -- �������������� ������� XML-����
);

insert into ��������� (INFO)
values ('<��������>
            <�����_��������>56</�����_��������>
            <������������_��������>������</������������_��������>
            <�������_���������>���������</�������_���������>
            <������>0</������>
        </��������>');

select ID_��������,
       INFO.value('(/��������/�����_��������)[1]', 'int') as �����_��������,
       INFO.value('(/��������/������������_��������)[1]', 'nvarchar(100)') as ������������_��������,
       INFO.value('(/��������/�������_���������)[1]', 'nvarchar(100)') as �������_���������,
       INFO.value('(/��������/������)[1]', 'int') as ������
from ���������;
