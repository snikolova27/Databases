use movies;

/**
1. Да се добави информация за
актрисата Nicole Kidman. За
нея знаем само, че е родена
на 20-и юни 1967.
**/

begin transaction;
select * from MOVIESTAR;

INSERT INTO MOVIESTAR(NAME,gender, BIRTHDATE)
VALUES('Nicole Kidman', 'F','1967-06-20');

select * from MOVIESTAR;

/**
2. Да се изтрият всички
продуценти с печалба
(networth) под 10 милиона.) под 10 милиона.
**/
select * from MOVIEEXEC;

DELETE FROM MOVIEEXEC
WHERE NETWORTH < 10000000;

select * from MOVIEEXEC;

/**
3. Да се изтрие информацията
за всички филмови звезди, за
които не се знае адресът.
**/

select * from MOVIESTAR;

delete from MOVIESTAR
where ADDRESS is null;

select * from MOVIESTAR;
/**
4. Да се добави титлата „Pres.“ Pres.“
пред името на всеки
продуцент, който е и
президент на студио.
**/

SELECT * FROM MOVIEEXEC;

update MOVIEEXEC
set name = 'Pres. ' + name
where CERT in (select PRESC from studio);

SELECT * FROM MOVIEEXEC;
rollback