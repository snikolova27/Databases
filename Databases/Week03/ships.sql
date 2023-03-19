use ships;
-- 3.1.
select distinct country
from classes
where numguns >= all (select numguns
from classes);

-- 3.2.
select name
from ships
where class in (select class
from classes
where bore = 16);

-- 3.3.
select battle
from outcomes
where ship in (select name
from ships
where class = 'Kongo');

-- 3.4. Напишете заявка, която извежда имената на корабите, чиито брой 
-- оръдия е най-голям в сравнение с корабите със същия калибър оръдия (bore).
select name
from ships s
    join classes c on s.class = c.class
where numguns >= all (select numguns
from classes c2
where c2.bore = c.bore);
