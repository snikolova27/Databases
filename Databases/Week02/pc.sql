use pc;

-- Напишете заявка, която извежда производителя и
-- честотата на процесора на лаптопите с размер на
-- харддиска поне 9 GB.
SELECT MAKER, SPEED
FROM LAPTOP
    JOIN product ON PRODUCT.model = LAPTOP.MODEL
WHERE HD >= 9;

-- Напишете заявка, която извежда номер на модел
-- и цена на всички продукти, произведени от
-- производител с име ‘B’. Сортирайте резултата
-- така, че първо да се изведат най-скъпите
-- продукти.


    select p.model, price
    from product p
        join laptop on p.model = laptop.model
    where maker = 'B'

union

    select p.model, price
    from product p
        join pc on p.model = pc.model
    where maker = 'B'

union

    select p.model, price
    from product p
        join printer on p.model = printer.model
    where maker = 'B'

order by price desc;

-- Напишете заявка, която извежда размерите на
-- тези харддискове, които се предлагат в поне два
-- компютъра
select distinct p1.hd
from pc p1
    join pc p2 on p1.hd = p2.hd
        and p1.code <> p2.code


-- Напишете заявка, която извежда всички двойки
-- модели на компютри, които имат еднаква честота
-- на процесора и памет. Двойките трябва да се
-- показват само по веднъж, например ако вече е
-- изведена двойката (i, j), не трябва да се извежда
-- (j, i)
select distinct p1.model, p2.model
from pc p1
    join pc p2 on p1.speed = p2.speed and p1.ram = p2.ram
where p1.model < p2.model;

-- Напишете заявка, която извежда
-- производителите на поне два различни
-- компютъра с честота на процесора поне 500 MHz
SELECT p.maker, *
FROM PRODUCT p, PC
    JOIN PRODUCT on PRODUCT.model = PC.model
WHERE PC.speed >= 500