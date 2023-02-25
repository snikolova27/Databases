use pc;

SELECT
    MODEL,
    SPEED AS 'MHz',
    HD AS 'GB'
FROM
    LAPTOP
WHERE
    PRICE < 1200;

SELECT
    MODEL,
    PRICE * 1.1 AS 'Euros'
FROM
    laptop
ORDER BY
    PRICE;

SELECT
    MODEL,
    PRICE AS 'Dollars'
FROM
    laptop
ORDER BY
    PRICE;

SELECT
    MODEL,
    HD,
    SCREEN
FROM
    laptop
WHERE
    price > 1000;

SELECT
    *
from
    printer
WHERE
    COLOR = 'Y';

SELECT
    MODEL,
    SPEED,
    HD
FROM
    pc
WHERE
    (
        CD = '12x'
        OR CD = '16x'
    )
    AND PRICE < 2000;

SELECT
    CODE,
    MODEL,
    (SPEED + RAM + 10 * SCREEN) AS RATING
from
    laptop
ORDER BY
    RATING DESC,
    CODE;