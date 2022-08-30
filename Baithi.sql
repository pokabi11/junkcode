/*
 * Executed on 30 August 2022 at 09:47:37
 */

create table Department(
DepartId int primary key identity(1,1),
DepartName varchar(50) not null,
Description varchar(100) not null
);

create table Employee(
EmpCode char(6) primary key,
FirstName varchar(30) not null,
LastName varchar(30) not null,
Birthday smalldatetime not null,
Gender Bit Default 1,
Address varchar(100),
DepartID int foreign key references Department(DepartId),
Salary Decimal (16,0)
);

insert into Department(DepartName,Description) values('Flight to the Mondstadt','Trip to the Mondstadt');
insert into Department(DepartName,Description) values('Flight to the Inazuma','Trip to the Inazuma');
insert into Department(DepartName,Description) values('Flight to the Liyue','Trip to the Liyue');

insert into Employee(EmpCode,FirstName,LastName,Birthday,Gender,Address,Salary) values ('T2204M','Amber','Müller','2001-12-12',0,'Dreamhouse,Mondstadt',26000);
insert into Employee(EmpCode,FirstName,LastName,Birthday,Gender,Address,Salary) values ('T2205M','Diluc','Schmidt','1998-05-01',0,'Wine Factory,Mondstadt',32000);
insert into Employee(EmpCode,FirstName,LastName,Birthday,Gender,Address,Salary) values ('T2206M','Zhongli','Huang','1991-08-16',0,'Liyue',65000);

update Employee
set Salary = Salary + (Salary*10/100);

alter table Employee add check(Salary > 0);

create trigger tg_chkBirthday
after insert
as
begin
if exists (select * from inserted where (Date-Birthday) < 22)
end

create view V_Epl_Dpm 
as
select Firstname,LastName,DepartmentName
from Employee
as ag1
join Department
as fe2 on ag1.DepartID= fe2.Id

alter procedure sp_getAllEmp @ID char(6) as
select * from Employee where DepartID in (
select Id from Department where id =(
select DepartID from EMployee where EmpCode = @ID
))



