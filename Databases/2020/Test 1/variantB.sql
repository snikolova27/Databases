/**
1. Да се изведат имената и месеците на провеждане на всички битки, 
в които НЕ са участвали стари кораби от неизвестна държава.
Под стари кораби имаме предвид такива, които са построени повече от 4 години 
преди битката. Да се включат и битките,
за които нямаме информация кои кораби са участвали в тях.
**/

use ships;

create view classes_with_no_country
as
select * from classes
where country is null;

create view ships_launched_before_battle
as
select  ships.launched from battles
join outcomes on outcomes.BATTLE = battles.name
join ships on outcomes.SHIP = ships.name
where   year(ships.launched) - year(battles.date) >4  ; 

select * from classes_with_no_country
select * from ships_launched_before_battle
select * from ships
select * from battles

select battles.name, month(battles.date)  as 'month of battle'from battles
left join outcomes on outcomes.battle = battles.name
left join ships on ships.name = outcomes.ship
left join classes on classes.class = ships.class
where classes.class not in (select class from classes
							where country is null) 
and ships.launched not in (select  ships.launched from battles
								join outcomes on outcomes.BATTLE = battles.name
								join ships on outcomes.SHIP = ships.name
								where   year(ships.launched) - year(battles.date) >4   )



-- using views
select battles.name, month(battles.date)  as 'month of battle'from battles
left join outcomes on outcomes.battle = battles.name
left join ships on ships.name = outcomes.ship
left join classes on classes.class = ships.class
where classes.class not in (select class from classes_with_no_country)
and ships.launched not in (select launched from ships_launched_before_battle)
	
/**
2. За всеки японски клас с 2, 3 или 4 кораба да се изведат:
-име;
-последната година, в която е пуснат кораб от този клас (launched);
-брой (различни) битки с участващи кораби от този клас.
**/

select ships.class, max(year(ships.launched)) as 'max year of launched ship' , count(distinct battles.name) as 'distinct battles' from classes
join ships on ships.class = classes.class
join outcomes on outcomes.ship = ships.name
join battles on battles.name = outcomes.battle
where country = 'Japan'
group by ships.class
having count(*) <= 4 

/**
3. Напишете заявка, която извежда имената и броя оръдия (numguns)
на всички японски класове, на които водоизместимостта (displacement) 
е извън интервала [10000, 20000] и името не съдържа буквата K. 
Първо да се изведат класовете с най-малко оръдия, а ако няколко класа
имат еднакъв брой, те да бъдат подредени по име.

**/
select class, numguns from classes
where DISPLACEMENT < 100000 and DISPLACEMENT >20000
	and class not like '%_K_%'
order by numguns desc, class;

/**
4. За всяка битка да се изведе: 
-име на битка; 
-име на кораб, участвал в битката; 
-брой кораби, пуснати на вода в същата година
като текущия кораб.
Ако за дадена битка няма участвали кораби, да се изведе:
име на битка, null, 0. 
Пример:
Битка1 Кораб1 3
Битка1 Кораб2 0
Битка1 Кораб3 2
Битка2 null 0

**/
select battle, outcomes.ship, t1.cntShips from outcomes
left join ships on ships.name = outcomes.ship
left join (select launched, count(ship)  cntShips from outcomes
			join ships on name = ship
			group by launched) t1
		on ships.LAUNCHED = t1.LAUNCHED


/**
4-та, ама малко променена:
За всяка битка и кораб, който е участвал в нея да се изведе следното:
име на битката,
име на кораба,
година на пускане на кораба (launched)
и бройката на всички кораби, които са били пуснати на вода в същата година
като този кораб.

**/


select battle, outcomes.ship, launched, t1.numships from outcomes
join ships on name = ship
join (select launched l, count(ship) numships from outcomes
	join ships on name = ship
	group by launched) t1
on ships.launched = t1.l
