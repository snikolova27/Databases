USE SHIPS;
-- - Напишете заявка, която извежда името
-- на корабите, по-тежки (displacement) от
-- 35000.

SELECT NAME
FROM SHIPS
    JOIN CLASSES ON CLASSES.CLASS = SHIPS.CLASS
WHERE DISPLACEMENT > 35000;

-- - Напишете заявка, която извежда
-- имената, водоизместимостта и броя
-- оръдия на всички кораби, участвали в
-- битката при Guadalcanal.

select name, displacement, numguns
from outcomes
    join ships on ship = name
    join classes on ships.class = classes.class
where battle = 'Guadalcanal';


-- - Напишете заявка, която извежда
-- имената на тези държави, които имат
-- класове кораби от тип ‘bb’ и ‘bc’
-- едновременно
    select country
    from classes
    where type = 'bb'

intersect

    select country
    from classes
    where type = 'bc';

-- - Напишете заявка, която извежда
-- имената на тези кораби, които са били
-- повредени в една битка, но по-късно са
-- участвали в друга битка

select distinct o1.ship
from outcomes o1
    join battles b1 on o1.battle = b1.name
    join outcomes o2 on o1.ship = o2.ship
    join battles b2 on o2.battle = b2.name
where o1.result = 'damaged' and b1.date < b2.date;