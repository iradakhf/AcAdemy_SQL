--1. Academy databazasını yaradın - 2 bal

create database Academy
use Academy

--2. Groups(İd,Name) ve Students(İd,Name,Surname,Groupİd) table-ları yaradın(one-to-many), təkrar qrup adı əlavə etmək olmasın - 5 bal
Create table Groups
(
Id int primary key identity,
Name nvarchar(255)

)

Create table Students
(
Id int primary key identity,
Name nvarchar(255),
Surname nvarchar(255),
GroupId int foreign key references Groups(Id)

)


Alter table Groups add  unique(Name)

--3. Students table-na Grade (int) kalonunu əlavə etmək - 3 bal

Alter table Students add Grade int 

--4. Groups table-na 3 data(P228,P124,P221), Students table-na 4 data əlavə edin(1 tələbə P221 qrupna, 3 tələbə 

--P228   qrupuna aid olsun) - 5 bal

Insert into Groups
Values
('P228'),
('P124'),
('P221')

Insert into Students(Name, Surname, GroupId)
Values
('Irada','Feyzullayeva',3),
('Irad','Feyzullayev',1),
('Irade','Fetullayeva',1),
('Ulker','Aliyeva',1)

--5. 

--P228  qrupuna aid olan tələbələrin siyahisini gosterin - 10 bal

Select g.Name 'group name', s.Name + ' ' + s.Surname 'student full name' from Groups g
join Students s on s.GroupId = g.Id
where g.Name = 'P228'

--6. Her qrupda neçə tələbə olduğunu göstərən siyahı çıxarmaq - 15 bal

Select g.Id, g.Name 'group name', COUNT(*) 'student count'  from Groups g
join Students s on s.GroupId = g.Id
group by g.Id, g.Name

--7. View yaratmaq - tələbə adını, qrupun adını-qrup kimi , tələbə soyadını, tələbənin balını göstərməli - 20 bal
Create view usv_ShowStudentDetails
as
select s.Name 'student name', g.Name 'group name', s.Surname 'surname', s.Grade from Students s
join Groups g on s.GroupId = g.Id

select * from usv_ShowStudentDetails
--8. Procedure yazmalı - göndərilən baldan yüksək bal alan tələbələrin siyahısını göstərməlidir - 20 bal

Create procedure usp_FindBiggerGrade(@grade int)
as
select * from Students s
where s.Grade>@grade


exec usp_FindBiggerGrade 7

--9. Funksiya yazmalı - göndərilən qrup adina uyğun neçə tələbə olduğunu göstərməlidir - 20 bal

Create function dbo_FindStudentForTheGroup(@GroupName nvarchar(255) = 'P228')
as 
Returns table
begin
 Select  g.Name 'group name', COUNT(*) 'student count'  from Groups g
join Students s on s.GroupId = g.Id
group by g.Name having g.Name = @GroupName
return (Select  COUNT(*) 'student count'  from Groups g
join Students s on s.GroupId = g.Id
group by g.Name having g.Name = @GroupName)
end