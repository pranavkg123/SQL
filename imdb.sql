use imdb;

--#1. Count the total number of records in each table of the database.
SELECT 'Movie' AS Table_Name, COUNT(*) AS Total_Records FROM Movie
UNION ALL
SELECT 'Genre', COUNT(*) FROM Genre
UNION ALL
SELECT 'Director Mapping', COUNT(*) FROM Director_Mapping
UNION ALL
SELECT 'Role Mapping', COUNT(*) FROM Role_Mapping
UNION ALL
SELECT 'Names', COUNT(*) FROM Names
UNION ALL
SELECT 'Ratings', COUNT(*) FROM Ratings;

--#2. Identify which columns in the movie table contain null values. 
SELECT 'title' AS Column_Name, COUNT(*) AS Null_Count FROM Movie WHERE title IS NULL
UNION ALL
SELECT 'year', COUNT(*) FROM Movie WHERE year IS NULL
UNION ALL
SELECT 'duration', COUNT(*) FROM Movie WHERE duration IS NULL
UNION ALL
SELECT 'country', COUNT(*) FROM Movie WHERE country IS NULL
UNION ALL
SELECT 'worlwide_gross_income', COUNT(*) FROM Movie WHERE worlwide_gross_income IS NULL
UNION ALL
SELECT 'languages', COUNT(*) FROM Movie WHERE languages IS NULL
UNION ALL
SELECT 'production_company', COUNT(*) FROM Movie WHERE production_company IS NULL;

--#3. Determine the total number of movies released each year, and analyze how the trend changes month-wise.
SELECT MONTH(date_published) AS month_no, COUNT(id) AS number_of_movies FROM movie 
GROUP BY MONTH(date_published) ORDER BY MONTH(date_published);

--#4. How many movies were produced in either the USA or India in the year 2019?
SELECT COUNT(*) AS no_of_movies from movie where country="USA" or country="India" and year(date_published)=2019;

--#5. List the unique genres in the dataset, and count how many movies belong exclusively to one genre. 
Select DISTINCT genre as Genre,count(*) as no_of_movies from genre GROUP BY(genre) order by count(*) desc;

--#6. Which genre has the highest total number of movies produced?
SELECT genre, COUNT(*) AS movie_count FROM genre GROUP BY genre ORDER BY movie_count DESC LIMIT 1;

--#7. Calculate the average movie duration for each genre.
select g.genre,avg(m.duration) as average_duration from genre g 
join movie m on g.movie_id=m.id GROUP BY genre;

--#8. Identify actors or actresses who have appeared in more than three movies with an average rating below 5. //
SELECT n.name, COUNT(r.movie_id) AS num_movies, AVG(r.avg_rating) AS avg_rating
FROM role_mapping rm
JOIN names n ON rm.name_id = n.id
JOIN ratings r ON rm.movie_id = r.movie_id
WHERE rm.category = 'Actor' 
AND r.avg_rating < 5
GROUP BY n.name
HAVING COUNT(r.movie_id) > 3
ORDER BY num_movies DESC;

--#9. Find the minimum and maximum values for each column in the ratings table, excluding the movie_id column.
SELECT MIN(avg_rating) AS min_rating, MAX(avg_rating) AS max_rating,MIN(total_votes) AS min_votes, MAX(total_votes) AS max_vote,
MIN(median_rating) AS min_median_rating, MAX(median_rating) AS max_median_rating FROM ratings;

--#10.Which are the top 10 movies based on their average rating? 
SELECT m.title, r.avg_rating FROM Movie m
JOIN ratings r ON m.id = r.movie_id
ORDER BY r.avg_rating DESC LIMIT 10;

--#11. Summarize the ratings table by grouping movies based on their median ratings. 
select * from ratings order by median_rating;

--#12. How many movies, released in March 2017 in the USA within a specific genre, had more than 1,000 votes? 
SELECT COUNT(DISTINCT m.id) AS movie_count,m.country AS country
FROM movie m
JOIN ratings r ON m.id = r.movie_id
JOIN genre g ON m.id = g.movie_id
WHERE m.date_published BETWEEN '2017-03-01' AND '2017-03-31'
  AND m.country = 'USA'
  AND g.genre = 'Comedy'
  AND r.total_votes > 1000;
  
--#13. Find movies from each genre that begin with the word “The” and have an average rating greater than 8. 
Select g.genre,m.title from genre g
join movie m on g.movie_id=m.id
join ratings r on g.movie_id=r.movie_id
WHERE m.title like "The%" and r.avg_rating>8
order by g.genre;

--#14. Of the movies released between April 1, 2018, and April 1, 2019, how many received a median rating of 8? 
select count(m.title) as No_of_movies from movie m
join ratings r on m.id=r.movie_id
where date_published BETWEEN '2018-04-01' AND '2018-04-01' and median_rating=8;

--#15. Do German movies receive more votes on average than Italian movies? 
SELECT m.country, AVG(r.total_votes) AS avg_votes
FROM movie m
JOIN ratings r ON m.id = r.movie_id
WHERE m.country IN ('Germany', 'Italy')
GROUP BY m.country
ORDER BY avg_votes DESC;

--#16. Identify the columns in the names table that contain null values. 
SELECT 'id' AS Column_Name, COUNT(*) AS Null_Count FROM Movie WHERE title IS NULL
UNION ALL
SELECT 'name', COUNT(*) FROM Movie WHERE year IS NULL
UNION ALL
SELECT 'height', COUNT(*) FROM Movie WHERE duration IS NULL
UNION ALL
SELECT 'date_of_birth', COUNT(*) FROM Movie WHERE country IS NULL
UNION ALL
SELECT 'known_for_movies', COUNT(*) FROM Movie WHERE worlwide_gross_income IS NULL;

--#17. Who are the top two actors whose movies have a median rating of 8 or higher? 
SELECT n.name AS actor_name, COUNT(rm.movie_id) AS num_movies FROM role_mapping rm  
JOIN names n ON rm.name_id = n.id   
JOIN ratings r ON rm.movie_id = r.movie_id  
WHERE r.median_rating >= 8 GROUP BY n.name ORDER BY num_movies DESC LIMIT 2;

--#18. Which are the top three production companies based on the total number of votes their movies received?
select m.production_company,r.total_votes from movie m
join ratings r on m.id=r.movie_id
order by r.total_votes desc limit 3;

--#19. How many directors have worked on more than three movies? 
SELECT COUNT(*) AS total_directors FROM 
(SELECT dm.name_id, COUNT(dm.movie_id) AS movie_count FROM director_mapping dm
GROUP BY dm.name_id HAVING COUNT(dm.movie_id) > 3) AS director_counts;

--#20. Calculate the average height of actors and actresses separately. //
SELECT rm.category, AVG(n.height) AS avg_height FROM Role_Mapping rm
JOIN Names n ON rm.name_id = n.id
WHERE rm.category IN ('actor', 'actress') 
AND n.height IS NOT NULL GROUP BY rm.category;

--#21. List the 10 oldest movies in the dataset along with their title, country, and director. 
select m.title,m.country,d.name_id from movie m
join director_mapping d on m.id=d.movie_id
order by m.date_published desc LIMIT 10;

--#22. List the top 5 movies with the highest total votes, along with their genres. 
select g.genre, r.total_votes, m.title from movie m
join genre g on m.id=g.movie_id
join ratings r on m.id=r.movie_id
order by r.total_votes desc limit 5;

--#23. Identify the movie with the longest duration, along with its genre and production company. 
select m.title,g.genre,m.production_company,m.duration from movie m
join genre g on m.id=g.movie_id
order by duration desc limit 1;

--#24. Determine the total number of votes for each movie released in 2018. 
select m.title as Movie,r.total_votes as Total_Votes from movie m
join ratings r on m.id=r.movie_id 
where year(date_published)=2018
order by total_votes desc;

--#25. What is the most common language in which movies were produced?
select count(title) as Count,languages from movie group  by languages order by Count desc limit 1;