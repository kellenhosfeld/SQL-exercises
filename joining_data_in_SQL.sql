-- How many rows are in the athletes table? How many distinct athlete ids?

SELECT COUNT(id), COUNT(DISTINCT id)
FROM athletes;

-- Which years are represented in the summer_games, winter_games, and country_stats tables?

SELECT DISTINCT year
FROM summer_games;

SELECT DISTINCT year
FROM winter_games;

SELECT DISTINCT year
FROM country_stats;

SELECT DISTINCT country_id, sg.year AS summer, wg.year AS winter, cs.year AS country_stats
FROM summer_games sg
INNER JOIN winter_games wg
	USING(country_id)
INNER JOIN country_stats cs
	USING(country_id)
ORDER BY country_id;

-- How many distinct countries are represented in the countries and country_stats table?

SELECT COUNT(DISTINCT id) AS num_countries
FROM countries
	FULL JOIN country_stats ON country_id = id;

-- How many distinct events are in the winter_games and summer_games table?

SELECT COUNT(DISTINCT event) AS num_events
FROM summer_games
	FULL JOIN winter_games USING(event);

-- Count the number of athletes who participated in the summer games for each country. Your output should have country name and number of athletes in their own columns. Did any country have no athletes?

-- It seems like all countries from the countries table had at least one athlete participating in the summer games.

SELECT country, COUNT(DISTINCT athlete_id) AS athlete_count
FROM summer_games
	LEFT JOIN countries ON id = country_id
GROUP BY country
ORDER BY athlete_count;

-- Write a query to list countries by total bronze medals, with the highest totals at the top and nulls at the bottom.

SELECT country_id, COUNT(sg.bronze) + COUNT(wg.bronze) AS num_bronze_medals
FROM summer_games AS sg
	FULL JOIN winter_games AS wg
	USING(country_id)
GROUP BY country_id
ORDER BY num_bronze_medals DESC;

-- Adjust the query to only return the country with the most bronze medals

SELECT country_id, COUNT(sg.bronze) + COUNT(wg.bronze) AS num_bronze_medals
FROM summer_games AS sg
	FULL JOIN winter_games AS wg
	USING(country_id)
GROUP BY country_id
ORDER BY num_bronze_medals DESC
LIMIT 1;

-- Calculate the average population in the country_stats table for countries in the winter_games. This will require 2 joins.
	-- First query gives you country names and the average population
	-- Second query returns only countries that participated in the winter_games

SELECT country, AVG(CAST(pop_in_millions AS numeric)) AS avg_pop_in_millions
FROM country_stats AS cs
INNER JOIN countries AS c
ON cs.country_id = id
INNER JOIN winter_games AS wg
ON id = wg.country_id
GROUP BY country;

-- Identify countries where the population decreased from 2000 to 2006
SELECT c.country, year, pop_in_millions
FROM country_stats
FULL JOIN  countries c
ON country_id = id
WHERE year LIKE '2000%' OR year LIKE '2006%';

SELECT * FROM country_stats WHERE year = '2000' OR year = '2006';

SELECT * FROM country_stats;

SELECT country_id, cs00.pop_in_millions AS pop_2000, cs00.year, cs06.pop_in_millions AS pop_2006, cs06.year
FROM country_stats AS cs00
	INNER JOIN country_stats AS cs06
	USING(country_id)
WHERE cs00.year = '2000-01-01' AND cs06.year = '2006-01-01'
AND CAST(cs00.pop_in_millions AS NUMERIC) > CAST(cs06.pop_in_millions AS NUMERIC);