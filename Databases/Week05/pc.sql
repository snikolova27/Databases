use pc;

--1. Напишете заявка, която извежда средната честота на процесорите на
--компютрите.

select AVG(speed) AS 'avg speed' from pc;

--2. Напишете заявка, която за всеки производител извежда средния
--размер на екраните на неговите лаптопи

select maker, avg(screen) as 'avg screen' from product
join laptop on product.model = laptop.model
group by maker;

--3. Напишете заявка, която извежда средната честота на лаптопите с
--цена над 1000

select avg(speed) as 'avg speed of laptops with price>1000' from laptop
where price > 1000;

-- 4. Напишете заявка, която извежда средната цена на компютрите,
-- произведени от производител ‘A’

select avg(price) as 'avg price for maker A' from pc
join product on pc.model = product.model and product.maker = 'A';

-- 5. Напишете заявка, която извежда средната цена на компютрите и
-- лаптопите на производител ‘B’ (едно число)

select avg(price) as 'avg price of pcs and laptops from maker B' from
	(select price from product p join pc on pc.model=p.model where maker='B'
		union all
		select price from product p join laptop on laptop.model = p.model where maker='B') allPrices;

-- 6.Напишете заявка, която извежда средната цена на компютрите
-- според различните им честоти на процесорите


select avg(price) as 'avg price by speed', speed from pc
group by speed;

-- 7. Напишете заявка, която извежда производителите, които са
-- произвели поне по 3 различни модела компютъра

select maker from product
where type = 'PC'
group by maker having count(*) >= 3;

-- 8. Напишете заявка, която извежда производителите на компютрите с
-- най-висока цена

select maker from product
join pc on product.model = pc.model
where price = (select max(price) from pc);

-- 9. Напишете заявка, която извежда средната цена на компютрите за
-- всяка честота, по-голяма от 800 MHz

select avg(price) as 'avg price for pcs with speed > 800', speed from pc
where speed > 800
group by speed;

--10. Напишете заявка, която извежда средния размер на диска на тези
--компютри, произведени от производители, които произвеждат и принтери.

select avg(hd) from pc
join product on product.model = pc.model
where maker in (select maker product where type='Printer');

-- 11.Напишете заявка, която за всеки размер на лаптоп намира
-- разликата в цената на най-скъпия и най-евтиния лаптоп със същия размер.

select screen, max(price) - min(price) as 'diff in price' from laptop
group by screen;
