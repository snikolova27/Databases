/**
Да се напише една заявка, която утроява дължините на всички филми,
които са с неизвестно студио или са от година, в която са снимани
поне два филма
**/
use movies;

select * from movie;

-- добавяме си стойности за задачата
insert into movie (title, year, LENGTH,INCOLOR, STUDIONAME, PRODUCERC)
values('some-title1', 1998, 45, 'y', 'Fox', 123)

insert into movie (title, year, LENGTH,INCOLOR, STUDIONAME, PRODUCERC)
values('some-title2', 2001, 45, 'n', 'MGM', 555)

insert into movie (title, year, LENGTH,INCOLOR, STUDIONAME, PRODUCERC)
values('some-title3', 1970, 45, 'n',null, 555)

insert into movie (title, year, LENGTH,INCOLOR, STUDIONAME, PRODUCERC)
values('some-title4', 1970, 45, 'n',null, 555)



-- филми на година
create view movies_per_year
as
select  year, count(*) as'count movies' from movie
group by year

select * from  movies_per_year
drop view movies_per_year

-- филми с неизвестно студио
create view movies_without_studio
as
select title, year from movie
where studioname is null

select * from movies_without_studio



select year from movie
						group by year
						having count(*) >=2

select * from movie;

-- в една заявка
update movie
set length = length * 3
where year in (select m2.year from movie m2
				where studioname is null 
				and m2.year in (select m3.year from movie m3
						group by m3.year
						having count(*) >=2))



/**
Да се направи така, че при изтриване на актьор, роден през 1980г,
автоматично да се изтриват всички записи с неговото име 
в StarsIn
**/

select * from starsin


-- добавяме си актьор, който да изтрием
insert into moviestar(name, address, gender, birthdate)
values('some-name', 'some-addr','F', '1980-03-04')

select * from moviestar

-- добавяме го във филм
insert into starsin(movietitle, movieyear, starname)
values('Star Wars', 1977, 'some-name')


select starname from starsin
where starname in (select ms.name from moviestar ms
					where year(ms.BIRTHDATE) = 1980
				)

create trigger tr1 
on Moviestar
instead of delete
as 
begin 
		delete from starsin
		where starname in (select d.name from deleted d
							where d.name in (select ms.name from moviestar ms
											where year(ms.BIRTHDATE) =1980)
							)
	delete from moviestar
	where name in (select d.name from deleted d);

end

delete from moviestar
where name='some-name'

drop trigger tr1
