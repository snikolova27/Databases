use movies;
/*
1. Напишете заявка, която за всеки филм,
по-дълъг от 120 минути, извежда
заглавие, година, име и адрес на студио
*/

SELECT title, year, name, address FROM movie m
LEFT JOIN studio ON studioname = name 
WHERE m.length > 120;

/*
2. Напишете заявка, която извежда името
на студиото и имената на актьорите,
участвали във филми, произведени от
това студио, подредени по име на студио.
*/
SELECT DISTINCT studioname, starname FROM movie
JOIN starsin ON title = movietitle and year = movieyear
ORDER BY studioname;

/*
. Напишете заявка, която извежда имената
на продуцентите на филмите, в които е
играл Harrison Ford.
*/
SELECT distinct name FROM MOVIEEXEC
JOIN (select * from STARSIN
		join movie on MOVIETITLE = title and MOVIEYEAR = YEAR
		where starname = 'Harrison Ford') t1
	ON CERT= PRODUCERC;

/*
4. Напишете заявка, която извежда имената
на актрисите, играли във филми на MGM.
*/ 
SELECT distinct name FROM MOVIESTAR
JOIN (SELECT * FROM STARSIN	
	JOIN MOVIE ON MOVIETITLE=TITLE AND MOVIEYEAR=YEAR ) movies 
		on NAME = STARNAME AND GENDER='F' AND STUDIONAME='MGM';

/*
5. Напишете заявка, която извежда името
на продуцента и имената на филмите,
продуцирани от продуцента на ‘Star
Wars’
*/
SELECT DISTINCT  prods.name, m1.TITLE FROM	MOVIE m1
JOIN movie m2 on m1.PRODUCERC = m2.PRODUCERC
JOIN MOVIEEXEC prods ON m2.PRODUCERC = CERT
WHERE m2.title = 'Star Wars'; 
        
/*
6. Напишете заявка, която извежда имената
на актьорите, които не са участвали в
нито един филм. 
*/

SELECT NAME FROM MOVIESTAR
WHERE NAME NOT IN (SELECT STARNAME FROM STARSIN);