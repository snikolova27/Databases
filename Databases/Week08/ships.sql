use ships;

begin transaction;

-- 3.1. Два британски бойни кораба от класа Nelson - Nelson и Rodney - са
-- били пуснати на вода едновременно през 1927 г. Имали са девет
-- 16-инчови оръдия (bore) и водоизместимост от 34 000 тона (displacement).
-- Добавете тези факти към базата от данни.
insert into classes 
values('Nelso', 'bb', 'Gt.Britain',9,16,34000);

insert into ships
values('Nelson', 'Nelson',1927);

insert into ships
values('Rodney', 'Nelson', 1927);

-- 3.2. Изтрийте от Ships всички кораби, които са потънали в битка.
delete from ships 
where name in (select * from outcomes
				where result='sunk');

				
-- 3.3. Променете данните в релацията Classes така, че калибърът (bore) да се измерва
-- в сантиметри (в момента е в инчове, 1 инч ~ 2.5 см) и водоизместимостта
-- да се измерва в метрични тонове (1 м.т. = 1.1 т.)
update classes
set bore = bore * 2.5, DISPLACEMENT = DISPLACEMENT * 1.1;



-- 3.4. Изтрийте всички класове, от които има по-малко от три кораба.
-- заб.: може да има класове без кораби
delete from classes
where class not in  (select class from ships
				group by class
				having count(*) >= 3);


-- 3.5. Променете калибъра на оръдията и водоизместимостта на класа 
-- Iowa, така че да са същите като тези на класа Bismarck
update classes 
set bore = (select bore from classes where class='Bismarck'),
	displacement = (select displacement from classes where class = 'Bismarck')
where class = 'Iowa';
rollback