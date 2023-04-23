-- Общи задачи

use movies;

-- Да се изведат заглавията и годините на всички филми, чието заглавие
-- съдържа едновременно като поднизове "the" и "w" (не непременно в този ред).
-- Резултатът да бъде сортиран по година (първо най-новите), а филми от 
-- една и съща година да бъдат подредени по азбучен ред.

select title, year from movie
where title like '%the%' and title like '%w%'
order by year desc, title asc;

/*
Заглавията и годините на филмите, в които са играли звезди, родени между
1.1.1970 и 1.7.1980.
*/
select distinct title, year, moviestar.name, moviestar.birthdate from movie 
join starsin on title=movietitle
join moviestar on name=starname and year(birthdate)>=1970 and (year(birthdate) <=1980 and month(birthdate) <= 7);


use ships;
/*
Имената и годините на пускане на всички кораби, които имат същото име като
своя клас.
*/
select name, launched from ships 
where name = class;

select * from ships;

/*
• Имената на всички кораби, за които едновременно са изпълнени следните
условия: (1) участвали са в поне една битка и (2) имената им (на корабите)
започват с C или K.
*/
select distinct ship from outcomes
where ship like 'C%' or ship like 'K%';


--Всички държави, които имат потънали в битка кораби.
select distinct country from classes
join ships on ships.class = classes.class
join outcomes on outcomes.ship = ships.name and result='sunk';

--Всички държави, които нямат нито един потънал кораб
select distinct country from classes
where country not in (select distinct country from classes
join ships on ships.class = classes.class
join outcomes on outcomes.ship = ships.name and result='sunk');

select distinct country from classes

/*
(От държавен изпит) Имената на класовете, за които няма кораб, пуснат на вода
(launched) след 1921 г. Ако за класа няма пуснат никакъв кораб, той също трябва
да излезе в резултата.
*/
select class from classes
where class not in (select class from ships where launched > 1921);

/* Името, държавата и калибъра (bore) на всички класове кораби с 6, 8 или 10
оръдия. Калибърът да се изведе в сантиметри (1 инч е приблизително 2.54 см).
*/
select distinct name, country, bore * 2.54 as 'Bore in cm' from classes
join ships on classes.class = ships.class
where numguns = 6 or numguns = 8 or numguns = 10;

/*
• Държавите, които имат класове с различен калибър (напр. САЩ имат клас с 14
калибър и класове с 16 калибър, докато Великобритания има само класове с 15).
*/
select distinct c1.country from classes c1
join  classes c2 on c1.country = c2.country and c1.bore != c2.bore;


select * from classes

--Страните, които произвеждат кораби с най-голям брой оръдия (numguns).
select distinct country from classes
where numguns >= ALL(select numguns from classes)

use pc;

select * from pc;
select * from pc p join product pr on p.model=pr.model
order by maker;


select * from laptop;
select * from laptop l join product pr on l.model = pr.model
order by maker;


-- Компютрите, които са по-евтини от всеки лаптоп на същия производител.
select code, pc.model, pr.maker from PC pc
join PRODUCT pr on pc.model = pr.model
where pc.price < ALL(select price from laptop lp
				join product on lp.model = product.model
				where pr.maker = product.maker)
order by maker ASC;

select * from pc p join product pr on p.model=pr.model
order by maker;

select * from laptop l join product pr on l.model = pr.model
order by maker;

-- Компютрите, които са по-евтини от всеки лаптоп и принтер на същия производител.select code, pc.model, pr.maker from PC pc
join PRODUCT pr on pc.model = pr.model
where pc.price < ALL(select price from laptop lp
				join product on lp.model = product.model
				where pr.maker = product.maker)
		and 
			pc.price < ALL(select price from printer
				join product on printer.model = product.model
				where pr.maker = product.maker)
order by maker ASC;

