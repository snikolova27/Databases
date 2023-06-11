use pc;

/**
1. Създайте изглед, който
показва кодовете, моделите
и цените на всички лаптопи,
PC-та и принтери. Не
премахвайте повторенията.
**/

create view all_products
as
	select code, model, price from laptop
	union all
	select code, model, price from pc
	union all
	select code, model, price from printer

select * from all_products
drop view all_products
/**
2. Променете изгледа, като
добавите и колона type (PC,
Laptop, Printer)

**/

alter view all_products
as
select code, model, price, 'PC' as type from pc
union all
select code, model, price, 'Laptop' from laptop
union all
select code, model, price, 'Printer' from printer

select * from all_products


/**
3. Променете изгледа, като
добавите и колона speed,
която е NULL за принтерите
**/

alter view all_products
as
select code, model, price, 'PC' as type, speed from pc
union all
select code, model, price, 'Laptop' as type, speed from laptop
union all
select code, model, price, 'Printer', NULL from printer

select * from all_products