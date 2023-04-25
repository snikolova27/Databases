use movies;
/*
Да се изведе статистика
за броя филмови
звезди, родени в
следните периоди:
– Преди 1960
– През 60-те
– През 70-те
– През и след 1980
Таблицата да има две
колони – период (напр.
‘60s’) и брой родени.

*/

select * from moviestar;

select case 
	when year(birthdate) >= 1960 and year(birthdate) < 1970 then '60s'
	when year(birthdate) >= 1970 and year(birthdate) < 1980 then '70s'
	when year(birthdate) >= 1980 then '80s and later'
	else 'before 1960'
	end as periods, count(*) as count_per_period
from moviestar
group by case 
when year(birthdate) >= 1960 and year(birthdate) < 1970 then '60s'
	when year(birthdate) >= 1970 and year(birthdate) < 1980 then '70s'
	when year(birthdate) >= 1980 then '80s and later'
	else 'before 1960'
	end;
