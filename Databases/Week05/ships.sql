use ships;
--1. Напишете заявка, която извежда броя на класовете кораби.
select count(*) as 'count of classes' from classes; 


--2. Напишете заявка, която извежда средния
--брой на оръдията (numguns) за всички
--кораби, пуснати на вода (т.е. изброени са в
--таблицата Ships).
select avg(numguns) as 'avg numguns' from ships
join classes on ships.class = classes.class;

-- or
select avg(numguns) 'avg numguns' from classes c
join ships s on c.class = s.class;

--3. Напишете заявка, която извежда за всеки
--клас първата и последната година, в която
--кораб от съответния клас е пуснат на вода.
select class, min(launched) as 'min year launched', max(launched) as 'max year launched' from ships
group by class;
 
/* 4. Напишете заявка, която за всеки клас
извежда броя на корабите, потънали в
битка.
*/
select class, count(*) as 'count sunk' from ships
join outcomes on ships.name = outcomes.ship and result='sunk'
group by class;

/*
5. Напишете заявка, която за всеки клас с над
4 пуснати на вода кораба извежда броя на
корабите, потънали в битка.
*/
select class, count(*) as 'count sunk' from ships
join outcomes on outcomes.ship = ships.name
where result = 'sunk' and class in (select class from ships
									group by class
									having count(*) > 4)
group by class;

/*
6. Напишете заявка, която извежда средното
тегло на корабите (displacement) за всяка
страна. 
*/
select country, avg(displacement) as 'avg displacement' from classes
group by country;
