use ships;

/**
1. Дефинирайте изглед BritishShips, който извежда за всеки
британски кораб неговия клас, тип, брой оръдия, калибър,
водоизместимост и годината, в която е пуснат на вода.

**/
select * from classes

create view BritishShips as
	select classes.class, type, numguns,displacement, bore,launched from classes
	join ships on classes.class = ships.class
	where country = 'Gt.Britain'

select * from BritishShips

/**
2. Напишете заявка, която използва изгледа от предната
задача, за да покаже броя оръдия и водоизместимост на
британските бойни кораби (type = 'BB'), пуснати на вода
преди 1919.

**/

select numguns, displacement from BritishShips
where type='BB' and launched < 1919;

/**
3. Напишете съответната SQL заявка, реализираща задача 2,
но без да използвате изглед.

**/

select numguns, displacement from classes
join ships on ships.class = classes.class
where country='Gt.Britain' and type='BB' and launched < 1919;

/**
4. Средната стойност на displacement за най-тежките класове
кораби от всяка страна.
**/
select c1.country, avg(c1.displacement) as avg_displacement 
from classes c1
where c1.bore = (select max(c2.bore) from classes c2
				where c2.country = c1.country)
group by c1.country


/** 
5. Създайте изглед за всички потънали кораби по битки.
**/

create view sunk_battles_ships
as 
select battle, ship
from outcomes
where result = 'sunk';

select * from sunk_battles_ships;

/**
6. Въведете кораба California като потънал в битката при
Guadalcanal чрез изгледа от задача 5. За целта задайте
подходяща стойност по премълчаване на колоната result от
таблицата Outcomes.
**/


alter table outcomes
add constraint def_result 
default 'sunk' for result

insert into sunk_battles_ships(battle, ship)
values('Guadalcanal', 'California')

select * from outcomes

/** 
7. Създайте изглед за всички класове с поне 9 оръдия.
Използвайте WITH CHECK OPTION. Опитайте се да
промените през изгледа броя оръдия на класа Iowa
последователно на 15 и на 5.

**/

create view min_9_guns
as
select * from classes
where numguns >= 9
with check option

select * from min_9_guns

update min_9_guns
set numguns = 5
where class= 'Iowa'

/** 8. Променете изгледа от задача 7, така че броят оръдия да
може да се променя без ограничения.
**/

alter view min_9_guns
as
select * from classes
where numguns >= 9

select * from min_9_guns

update min_9_guns
set numguns = 5
where class= 'Iowa'

/** 
9. Създайте изглед с имената на битките, в които са участвали
поне 3 кораба с под 9 оръдия и от тях поне един е бил
увреден
**/
create view three_ships 
as
select name from battles b 
join outcomes o on o.battle = b.name
where b.name in (select battle from outcomes
					group by battle having count (*) >= 3)
		and o.ship in (select name from ships s
						join classes c on c.class =s.class
						where numguns < 9)
		and b.name in (select battle from outcomes 
						where result='damaged')

select * from three_ships

