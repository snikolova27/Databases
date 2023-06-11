use movies;

/**
1. Създайте изглед, който
извежда имената и
рождените дати на всички
актриси.

**/

create view actresses_birthdays
as
	select name, birthdate from moviestar
	where gender='F'
	with check option;

select * from actresses_birthdays

-- не бачка, защото нямаме колоната пол,а имамe check option
insert into actresses_birthdays(name, BIRTHDATE) 
values('Nikole Kidman', '2001-05-20')

/**
2. Създайте изглед, който за
всяка филмова звезда
извежда броя на филмите,
в които се е снимала. Ако
за дадена звезда не знаем
какви филми има, за нея да
се изведе 0.
**/

create view star_movies
as
select starname, count(*) as movies_count  from starsin
group by starname

select * from star_movies
insert into star_movies(starname) values('Nikole Kidman')

-- не позволяват модификации, защото съдържат агрегати (group by)
