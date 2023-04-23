use pc;
/*
1. За всеки модел компютри да се
изведат цените на различните
конфигурации от този модел.
Ако няма конфигурации за
даден модел, да се изведе
NULL. Резултатът да има две
колони: model и price.
*/

SELECT DISTINCT product.model, price FROM PRODUCT
LEFT JOIN PC ON PRODUCT.MODEL=PC.MODEL 
WHERE product.type='PC';

/*
2. Напишете заявка, която извежда
производител, модел и тип на
продукт за тези производители,
за които съответният продукт не
се продава (няма го в таблиците
PC, Laptop или Printer).
*/
SELECT maker,model,type FROM PRODUCT
WHERE model NOT IN (SELECT MODEL FROM PC)
	AND model NOT IN (SELECT MODEL FROM PRINTER)
	AND model NOT IN (SELECT MODEL FROM LAPTOP);
	
-- or
select maker, p.model, type
from product p
left join  (select model from pc
			union all
			select model from laptop
			union all
			select model from printer) t
	on p.model = t.model
where t.model is null;
