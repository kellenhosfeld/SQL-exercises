-- Winter Olympics Gold Medals

-- Write a CTE called top_gold_winter to find the top 5 gold-medal-winning countries for Winter Olympics.

SELECT 
	country,
	COUNT(gold) AS total_gold
FROM winter_games
INNER JOIN countries
ON winter_games.country_id = countries.id
GROUP BY country
ORDER BY total_gold DESC
LIMIT 5;

-- Query the CTE to select countries and their medal counts where gold medals won are ≥ 5.

WITH top_gold_winter AS (
SELECT 
	country,
	COUNT(gold) AS total_gold
FROM winter_games
INNER JOIN countries
ON winter_games.country_id = countries.id
GROUP BY country
ORDER BY total_gold DESC
LIMIT 5
)
SELECT *
FROM top_gold_winter
WHERE total_gold >= 5;


-- Tall Athletes

-- Write a CTE called tall_athletes to find athletes taller than the average height for athletes in the database.

SELECT *
FROM athletes
WHERE height > (SELECT AVG(height) FROM athletes)
ORDER BY height DESC;

-- Query the CTE to return only female athletes over age 30 who meet the criteria.

WITH tall_athletes AS (
	SELECT *
	FROM athletes
	WHERE height > (SELECT AVG(height) FROM athletes)
)
SELECT name, age, gender, height
FROM tall_athletes
WHERE gender = 'F' AND age > 30;


-- Average Weight of Female Athletes

-- Write a CTE called tall_over30_female_athletes for the results of Exercise 2.
-- Query the CTE to find the average weight of these athletes.

WITH tall_over30_female_athletes AS (
	SELECT *
	FROM athletes
	WHERE height > (SELECT AVG(height) FROM athletes)
	AND gender = 'F' AND age > 30
)
SELECT ROUND(AVG(weight), 2) AS avg_weight
FROM tall_over30_female_athletes;
