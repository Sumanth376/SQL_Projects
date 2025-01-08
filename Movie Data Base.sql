CREATE DATABASE MOVIE_DB;
USE MOVIE_DB;
#i. Write a SQL query to find when the movie 'American Beauty' released. Return movie release year.
SELECT MOV_TITLE,MOV_YEAR FROM MOVIE WHERE MOV_TITLE="AMERICAN BEAUTY";
#ii. Write a SQL query to find those movies, which were released before 1998. Return movie title.
SELECT MOV_TITLE,MOV_YEAR FROM MOVIE WHERE MOV_YEAR < "1998";
#iii. Write a query where it should contain all the data of the movies which were released after 1995 and their movie duration was greater than 120.
SELECT * FROM MOVIE WHERE MOV_YEAR <1995 AND MOV_TIME >120;
#iv. Write a query to determine the Top 7 movies which were released in United Kingdom. Sort the data in ascending order of the movie year.
SELECT * FROM MOVIE  WHERE MOV_REL_COUNTRY ="UK"  ORDER BY MOV_YEAR ASC LIMIT 7;
#v. Set the language of movie language as 'Chinese' for the movie which has its existing language as Japanese and the movie year was 2001.
UPDATE MOVIE SET MOV_LANG ="CHINEES" WHERE MOV_LANG="JAPANESE" AND MOV_YEAR="2001";
#vi. Write a SQL query to find name of all the reviewers who rated the movie 'Slumdog Millionaire'.
SELECT * FROM MOVIE M INNER JOIN RATINGS R USING(MOV_ID)
INNER JOIN REVIEWER RE USING (REV_ID)
WHERE MOV_TITLE="SLUMDOG MILLIONAIRE";
#WRITE A QUERRY TO PRINT THE MOVIE DETAILS WHO HAS THIRD HEIGHEST NO OF RATINGS ALSO DISPLAY THE ACTOR DETAILS
SELECT * FROM (
SELECT CONCAT(ACT_FNAME," ",ACT_LNAME)AS ACTOR_NAME,
M.MOV_TITLE,NUM_O_RATINGS,DENSE_RANK() OVER(ORDER BY NUM_O_RATINGS DESC)AS DRNK
FROM MOVIE AS M 
INNER JOIN RATINGS R USING (MOV_ID)
INNER JOIN CAST C USING(MOV_ID)INNER JOIN ACTOR A USING(ACT_ID))AS T WHERE DRNK=3;
#vii. Write a query which fetch the first name, last name & role played by the actor where output should all exclude Male actors. CAST ACTOR 
select a.act_fname,a.act_lname, c.role from actor a join cast c using(act_id)
where a.act_gender ="M";
SELECT CONCAT(ACT_FNAME," ",ACT_LNAME) AS FULL_NAME,ROLE FROM ACTOR AS A INNER JOIN  CAST C
 USING (ACT_ID)  WHERE ACT_GENDER !=("M") ;
SELECT CONCAT(ACT_FNAME, ' ', ACT_LNAME) AS FULL_NAME, ROLE FROM ACTOR AS A INNER JOIN CAST C 
USING (ACT_ID) WHERE ACT_GENDER <> 'M';

#viii. Write a SQL query to find the actors who played a role in the movie 'Annie Hall'.Fetch all the fields of actor table. (Hint: Use the IN operator).ACTOR,MOVIE,ROLE
SELECT concat(act_fname," ",act_lname) as full_name,role,mov_title FROM actor a inner join cast c using(act_id)
 inner join movie m using(mov_id) where mov_title = "annie hall";
#ix. Write a SQL query to find those movies that have been released in countries otherthan the United Kingdom. Return movie title, 
#movie year, movie time, and date ofrelease, releasing country.
select mov_title,mov_year,mov_time,mov_dt_rel,mov_rel_country from movie where mov_rel_country != "uk";
#x. Print genre title, maximum movie duration and the count the number of movies in each genre. (HINT: By using inner join)
select gen_title,max(mov_time) as max_duration_movie ,count(mov_id) as count from movie m 
inner join movie_genres mg using(mov_id) inner join genres g using (gen_id) group by gen_title;
#xi. Create a view which should contain the first name, last name, title of the movie & role played by particular actor.
CREATE VIEW SEEEE AS SELECT ACT_FNAME,ACT_LNAME,MOV_TITLE,ROLE FROM MOVIE AS M INNER JOIN CAST AS C USING(MOV_ID)
 INNER JOIN ACTOR AS A USING(ACT_ID) WHERE ACT_FNAME="JAMES" ;
SELECT * FROM SEE;
#xii. Write a SQL query to find the movies with the lowest ratings
select m.mov_title,r.num_o_ratings from movie m join ratings r using(mov_id)
 where r.num_o_ratings = (select min(num_o_ratings) from ratings);
SELECT * FROM movie;
select m.mov_title,r.num_o_ratings from movie m join ratings r using(mov_id) 
where r.num_o_ratings =   (select min(num_o_ratings) from ratings);
SELECT * FROM MOVIE;
SELECT * FROM ACTOR;

#WRITE A SQL QUERRY WHO HAS HIGH EXPERIENCE IN THE DEPARTMENT
USE ORGN_DB;
SELECT * FROM WORKER;
SELECT * FROM ( SELECT FIRST_NAME,DEPARTMENT,JOINING_DATE,dense_rank() OVER(PARTITION BY DEPARTMENT ORDER BY JOINING_DATE ASC) AS DRNK FROM WORKER )AS T WHERE DRNK=1;
DESC WORKER;
ALTER TABLE WORKER MODIFY JOINING_DATE DATETIME;
select * from ratings;
# list all actors(first_name, last_name,gender)
select act_fname,act_lname,act_gender from actor;
#find the movie that were released in 1999
select * from movie where mov_year=1999;
select * from director;
#List the names of all movies directed by a director named 'David Lean'.
select * from movie m inner join movie_direction md on m.mov_id=md.mov_id
 inner join director di on md.dir_id=di.dir_id where dir_fname="David" and dir_lname="Lean";
select * from movie_genres;
select * from movie;
#Find the actors who played the "Boogie Nights"
select mov_title,act_fname,act_lname,mov_year from actor a inner join cast c
on a.act_id=c.act_id inner join movie m on m.mov_id=c.mov_id where mov_title="Boogie Nights";
#Find the genre of the movie 'Blade Runner'.
select * from genres g inner join movie_genres as mg on g.gen_id=mg.gen_id 
inner join movie as m on m.mov_id=mg.mov_id where m.mov_title="Blade Runner";
#Find the total number of ratings for the movie "Blade Runner"'.
SELECT sum(num_o_ratings) from ratings r inner join movie m
 on r.mov_id=m.mov_id where mov_title="Blade Runner";
 select * from ratings;
#List all reviewers who rated 'Boogie Nights'.
select * from reviewer;
select * from reviewer rv inner join ratings r on 
rv.rev_id=r.rev_id inner join movie m on r.mov_id=m.mov_id where mov_title="Boogie Nights";
#Find the average rating of the movie 'The Dark Knight'.
SELECT AVG(rev_stars),mov_title
FROM ratings r
JOIN movie m ON r.mov_id = m.mov_id
WHERE m.mov_title ="Boogie Nights" ;
select * from movie;
#Find the number of movies released in the year 2015.
select count(*) from movie where mov_year=1997;
#List all the actors who have played in a movie with the genre 'Drama'.
SELECT distinct.act_fname, a.act_lname
FROM actor a
JOIN cast c ON a.act_id = c.act_id
JOIN movie_genres mg ON c.mov_id = mg.mov_id
JOIN genres g ON mg.gen_id = g.gen_id
WHERE g.gen_title = 'Drama';
select * from movie;
#Find the directors who have directed movies in the 'Comedy' genre.
select * from director d inner join movie_direction md
on d.dir_id=md.dir_id inner join movie_genres mg on md.mov_id=mg.mov_id inner join genres g 
on g.gen_id=mg.gen_id where gen_title="comedy";
SELECT DISTINCT d.dir_fname, d.dir_lname
FROM director d
JOIN movie_direction md ON d.dir_id = md.dir_id
JOIN movie_genres mg ON md.mov_id = mg.mov_id
JOIN genres g ON mg.gen_id = g.gen_id
WHERE g.gen_title = 'Comedy';
#List all movies that have a runtime greater than 120 minutes.
SELECT mov_title FROM movie WHERE mov_time > 120;
#Find the name and year of release of the longest movie.
select mov_title,mov_year,mov_time from movie order by mov_time desc limit 1;
#List all the genres of the movie 'Boogie Nights'.
SELECT g.gen_title FROM genres g JOIN movie_genres mg ON g.gen_id = mg.gen_id
JOIN movie m ON mg.mov_id = m.mov_id WHERE m.mov_title = SELECT r.rev_name
FROM reviewer r
JOIN ratings rt ON r.rev_id = rt.rev_id
JOIN movie m ON rt.mov_id = m.mov_id
WHERE m.mov_title = 'The Shawshank Redemption';
select * from director;
#List the names of all reviewers who rated 'The Shawshank Redemption'.
SELECT COUNT(*) 
FROM movie_direction md
JOIN director d ON md.dir_id = d.dir_id
WHERE d.dir_fname = 'Kevin' AND d.dir_lname = 'Spacey';
#List the names of all reviewers who rated 'The Shawshank Redemption'.
SELECT r.rev_name FROM reviewer r JOIN ratings rt ON r.rev_id = rt.rev_id
JOIN movie m ON rt.mov_id = m.mov_id WHERE m.mov_title = '';
#Find the movie that received the highest average rating.
SELECT m.mov_title FROM movie m JOIN ratings r ON m.mov_id = r.mov_id
GROUP BY m.mov_title ORDER BY AVG(r.rev_stars) DESC LIMIT 1;
#Find all movies released in the country 'Uk' in 1997.
select * from movie;
SELECT mov_title FROM movie WHERE mov_rel_country = 'Uk' AND mov_year = 1997;
#Find all movies in the 'action" that were released before 1970
select * from movie;
SELECT m.mov_title FROM movie m JOIN movie_genres mg ON m.mov_id = mg.mov_id
JOIN genres g ON mg.gen_id = g.gen_id WHERE g.gen_title = "Action"and mov_year < 19670;
#List the first and last names of all directors who directed movies with the 'Horror' genre.
SELECT DISTINCT d.dir_fname, d.dir_lname
FROM director d
JOIN movie_direction md ON d.dir_id = md.dir_id
JOIN movie_genres mg ON md.mov_id = mg.mov_id
JOIN genres g ON mg.gen_id = g.gen_id
WHERE g.gen_title = 'Horror';
#Find the total number of movies in the 'Action' genre.
SELECT COUNT(*)
FROM movie_genres mg
JOIN genres g ON mg.gen_id = g.gen_id
WHERE g.gen_title = 'Action';
#Find the actors who have starred in movies released in 1977;
SELECT DISTINCT a.act_fname, a.act_lname
FROM actor a
JOIN cast c ON a.act_id = c.act_id
JOIN movie m ON c.mov_id = m.mov_id
WHERE m.mov_year = 1977;
#List all movies that are in the 'Drama' genre and have more than 100000 ratings;
SELECT m.mov_title
FROM movie m
JOIN movie_genres mg ON m.mov_id = mg.mov_id
JOIN genres g ON mg.gen_id = g.gen_id
JOIN ratings r ON m.mov_id = r.mov_id
WHERE g.gen_title = 'Drama'
GROUP BY m.mov_title
HAVING SUM(r.num_o_ratings)> 100000;
#Find the actor who played the most roles in movies.
SELECT a.act_fname, a.act_lname, COUNT(DISTINCT c.mov_id) AS movie_count
FROM actor a
JOIN cast c ON a.act_id = c.act_id
GROUP BY a.act_fname, a.act_lname
ORDER BY movie_count DESC
LIMIT 1;
#List the movies directed by 'Christopher Nolan'.
SELECT m.mov_title
FROM movie m
JOIN movie_direction md ON m.mov_id = md.mov_id
JOIN director d ON md.dir_id = d.dir_id
WHERE d.dir_fname = 'Kevin' AND d.dir_lname = 'Spacey';
#Find the average number of ratings per movie.
SELECT AVG(num_o_ratings) AS avg_ratings_per_movie
FROM (
    SELECT COUNT(*) AS rating_count
    FROM ratings
    GROUP BY mov_id
) AS subquery;
#Find the highest rated movie in the 'Action' genre.
SELECT m.mov_title,m.mov_id
FROM movie m
JOIN movie_genres mg ON m.mov_id = mg.mov_id
JOIN genres g ON mg.gen_id = g.gen_id
JOIN ratings r ON m.mov_id = r.mov_id
WHERE g.gen_title = 'Action'
GROUP BY m.mov_id, m.mov_title 
ORDER BY AVG(r.rev_stars) DESC
LIMIT 1;
#Find the most recent movie directed by 'Kevin Spacey'.
SELECT m.mov_title, m.mov_year
FROM movie m
JOIN movie_direction md ON m.mov_id = md.mov_id
JOIN director d ON md.dir_id = d.dir_id
WHERE d.dir_fname = 'Kevin' AND d.dir_lname = 'Spacey'
ORDER BY m.mov_year DESC
LIMIT 1;
#Find the movies that are rated above 4.5 stars.
SELECT m.mov_title
FROM movie m
JOIN ratings r ON m.mov_id = r.mov_id
WHERE r.rev_stars > 8;
#List the names of the top 5 movies based on ratings.
SELECT m.mov_title
FROM movie m
JOIN ratings r ON m.mov_id = r.mov_id
GROUP BY m.mov_title
ORDER BY AVG(r.rev_stars) DESC
LIMIT 5;
#Find the actors who have appeared in both 'Drama' and 'Comedy' movies.
SELECT a.act_fname, a.act_lname
FROM actor a
JOIN cast c ON a.act_id = c.act_id
JOIN movie_genres mg ON c.mov_id = mg.mov_id
JOIN genres g ON mg.gen_id = g.gen_id
WHERE g.gen_title IN ('Drama', 'Comedy')
GROUP BY a.act_id, a.act_fname, a.act_lname 
HAVING COUNT(DISTINCT g.gen_title) = 2;
#Find the total number of ratings for 'Boogie Nights'
SELECT SUM(r.num_o_ratings) as ratings
FROM ratings r
JOIN movie m ON r.mov_id = m.mov_id
WHERE m.mov_title = 'Boogie Night';
#Find the number of movies each director has directed.
SELECT d.dir_fname, d.dir_lname, COUNT(DISTINCT md.mov_id) AS movie_count
FROM director d
JOIN movie_direction md ON d.dir_id = md.dir_id
GROUP BY d.dir_fname, d.dir_lname;
#Find the average movie length of 'Action' genre films.
SELECT AVG(m.mov_time)
FROM movie m
JOIN movie_genres mg ON m.mov_id = mg.mov_id
JOIN genres g ON mg.gen_id = g.gen_id
WHERE g.gen_title = 'Action';
#Find the director who directed the shortest movie.
SELECT d.dir_fname, d.dir_lname, m.mov_title, m.mov_time
FROM director d
JOIN movie_direction md ON d.dir_id = md.dir_id
JOIN movie m ON md.mov_id = m.mov_id
ORDER BY m.mov_time ASC
LIMIT 1;
#Find the actor who played in the most genres of movies.
SELECT a.act_fname, a.act_lname, COUNT(DISTINCT g.gen_title) AS genre_count
FROM actor a
JOIN cast c ON a.act_id = c.act_id
JOIN movie_genres mg ON c.mov_id = mg.mov_id
JOIN genres g ON mg.gen_id = g.gen_id
GROUP BY a.act_id, a.act_fname, a.act_lname 
ORDER BY genre_count DESC
LIMIT 1;
#Find the name of the movie with the most ratings.
SELECT m.mov_title
FROM movie m
JOIN ratings r ON m.mov_id = r.mov_id
GROUP BY m.mov_title
ORDER BY SUM(r.num_o_ratings) DESC
LIMIT 1;
#List the names of movies that were released after 2015.
SELECT mov_title
FROM movie
WHERE mov_year > 1997;
#Find the name of the movie that has the highest number of actors.
SELECT m.mov_title
FROM movie m
JOIN cast c ON m.mov_id = c.mov_id
GROUP BY m.mov_title
ORDER BY COUNT(c.act_id) DESC
LIMIT 1;
#Find all directors who have directed a movie in the 'Romance' genre.
SELECT DISTINCT d.dir_fname, d.dir_lname
FROM director d
JOIN movie_direction md ON d.dir_id = md.dir_id
JOIN movie_genres mg ON md.mov_id = mg.mov_id
JOIN genres g ON mg.gen_id = g.gen_id
WHERE g.gen_title = 'Romance';
#Find all actors who played in the movie 'The Lion King'.
SELECT a.act_fname, a.act_lname
FROM actor a
JOIN cast c ON a.act_id = c.act_id
JOIN movie m ON c.mov_id = m.mov_id
WHERE m.mov_title = 'Vertigo';
#Find the movies that have a runtime between 100 and 150 minutes.
SELECT mov_title
FROM movie
WHERE mov_time BETWEEN 100 AND 150;
#Find all movies directed by 'Quentin Tarantino'.
SELECT m.mov_title
FROM movie m
JOIN movie_direction md ON m.mov_id = md.mov_id
JOIN director d ON md.dir_id = d.dir_id
WHERE d.dir_fname = 'David' AND d.dir_lname = 'Lean';
select * from director;
#Find the director who directed the most movies in the 'Action' genre.
SELECT d.dir_fname, d.dir_lname, COUNT(DISTINCT md.mov_id) AS movie_count
FROM director d
JOIN movie_direction md ON d.dir_id = md.dir_id
JOIN movie_genres mg ON md.mov_id = mg.mov_id
JOIN genres g ON mg.gen_id = g.gen_id
WHERE g.gen_title = 'Action'
GROUP BY d.dir_fname, d.dir_lname
ORDER BY movie_count DESC
LIMIT 1;
#Find the actors who starred in both 'Horror' and 'Comedy' genres.
SELECT a.act_fname, a.act_lname
FROM actor a
JOIN cast c ON a.act_id = c.act_id
JOIN movie_genres mg ON c.mov_id = mg.mov_id
JOIN genres g ON mg.gen_id = g.gen_id
WHERE g.gen_title IN ('Horror', 'Comedy')
GROUP BY a.act_id, a.act_fname, a.act_lname 
HAVING COUNT(DISTINCT g.gen_title) = 2;
#Find the number of movies each genre has.
SELECT g.gen_title, COUNT(mg.mov_id) AS movie_count
FROM genres g
JOIN movie_genres mg ON g.gen_id = mg.gen_id
GROUP BY g.gen_title;
#Find all actors who starred in movies released in 1978
SELECT DISTINCT a.act_fname, a.act_lname
FROM actor a
JOIN cast c ON a.act_id = c.act_id
JOIN movie m ON c.mov_id = m.mov_id
WHERE m.mov_year = 1978;
#Find all movies that were directed by 'Ridley Scott'.
SELECT m.mov_title
FROM movie m
JOIN movie_direction md ON m.mov_id = md.mov_id
JOIN director d ON md.dir_id = d.dir_id
WHERE d.dir_fname = 'Ridley' AND d.dir_lname = 'Scott';
#Find the actors who have starred in movies that have been rated above 4.0 stars.
SELECT DISTINCT a.act_fname, a.act_lname
FROM actor a
JOIN cast c ON a.act_id = c.act_id
JOIN movie m ON c.mov_id = m.mov_id
JOIN ratings r ON m.mov_id = r.mov_id
WHERE r.rev_stars > 4.0;

