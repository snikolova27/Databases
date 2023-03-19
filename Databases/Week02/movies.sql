use movies;
-- Напишете заявка, която извежда имената на актрисите, участвали в Terms of
-- Endearment

SELECT NAME
from MOVIESTAR
    JOIN STARSIN ON name = STARNAME
    JOIN MOVIE on MOVIETITLE = TITLE
WHERE MOVIETITLE = 'Terms of Endearment'
    AND GENDER = 'F';

--  Напишете заявка, която извежда имената на филмовите звезди,  участвали във филми на студио MGM през
-- 1995 г.

SELECT MOVIESTAR.NAME
FROM MOVIESTAR
    JOIN STARSIN ON name = STARNAME
    JOIN MOVIE ON TITLE = MOVIETITLE
    JOIN STUDIO ON Studio.NAME = STUDIONAME
WHERE MOVIEYEAR = '1995';