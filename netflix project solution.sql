--SQL PROJECT

DROP TABLE IF EXISTS netflix;
CREATE TABLE netflix
(
  show_id varchar(255),
  type	VARCHAR(255),
  title	VARCHAR(255),
  director VARCHAR(255),	 
  casts VARCHAR(1000),	
  country VARCHAR(255),
  date_added VARCHAR(255), 
  release_year INT,
  rating VARCHAR(255), 	
  duration VARCHAR(255),
  listed_in	VARCHAR(255),
  description VARCHAR(255)
);

SELECT * FROM netflix;

-- Total number of movies in the dataset
SELECT
	COUNT(*) as total_count
FROM netflix; 

-- 15 Business Problems
-- 1. Count the number of Movies vs TV Shows

SELECT 
	type,
	COUNT(*) as total_content
FROM netflix
GROUP BY type

--2 Find the most common rating for movies and TV shows
SELECT 
	type,
	ranking
FROM
(

	SELECT
		type,
		rating,
		COUNT(*),
		RANK() OVER(PARTITION BY type ORDER BY COUNT(*) DESC) as ranking
	FROM netflix
	GROUP BY 1,2
) as t1
WHERE 
	ranking = 1

/*3. lIST all movies released in a specific year (e.g, 2020)*/
SELECT * FROM netflix
WHERE 
	type = 'Movie'
	AND
	release_year = 2020

-- Find the top 5 countries with the most content on Netflix
SELECT
	UNNEST(STRING_TO_ARRAY(country,',')) as new_country,
	COUNT(show_id) as total_content
FROM netflix
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

--5. Identify the longest movie?
SELECT * FROM netflix
WHERE 
	type = 'Movie'
	AND
	duration = (SELECT MAX(duration) FROM netflix )

--6 Find content added in the last 5 years
SELECT
	*
FROM netflix
WHERE TO_DATE(date_added, 'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years'

--7. Find all the movies/TV shows by director 'Rajiv Chilaka'

SELECT * FROM netflix
WHERE director = 'Rajiv Chilaka' 

--8. List all Tv shows with more than 5 season
SELECT * FROM netflix
WHERE 
	type = 'TV shows'
	AND
	SPLIT_PART(duration, '',1)::numeric > 5


	













