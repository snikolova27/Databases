/** Зад.1
За всеки лаптоп да се изведе следната информация: код, модел, производител,
 средната цена на лаптопите със същия диагонал на екрана. Ако даден производител не произвежда лаптопи, 
 за него да се изведе ред в следния формат: null, null, име, 0;

 **/

 use pc;

 select laptop.code, laptop.model,maker, prices.avgprice from product
 left join laptop on product.model = laptop.model and product.type = 'laptop'
  left join (select avg(price) avgprice, screen from laptop group by screen) prices
		on prices.screen = laptop.screen 

/**
Зад.2
За всеки производител, който има поне три произведени лаптопа и чието име е 
различно от ‘A’ да се изведат: 
името на производителя, цената на най-скъпия му лаптоп, 
бройката на всички лаптопи с различни размери екрани.

**/

select maker, max(price) as 'max laptop price', count(distinct(screen)) as 'count unique screens' from product
join laptop on laptop.model = product.model and product.type='laptop'
where maker not like 'A'
group by maker
having count(laptop.model) >= 3

-- Да се изведат кода, модела и цената на всички компютри, чиито:
-- модел не съдържа Х или 2
-- и чиято цена е <=1100
-- Да се изведат във възходящ ред относно цената, по модел
-- 3 зад.
use pc;
select code, model, price from pc
where model not in (select model from pc
			where model like '%X%' or model like '%2%')
and price <= 1100
order by price asc, model
				

/**
Зад.4
Да се изведат моделите, диагоналите на екраните в сантиметри 
и цените на всички лаптопи, 
произведени от производител, който НЕ произвежда цветни принтери 
с неизвестна цена.
Да се включат и лаптопите, чиито производители не произвеждат 
никакви принтери.
Диагоналите в таблицата са в инчове, 1 инч ≈ 2.54 см.
 **/

 select laptop.model, laptop.screen*2.54 as 'screen in cm', laptop.price from laptop
 left join product on product.model = laptop.model and product.type='laptop'
 where product.model not in (select product.model from product
							join printer on product.model=printer.model
							where color='y' and price is null)
		or product.model not in (select product.model from product
							join printer on printer.model = product.model)


