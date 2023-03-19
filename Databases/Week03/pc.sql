use pc;
-- 2.1.
select distinct maker
from product
where model in (select model
from pc
where speed >= 500);

-- 2.2.
select *
from laptop
where speed < all (select speed
from pc);
-- all - по-бавни от всички компютри,
-- any - по-бавни от поне един комп.

-- 2.3.
select distinct model
from (            select model, price
        from pc
    union all
        select model, price
        from laptop
    union all
        select model, price
        from printer) AllProducts
where price >= all (    select price
    from pc
union all
    select price
    from laptop
union all
    select price
    from printer);

-- 2.4.
select distinct maker
from product
where model in (select model
from printer
where color = 'y' and price <= all (select price
    from printer
    where color = 'y'));

-- 2.5.
-- първи вариант - с прости (некорелативни) подзаявки:
select distinct maker
from product
where model in (select model
from pc
where ram <= all (select ram
    from pc)
    and speed >= all (select speed
    from pc
    where ram <= all (select ram
    from pc)));

-- вариант с корелативна подзаявка - по-ефективен:
select distinct maker
from product
where model in (select model
from pc p1
where ram <= all (select ram
    from pc)
    and speed >= all (select speed
    from pc p2
    where p1.ram = p2.ram));
