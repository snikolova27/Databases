use ships;
/* Намерете
имената на
битките, в които
са участвали
поне 3 кораба с
под 9 оръдия и от
тях поне два са с
резултат ‘ok’.
*/

select * from outcomes;

select battle from outcomes
join ships on outcomes.ship = ships.name
join classes on classes.class = ships.class and numguns <= 9 and result='ok'
group by battle having count(*) >=3

select ship from outcomes
join ships on outcomes.ship = ships.name
join classes on classes.class = ships.class and numguns <= 9 and result='ok';