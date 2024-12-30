# DPH Helper App (iOS)

![](https://github.com/brucec0des/SQL-Netflix-Project/blob/main/logo.png)

## Overview
This project was developed to help my work associates increase their speed, accuracy, and efficiency in order to ameliorate their metrics. The following README provides a detailed account of the project's objectives, business problems, and solutions.

## Objectives

- Provide guided assistance in reviewing accounts.
- Identify the most common ratings for movies and TV shows.
- List and analyze content based on release years, countries, and durations.
- Explore and categorize content based on specific criteria and keywords.

## Dataset

The data for this project is sourced from the Kaggle dataset:

- **Dataset Link:** [Movies Dataset](https://www.kaggle.com/datasets/shivamb/netflix-shows?resource=download)

## Schema

```sql
DROP TABLE IF EXISTS netflix;
CREATE TABLE netflix
(
    show_id      VARCHAR(6),
    type         VARCHAR(10),
    title        VARCHAR(150),
    director     VARCHAR(210),
    casts        VARCHAR(1000),
    country      VARCHAR(150),
    date_added   VARCHAR(50),
    release_year INT,
    rating       VARCHAR(10),
    duration     VARCHAR(15),
    listed_in    VARCHAR(100),
    description  VARCHAR(250)
);
```

## Business Problems and Solutions

### 1. Count the Number of Movies vs TV Shows

```sql
SELECT
	type,  
	COUNT(*) as total_titles
FROM
	netflix
GROUP BY 
	type;
```

**Objective:** Determine the distribution of content types on Netflix.

### 2. Find the Most Common Rating for Movies and TV Shows

```sql
SELECT
	type,
	rating,
	rating_count
FROM
(
SELECT
	type,
	rating,
	COUNT (*) as rating_count,
	RANK() OVER(PARTITION BY type ORDER BY COUNT(*) DESC) AS ranking
FROM
	netflix
GROUP BY
	type, rating
ORDER BY
	type, rating_count DESC
) AS t1
WHERE ranking = 1;
```

**Objective:** Identify the most frequently occurring rating for each type of content.

### 3. List All Movies Released in a Specific Year (e.g., 2020)

```sql
SELECT
	title,
	release_year
FROM
	netflix
WHERE
	type = 'Movie' AND release_year = 2020
ORDER BY
	title ASC;
```

**Objective:** Retrieve all movies released in a specific year.

### 4. Find the Top 5 Countries with the Most Content on Netflix

```sql
SELECT 
	TRIM(UNNEST((STRING_TO_ARRAY(country, ',')))) AS new_country,
	COUNT(show_id) AS num_of_content
FROM 
	netflix
GROUP BY
	new_country
ORDER BY
	num_of_content DESC
LIMIT 5;
```

**Objective:** Identify the top 5 countries with the highest number of content items.

### 5. Identify the Longest Movie

```sql
SELECT
	type,
	title,
	CAST(TRIM(' min' FROM duration) AS INT) AS runtime
FROM netflix
WHERE type = 'Movie' AND duration IS NOT NULL
ORDER BY runtime DESC
LIMIT 1;
```

**Objective:** Find the movie with the longest duration.

### 6. Find Content Added in the Last 5 Years

```sql
SELECT 
	*
FROM netflix
WHERE
	TO_DATE(date_added, 'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 YEARS';
```

**Objective:** Retrieve content added to Netflix in the last 5 years.

### 7. Find All Movies/TV Shows by Director 'Rajiv Chilaka'

```sql
SELECT
	*
FROM
	netflix
WHERE
	director LIKE '%Rajiv Chilaka%'
ORDER BY
	title;
```

**Objective:** List all content directed by 'Rajiv Chilaka'.

### 8. List All TV Shows with More Than 5 Seasons

```sql
SELECT
	*
FROM netflix
WHERE 
	type = 'TV Show' AND CAST(TRIM(' Seasons' FROM duration) AS INT) > 5;
```

**Objective:** Identify TV shows with more than 5 seasons.

### 9. Count the Number of Content Items in Each Genre

```sql
SELECT
	UNNEST(STRING_TO_ARRAY(listed_in,', ')) as new_genres,
	COUNT (show_id) AS genre_count
FROM
	netflix
GROUP BY
	new_genres
ORDER BY
	genre_count DESC;
```

**Objective:** Count the number of content items in each genre.

### 10.Find each year and the average numbers of content release in India on netflix. 
return top 5 year with highest avg content release!

```sql
SELECT 
	release_year,
	COUNT(*) AS total_releases,
	ROUND(COUNT(*)::numeric/(SELECT COUNT(*) FROM netflix WHERE country = 'India')::numeric * 100, 2) AS average_indian_releases
FROM
	netflix
GROUP BY
	release_year
ORDER BY
	average_indian_releases DESC
LIMIT 5;
```

**Objective:** Calculate and rank years by the average number of content releases by India.

### 11. List All Movies that are Documentaries

```sql
SELECT 
	* 
FROM 
	netflix 
WHERE
	type = 'Movie' AND listed_in iLIKE '%docu%'
ORDER BY
	title;
```

**Objective:** Retrieve all movies classified as documentaries.

### 12. Find All Content Without a Director

```sql
SELECT * FROM netflix WHERE director IS NULL
```

**Objective:** List content that does not have a director.

### 13. Find How Many Movies Actor 'Salman Khan' Appeared in the Last 10 Years

```sql
SELECT 
	* 
FROM 
	netflix 
WHERE 
	type = 'Movie' AND casts ILIKE '%Salman Khan%' AND release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10;
```

**Objective:** Count the number of movies featuring 'Salman Khan' in the last 10 years.

### 14. Find the Top 10 Actors Who Have Appeared in the Highest Number of Movies Produced in India

```sql
SELECT
	UNNEST(STRING_TO_ARRAY(casts,', ')) AS new_actors,
	COUNT(*) AS totals
FROM
	netflix
WHERE
	type = 'Movie' AND country ILIKE '%India%'
GROUP BY
	new_actors
ORDER BY
	totals DESC
LIMIT 10;
```

**Objective:** Identify the top 10 actors with the most appearances in Indian-produced movies.

### 15. Categorize Content Based on the Presence of 'Kill' and 'Violence' Keywords

```sql
WITH new_table
AS
(
SELECT
	*,
	CASE
	WHEN 
		description ILIKE 'kill%' OR description ILIKE '%violen%' THEN 'Bad'
		ELSE 'Good'
	END category
FROM 
	netflix
)
SELECT
	category,
	COUNT(*) AS total_content
FROM new_table
GROUP BY category
```

**Objective:** Categorize content as 'Bad' if it contains 'kill' or 'violence' and 'Good' otherwise. Count the number of items in each category.

## Findings and Conclusion

- **Content Distribution:** The dataset contains a diverse range of movies and TV shows with varying ratings and genres.
- **Common Ratings:** Insights into the most common ratings provide an understanding of the content's target audience.
- **Geographical Insights:** The top countries and the average content releases by India highlight regional content distribution.
- **Content Categorization:** Categorizing content based on specific keywords helps in understanding the nature of content available on Netflix.

This analysis provides a comprehensive view of Netflix's content and can help inform content strategy and decision-making.



## Author - Bruce Harper

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!
