use movies;
-- Зад. 1. а) Да се направи така, че да не може два филма да имат еднаква дължина.

alter table movie
add constraint unique_length unique(length);
-- горното няма да работи, ако вече има два филма с еднаква дължина
-- б) Да се направи така, че да не може едно студио да има два филма с еднаква дължина
alter table movie
add contrainst unique_movie_length unique(length, studioName)

-- Зад. 2. Изтрийте ограниченията от първа задача от Movie.

alter table movie
drop constraint unique_length

alter table movie
drop constraint unique_movie_length


