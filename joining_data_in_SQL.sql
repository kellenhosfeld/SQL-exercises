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

-- How many distinct countries are represented in the countries and country_stats table?

SELECT COUNT(DISTINCT id)
FROM countries
	FULL JOIN country_stats ON country_id = id;

-- How many distinct events are in the winter_games and summer_games table?

SELECT COUNT(DISTINCT event)
FROM summer_games
	FULL JOIN winter_games USING(event);

-- Count the number of athletes who participated in the summer games for each country. Your output should have country name and number of athletes in their own columns. Did any country have no athletes?

-- It seems like all countries from the countries table had at least one athlete participating in the summer games.

SELECT country, COUNT(DISTINCT athlete_id) AS athlete_count
FROM summer_games
	LEFT JOIN countries ON id = country_id
GROUP BY country;

-- Write a query to list countries by total bronze medals, with the highest totals at the top and nulls at the bottom.

SELECT country_id, COUNT(bronze)
FROM summer_games
	CROSS JOIN winter_games
-- Adjust the query to only return the country with the most bronze medals


