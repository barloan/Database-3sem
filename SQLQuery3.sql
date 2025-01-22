USE master;
CREATE database ��������_MyBASE;

use ��������_MyBASE;
CREATE table �������� 
( �����_�������� int primary key not null,
  ������������_�������� nvarchar(15) not null,
  �������_��������� nvarchar(10) 
  );

CREATE table ��������� 
(ID_��������� int primary key not null, 
 ������� nvarchar(20) not null,
 ��� nvarchar(10) not null,
 �������� nvarchar(20),
 ����� nvarchar(30) not null,
 ������� nchar(14) not null,
 ���� float not null 
);

CREATE table ����_������
( �����_����� int primary key not null,
  ID_��������� int not null foreign key references ���������(ID_���������),
  �����_�������� int not null foreign key references ��������(�����_��������),
  ����������_������� int not null,
  ���� date not null
) 
  
  ALTER table ��������� ADD ������ nvarchar(30);
  ALTER Table ��������� ADD ��� nchar(1) default '�' check(��� in ('�', '�'));
  ALTER table ��������� DROP Column ������;

  INSERT into �������� (�����_��������, ������������_��������, �������_���������)
  Values (1, '������', '�������'),
         (2, '��������', '������'),
		 (3, '���������', '�������'),
		 (4, '������', '�������'),
		 (5, '���������������', '������');

  INSERT into ��������� (ID_���������, �������, ���, ��������, �����, �������, ����) 
  Values (1, '������', '�������', '���������', '���������', +375299578456, 2),
         (2, '�������', '�����', '����������', '�����������', +375297885455, 0.5),
		 (3, '�������', '�����', '����������', '����������', +375298741257, 3),
		 (4, '������', '�������', '��������', '�����������', +375299578542, 8),
		 (5, '�������', '������', '', '���������', +375299545258, 10);

INSERT into ����_������ (�����_�����, ID_���������, �����_��������, ����������_�������, ����)
Values (1, 1, 2, 50,'05.05.2020'),
       (2, 3, 2, 3, '25.09.2020'),
	   (3, 4, 4, 15, '01.09.2020'),
	   (4, 5, 3, 67, '08.09.2020'),
	   (5, 2, 5, 5, '09.09.2020');

 SELECT *From ����_������;
 SELECT �������, ��� From ���������;
 SELECT count(*) From ���������;

 UPDATE ����_������ set ����������_������� = ����������_������� + 5;
 SELECT ����������_������� From ����_������ ;

 use master
 go
 create database ��������1_MyBASE 
 on primary
 (name = N'��������_MyBASE_mdf', filename = N'D:\2 ����\���� ������\3��\��������1_MyBASE_mdf.mdf',
 size = 10240Kb, maxsize = UNLIMITED, filegrowth = 1024Kb),
 ( name = N'��������_MyBASE_ndf', filename = N'D:\2 ����\���� ������\3��\��������1_MyBASE_ndf.ndf', 
   size = 10240KB, maxsize = 1Gb, filegrowth = 25%),
   filegroup FG1
( name = N'��������_MyBASE_fg1_1', filename = N'D:\2 ����\���� ������\3��\��������1_MyBASE_fgq-1.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%),
( name = N'��������_MyBASE_fg1_2', filename = N'D:\2 ����\���� ������\3��\��������1_MyBASE_fgq-2.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%)
      log on
( name = N'��������_MyBASE_log', filename=N'D:\2 ����\���� ������\3��\��������1_MyBASE_log.ldf',       
   size = 10240Kb,  maxsize = 2048Gb, filegrowth = 10%)

   Create table ������
( ������ int primary key, 
  �������� nvarchar(20)               
 ) on FG1;

