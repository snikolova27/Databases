use ships;
/*
1. Напишете заявка, която
за всеки кораб извежда
името му, държавата,
броя оръдия и годината
на пускане (launched).
*/

SELECT distinct NAME, COUNTRY, NUMGUNS, LAUNCHED FROM SHIPS
JOIN CLASSES ON ships.CLASS = CLASSES.CLASS;
/*
2. Напишете заявка, която
извежда имената на
корабите, участвали в
битка от 1942 г. 
*/
SELECT distinct OUTCOMES.SHIP FROM OUTCOMES
JOIN BATTLES ON OUTCOMES.BATTLE = BATTLES.NAME AND year(DATE) = 1942;

-- or
select distinct ship
from outcomes
join battles on battle=name
where year(date) = 1942;