USE master;
CREATE database Савицкая_MyBASE;

use Савицкая_MyBASE;
CREATE table Операции 
( Номер_операции int primary key not null,
  Наименование_операции nvarchar(15) not null,
  Признак_сложности nvarchar(10) 
  );

CREATE table Работники 
(ID_работника int primary key not null, 
 Фамилия nvarchar(20) not null,
 Имя nvarchar(10) not null,
 Отчество nvarchar(20),
 Район nvarchar(30) not null,
 Телефон nchar(14) not null,
 Стаж float not null 
);

CREATE table Учет_работы
( Номер_учета int primary key not null,
  ID_работника int not null foreign key references Работники(ID_работника),
  Номер_операции int not null foreign key references Операции(Номер_операции),
  Количество_деталей int not null,
  Дата date not null
) 
  
  ALTER table Работники ADD Статус nvarchar(30);
  ALTER Table Работники ADD Пол nchar(1) default 'м' check(Пол in ('м', 'ж'));
  ALTER table Работники DROP Column Статус;

  INSERT into Операции (Номер_операции, Наименование_операции, Признак_сложности)
  Values (1, 'сборка', 'средний'),
         (2, 'упаковка', 'легкий'),
		 (3, 'заготовка', 'средний'),
		 (4, 'сварка', 'сложный'),
		 (5, 'транспортировка', 'легкий');

  INSERT into Работники (ID_работника, Фамилия, Имя, Отчество, Район, Телефон, Стаж) 
  Values (1, 'Пупкин', 'Василий', 'Сергеевич', 'Лененский', +375299578456, 2),
         (2, 'Бикович', 'Борис', 'Николаевич', 'Фрунзенский', +375297885455, 0.5),
		 (3, 'Стрижев', 'Павел', 'Эдуардович', 'Московский', +375298741257, 3),
		 (4, 'Богран', 'Василий', 'Игоревич', 'Центральный', +375299578542, 8),
		 (5, 'Санькин', 'Михаил', '', 'Лененский', +375299545258, 10);

INSERT into Учет_работы (Номер_учета, ID_работника, Номер_операции, Количество_деталей, Дата)
Values (1, 1, 2, 50,'05.05.2020'),
       (2, 3, 2, 3, '25.09.2020'),
	   (3, 4, 4, 15, '01.09.2020'),
	   (4, 5, 3, 67, '08.09.2020'),
	   (5, 2, 5, 5, '09.09.2020');

 SELECT *From Учет_работы;
 SELECT Фамилия, Имя From Работники;
 SELECT count(*) From Работники;

 UPDATE Учет_работы set Количество_деталей = Количество_деталей + 5;
 SELECT Количество_деталей From Учет_работы ;

 use master
 go
 create database Савицкая1_MyBASE 
 on primary
 (name = N'Савицкая_MyBASE_mdf', filename = N'D:\2 курс\база данных\3лр\Савицкая1_MyBASE_mdf.mdf',
 size = 10240Kb, maxsize = UNLIMITED, filegrowth = 1024Kb),
 ( name = N'Савицкая_MyBASE_ndf', filename = N'D:\2 курс\база данных\3лр\Савицкая1_MyBASE_ndf.ndf', 
   size = 10240KB, maxsize = 1Gb, filegrowth = 25%),
   filegroup FG1
( name = N'Савицкая_MyBASE_fg1_1', filename = N'D:\2 курс\база данных\3лр\Савицкая1_MyBASE_fgq-1.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%),
( name = N'Савицкая_MyBASE_fg1_2', filename = N'D:\2 курс\база данных\3лр\Савицкая1_MyBASE_fgq-2.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%)
      log on
( name = N'Савицкая_MyBASE_log', filename=N'D:\2 курс\база данных\3лр\Савицкая1_MyBASE_log.ldf',       
   size = 10240Kb,  maxsize = 2048Gb, filegrowth = 10%)

   Create table Работа
( Номера int primary key, 
  Название nvarchar(20)               
 ) on FG1;

