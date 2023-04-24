-- За всеки актьор/актриса изведете броя на
--различните студиа, с които са записвали филми
use movies;
select distinct starname, count(distinct studioname) as 'distinct studios' from movie
join starsin on movie.title = starsin.movietitle and movie.year = starsin.movieyear
group by starname;

-- or
select starname, count(distinct studioname) from starsin 
join movie on movietitle=title and movieyear=year
group by starname;

-- За всеки актьор/актриса изведете броя на
--различните студиа, с които са записвали филми,
--включително и за тези, за които нямаме
--информация в кои филми са играли
select name, count(distinct studioname) from movie
join starsin on movie.title = starsin.movietitle and movie.year = starsin.movieyear
right join moviestar on moviestar.name = starsin.starname
group by name;


-- or
select name, count(distinct studioname) from moviestar
left join starsin on name=starname
left join movie on movietitle=title and movieyear=year
group by name;

-- Изведете имената на актьорите, участвали в поне
--три филма след 1990 г.
select starname from starsin
where movieyear > 1990
group by starname 
having count(*) >= 3;

--Да се изведат различните модели компютри,
--подредени по цена на най-скъпия конкретен
--компютър от даден модел.

use pc;
select model from pc
group by model
order by max(price);