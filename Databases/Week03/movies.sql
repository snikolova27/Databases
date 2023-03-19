use movies;

-- 1.1.
select name
from moviestar
where gender = 'F' and name in (select name
    from movieexec
    where networth > 10000000);

-- може и select name from movieexec where name in (select name from moviestar...)

-- можеше и с intersect
    (select name
    from moviestar
    where gender = 'F')
intersect
    (select name
    from movieexec
    where networth > 10000000);

-- 1.2.
select name
from moviestar
where name not in (select name
from movieexec);

-- може и с except: select name from moviestar except select name from movieexec;
