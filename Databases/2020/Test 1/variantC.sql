use movies;
--zad1
--Да се изведат името и рождената дата за всички филмови звезди с неизвестен адрес,
--които НЕ са играли във филм на Дисни преди навършване на 18 г.
--Да се включат и звезди, за които нямаме информация в кои филми са играли.

select name, birthdate
from MOVIESTAR
where ADDRESS is null and name not in (select STARNAME 
		from STARSIN 
		join MOVIE on movie.TITLE = STARSIN.MOVIETITLE and MOVIE.YEAR = STARSIN.MOVIEYEAR
		join MOVIESTAR on STARSIN.STARNAME = MOVIESTAR.NAME
		where STUDIONAME = 'Disney' and year(MOVIESTAR.BIRTHDATE)-MOVIEYEAR<=18) 
	
--zad2 За всяка филмова звезда да се изведе следната информация: 
--име;
--заглавие на филм;
--брой филми, които са заснети в годината на филма (без значение дали 
--	актьор е играл в тях).
--Ако за дадена звезда няма информация в кои филми е играла, 
--за нея да се изведе ред в следния формат: име, null, 0. 
--Пример:
/*Актьор1 Филм1 5
Актьор1 Филм2 0
Актьор1 Филм3 2
Актьор2 null 0*/

select m1.name, s1.movietitle, count(distinct s2.MOVIETITLE) as 'movies launched the same year' from MOVIESTAR  m1
left join STARSIN  s1 on m1.NAME = s1.STARNAME
left join STARSIN  s2 on s1.MOVIEYEAR = s2.MOVIEYEAR
group by m1.name, s1.movietitle


--zad3 Напишете заявка, която извежда имената и рождените дати на тези актриси,
--които са родени през първата половина на годината (януари-юни)
--и името им не съдържа буквата R.
--Първо да се изведат най-младите актриси, а ако няколко актриси имат 
--еднаква рождена дата, те да бъдат подредени по азбучен ред на името.

select name, birthdate from moviestar
where month(birthdate) >= 1 and month(birthdate) <= 6 
	and name not like '%R%'
order by birthdate desc, name

--zad 4 За всяко студио, чийто адрес съдържа буквата A и имащо поне два филма,
--да се изведат: име, първа година, в която студиото е снимало филм; 
--брой на (различните) актьори, които са играли във филми, снимани от студиото.

select studio.name, min(year) as 'min year', count (distinct starname) as 'count unique stars' from studio
join movie on studio.name = movie.studioname
join starsin on starsin.movietitle = movie.title and starsin.movieyear = movie.year
where studio.address like '%A%'
group by studio.name
having count(distinct title)>=2