﻿use pc;  /* Напишете заявка, която извежда номер на модел, честота  на процесора (speed) и размер на диска (hd) за всички компютри с цена, по-малка от 1200 долара. Задайте псевдоними за атрибутите честота и размер на диска, съответно MHz и GB  */  SELECT MODEL, SPEED AS 'MHz', HD AS 'GB' FROM LAPTOP WHERE PRICE < 1200;  /* Напишете заявка, която извежда моделите и цените в евро на всички лаптопи.  Нека приемем, че в базата цените се съхраняват в долари, а курсът е 1.1 долара за евро. Да се изведат първо най-евтините лаптопи */  SELECT MODEL, PRICE*1.1 AS 'Euros' FROM laptop ORDER BY PRICE;  /* в долари */ SELECT MODEL, PRICE AS 'Dollars' FROM laptop ORDER BY PRICE;  /* Напишете заявка, която извежда номер на модел, размер на паметта и размер на екран за тези лаптопи, чиято цена е по-голяма от 1000 долара */ SELECT MODEL, HD, SCREEN FROM laptop WHERE price > 1000;  /* Напишете заявка, която извежда всички цветни принтери */ SELECT * from printer WHERE COLOR = 'Y';  /*. Напишете заявка, която извежда номер на модел, честота на процесора и размер на диска за тези компютри с DVD 12x или 16x и цена, по-малка от 2000 долара  */  SELECT MODEL, SPEED, HD FROM pc WHERE (CD = '12x' OR CD = '16x') AND PRICE < 2000;  /* Нека рейтингът на един лаптоп се определя по следната формула: честота на процесора + размер на RAM паметта + 10*размер на екрана. Да се изведат кодовете, моделите и рейтингите на всички лаптопи.  Резултатът да бъде подреден така, че първо да бъдат лаптопите с най-висок рейтинг, а продукти с еднакъв рейтинг да бъдат подредени по код */  SELECT CODE, MODEL, (SPEED + RAM + 10*SCREEN) AS RATING from laptop ORDER BY RATING DESC, CODE;