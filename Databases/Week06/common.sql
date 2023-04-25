-- Намерете броя на потъналите американски кораби за всяка проведена битка с поне един потънал
--американски кораб.
use ships;
select battle, count(*) as 'count sunken American ship' from outcomes
join ships on ship = name
join classes on ships.class = classes.class
where result='sunk' and country = 'USA'
group by battle;

-- Битките, в които са участвали поне 3 кораба на една и съща страна.
select distinct battle from outcomes
join ships on ship = name
join classes on ships.class = classes.class
group by battle, country
having count(*) >= 3;


-- За всеки клас да се изведе името му, държавата и първата година, 
-- в която е пуснат кораб от този клас
select c.class, country, min(launched) as FirstYear
from classes c
join ships s on c.class = s.class
group by c.class, country;
-- или:

 select c.class, min(country) as country, min(launched) as firstYear
 from classes c
 join ships on c.class = ships.class
 group by c.class;

-- За всеки клас с кораби - името на класа, името на произволен кораб и брой кораби
select class, min(name), count(*)
from ships
group by class;

-- Имената на класовете, за които няма кораб, пуснат на вода след 1921 г., но имат пуснат поне един
-- кораб.
select class from ships
group by class
having max(launched) <= 1921;

--  За всеки кораб броя на битките, в които е бил увреден (result = ‘damaged’). Ако корабът не е участвал
--в битки или пък никога не е бил увреждан, в резултата да се вписва 0.
-- вярно и ефективно:
select name, count(battle)
from ships
left join outcomes on name = ship and result = 'damaged'
group by name;

-- или (вярно):

---... left join (select * from outcomes where result = 'damaged') d ...

-- или (дава възможности за много сложни заявки):

select name, (select count(*)
	from outcomes o
	where result = 'damaged'
		and o.ship = s.name)
from ships s;

-- или (ефективно):

select name, sum(case result 
				when 'damaged' then 1 
				else 0
				end) 
from ships
left join outcomes on name = ship
group by name;

-- За всяка държава да се изведе броят на корабите и броят на потъналите кораби.
select country, count(ships.name) as 'count ships', count(outcomes.ship) as 'count sunk ships'
from classes
left join ships on classes.class = ships.class
left join outcomes on name = ship and result = 'sunk'
group by country;

-- За всяка държава да се изведе броят на повредените кораби и броят на потъналите кораби. Всяка от
--бройките може да бъде и нула.
select country, count(distinct damaged.ship) as 'damaged', count (distinct sunk.ship) as 'sunk' from classes
left join ships on classes.class = ships.class
left join outcomes damaged on name = damaged.ship and damaged.result = 'damaged'
left join outcomes sunk on name = sunk.ship and sunk.result = 'sunk'
group by country;


-- по-добре:
select country, (select count(distinct name)
				from classes
				join ships on classes.class = ships.class
				join outcomes on ship = name
				where result = 'damaged'
					and country = c.country) as damaged,
				(select count(*)
				from classes
				join ships on classes.class = ships.class
				join outcomes on ship = name
				where result = 'sunk'
					and country = c.country) as sunk
from classes c
group by country;

-- Намерете за всеки клас с поне 3 кораба броя на корабите от този клас, които са победили в битка
--(result = 'ok')
select class, count(distinct ship) -- повторения има, ако даден кораб е бил ok в няколко битки
from ships
left join outcomes on name = ship and result = 'ok'
group by class
having count(distinct name) >= 3;

-- За всяка филмова звезда да се изведе името, рождената дата и с кое студио е записвала най-много
--филми. (Ако има две студиа с еднакъв брой филми, да се изведе кое да е от тях)
use movies;
select name, birthdate, (select top 1 studioname
						 from starsin
						 join movie on movietitle = title and movieyear = year
						 where starname = name
						 group by studioname
						 order by count(*) desc) studioName
from moviestar;

-- Намерете за всички производители на поне 2 лазерни принтера броя на произвежданите от тях PC-та
--(конкретни конфигурации), евентуално 0.
use pc;
select maker, count(pc.code)
from product p
left join pc on p.model = pc.model
where maker in (select maker
				from product
				join printer on product.model = printer.model
				where printer.type = 'Laser' -- в Product също има колона type
				group by maker
				having count(*) >= 2)
group by maker;

-- или в having:
select maker, count(pc.code)
from product p
left join pc on p.model = pc.model
group by maker
having maker in (select maker
				from product
				join printer on product.model = printer.model
				where printer.type = 'Laser' -- в Product също има колона type
				group by maker
				having count(*) >= 2);

-- OR
select maker, (select count(*)
			from product p1 
			join pc on p1.model = pc.model
				and p1.maker = p.maker)
from product p
join printer on p.model = printer.model
where printer.type = 'Laser'
group by maker
having count(*) >= 2;
-- Да се изведат всички производители, за които средната цена на произведените компютри е по-ниска
--от средната цена на техните лаптопи.

select maker
from product p
join pc on p.model = pc.model
group by maker
having avg(price) < (select avg(price)
					 from product
					 join laptop on product.model = laptop.model
					 where maker = p.maker); -- корелативна подзаявка в having


-- Един модел компютри може да се предлага в няколко конфигурации с евентуално различна цена. Да
--се изведат тези модели компютри, чиято средна цена (на различните му конфигурации) е по-ниска от
--най-евтиния лаптоп, произвеждан от същия производител.
select pc.model
from pc
join product p on pc.model = p.model
group by pc.model, p.maker -- трябва да групираме и по maker, понеже 
		-- го подаваме на корелативна подзаявка в having
having avg(price) < (select min(price) 
					from laptop
					join product t 
					on laptop.model = t.model
					where t.maker = p.maker);
-- или:
select pc.model
from pc join product p on pc.model=p.model
group by pc.model
having avg(price) < (select min(price) 
		from laptop
		join product t 
		on laptop.model = t.model
		where t.maker = min(p.maker)); -- този min не се изпълнява в where, 
		-- а в having и подзаявката получава стойността, върната от min


-- Без повторение заглавията и годините на всички филми, заснети преди 1982, в които е играл поне един актьор
--(актриса), чието име не съдържа нито буквата 'k', нито 'b'. Първо да се изведат най-старите филми.


-- Заглавията и дължините в часове (length е в минути) на всички филми, които са от същата година, от която е и филмът
--Terms of Endearment, но дължината им е по-малка или неизвестна.


-- Имената на всички продуценти, които са и филмови звезди и са играли в поне един филм преди 1980 г. и поне един
--след 1985 г.


-- Всички черно-бели филми, записани преди най-стария цветен филм (InColor='y'/'n') на същото студио.


-- Имената и адресите на студиата, които са работили с по-малко от 5 различни филмови звезди. Студиа, за които няма
--посочени филми или има, но не се знае кои актьори са играли в тях, също да бъдат изведени. Първо да се изведат
--студиата, работили с най-много звезди. Напр. ако студиото има два филма, като в първия са играли A, B и C, а във
--втория - C, D и Е, то студиото е работило с 5 звезди общо


--● За всеки кораб, който е от клас с име, несъдържащо буквите i и k, да се изведе името на кораба и през коя година е
--пуснат на вода (launched). Резултатът да бъде сортиран така, че първо да се извеждат най-скоро пуснатите кораби.


-- Да се изведат имената на всички битки, в които е повреден (damaged) поне един японски кораб.


-- Да се изведат имената и класовете на всички кораби, пуснати на вода една година след кораба 'Rodney' и броят на
--оръдията им е по-голям от средния брой оръди я на класовете, произвеждани от тяхната страна.

---Да се изведат американските класове, за които всички техни кораби са пуснати на вода в рамките на поне 10 години
--(например кораби от клас North Carolina са пускани в периода от 1911 до 1941, което е повече от 10 години, докато
--кораби от клас Tennessee са пуснати само през 1920 и 1921 г.).


-- За всяка битка да се изведе средният брой кораби от една и съща държава (например в битката при Guadalcanal са
--участвали 3 американски и един японски кораб, т.е. средният брой е 2).


--За всяка държава да се изведе: броят на корабите от тази държава; броя на битките, в които е участвала; броя на
--битките, в които неин кораб е потънал ('sunk') (ако някоя от бройките е 0 – да се извежда 0).

-- За всеки актьор/актриса изведете броя на различните студиа, с които са записвали филми.


--За всеки актьор/актриса изведете броя на различните студиа, с които са записвали филми, включително и за тези, за
--които нямаме информация в какви филми са играли.


-- Изведете имената на актьорите, участвали в поне 3 филма след 1990 г.

--- Да се изведат различните модели компютри, подредени по цена на най-скъпия конкретен компютър от даден модел