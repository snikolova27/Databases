-- Зад. 3. 
-- а) За всеки студент се съхранява следната информация:
-- фак. номер - от 0 до 99999, първичен ключ;
-- име - до 100 символа;
-- ЕГН - точно 10 символа, уникално;
-- e-mail - до 100 символа, уникален;
-- рождена дата;
-- дата на приемане в университета - трябва да бъде поне 18 години след рождената;
-- за всички атрибути задължително трябва да има зададена стойност (не може NULL)

create database deleteme
go
use deleteme
go

create table Students(
	fn int PRIMARY KEY CHECK(fn between 0 and 99999),
	name nvarchar(100) not null,
	egn char(10) unique not null,
	email nvarchar(100) unique not null,
	birthdate date not null,
	addDate date not null,
	constraint at_least_18_years_old check(datediff(year, birthdate, addDate) >= 18)
)
insert into Students
values(81888, 'Ivan Ivanov', '9001012222', 'ivan@gmail.com', '1990-01-01', '2009-01-10');
insert into Students
values(81213, 'Sonya Nikolova', '7895463210', 'sonya@gmail.com', '2001-01-01', '2019-01-10');

select * from Students

-- б) добавете валидация за e-mail адреса - да бъде във формат <нещо>@<нещо>.<нещо>
alter table Students
add constraint valid_email check (email like '%_@%_.%_');

-- гърмеж долу
update students set email = 'ehooo';

-- в) създайте таблица за университетски курсове - уникален номер и име
create table Courses(
	id int identity primary key,
	name varchar(50) not null
)
drop table Courses

insert into Courses(name) values('DB');
insert into Courses(name) values('OOP');
insert into Courses(name) values('Android');
insert into Courses(name) values('iOS');
select * from Courses;


-- всеки студент може да се запише в много курсове и във всеки курс
-- може да има записани много студенти.
-- При изтриване на даден курс автоматично да се отписват всички студенти от него.
create table StudentsIn(
	student_fn int references Students(fn),
	course_id int,
	primary key(student_fn, course_id),
	constraint FK_COURSE
	foreign key (course_id) references Courses(id)
	ON DELETE CASCADE
)

drop table StudentsIn;


insert into StudentsIn values(81888, 2);
insert into StudentsIn values(81888, 3);
insert into StudentsIn values(81888, 4);
select * from StudentsIn;

-- id-тата на всички курсове, в които се е записал студент 81888:
select course_id
from StudentsIn
where student_fn = 81888;

-- факултетните номера на всички студенти, записали се в курс с id=3 (Android):
select student_fn
from StudentsIn
where course_id = 3;

delete from courses
where name = 'iOS';
select * from StudentsIn;
-- виждаме, че вече няма студенти, записани в курс с id = 4

delete from Courses
where id = 3

select * from Courses
select * from StudentsIn

-- факултетните номера на всички студенти, записали се в курс с id=3 (Android):
select student_fn
from StudentsIn
where course_id = 3;

use master
go
drop database deleteme;

