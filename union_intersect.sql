-- Find Athletes from Summer or Winter Games
-- Write a query to list all athlete names who participated in the Summer or Winter Olympics. Ensure no duplicates appear in the final table using a set theory clause.

(SELECT name, 'Summer' AS season
FROM athletes
INNER JOIN summer_games
ON id = athlete_id)
UNION
(SELECT name, 'Winter' AS season
FROM athletes
INNER JOIN winter_games
ON id = athlete_id);

-- Find Countries Participating in Both Games

-- Write a query to retrieve country_id and country_name for countries in the Summer Olympics.

SELECT DISTINCT country_id, c.country
FROM summer_games
INNER JOIN countries AS c
ON country_id = id;

-- Add a JOIN to include the country’s 2016 population and exclude the country_id from the SELECT statement.

SELECT DISTINCT c.country, cs.pop_in_millions AS pop_2016
FROM summer_games AS sg
INNER JOIN countries AS c
ON sg.country_id = id
INNER JOIN country_stats AS cs
ON id = cs.country_id
WHERE cs.year = '2016-01-01';

-- Repeat the process for the Winter Olympics.

SELECT DISTINCT c.country, cs.pop_in_millions AS pop_2016
FROM winter_games AS wg
INNER JOIN countries AS c
ON wg.country_id = id
INNER JOIN country_stats AS cs
ON id = cs.country_id
WHERE cs.year = '2016-01-01';

-- Use a set theory clause to combine the results.

(SELECT DISTINCT c.country, cs.pop_in_millions AS pop_2016
FROM summer_games AS sg
INNER JOIN countries AS c
ON sg.country_id = id
INNER JOIN country_stats AS cs
ON id = cs.country_id
WHERE cs.year = '2016-01-01')
UNION
(SELECT DISTINCT c.country, cs.pop_in_millions AS pop_2016
FROM winter_games AS wg
INNER JOIN countries AS c
ON wg.country_id = id
INNER JOIN country_stats AS cs
ON id = cs.country_id
WHERE cs.year = '2016-01-01');

-- Identify Countries Exclusive to the Summer Olympics
-- Return the country_name and region for countries present in the countries table but not in the winter_games table.
-- (Hint: Use a set theory clause where the top query doesn’t involve a JOIN, but the bottom query does.)

(SELECT country, region
FROM countries)
EXCEPT
(SELECT country, region
FROM countries
INNER JOIN winter_games
ON id = country_id);