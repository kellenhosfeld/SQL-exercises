-- Find which county had the most months with unemployment rates above the state average:

-- Write a query to calculate the state average unemployment rate.

SELECT AVG(value)
FROM unemployment;

-- Use this query in the WHERE clause of an outer query to filter for months above the average.

SELECT *
FROM unemployment
WHERE value > (SELECT AVG(value)
		FROM unemployment)
ORDER BY year, period_name;

-- Use Select to count the number of months each county was above the average. Which county had the most?

SELECT county, COUNT(period_name) AS months_above_avg
FROM unemployment
WHERE value > (SELECT AVG(value) FROM unemployment)
GROUP BY county
ORDER BY months_above_avg DESC;

-- Find the average number of jobs created for each county based on projects involving the largest capital investment by each company:

-- Write a query to find each company’s largest capital investment, returning the company name along with the relevant capital investment amount for each.

SELECT company, MAX(capital_investment) AS max_investment
FROM ecd
GROUP BY company
ORDER BY max_investment DESC;

-- Use this query in the FROM clause of an outer query, alias it, and join it with the original table.
-- Use Select * in the outer query to make sure your join worked properly

SELECT *
FROM (SELECT company, MAX(capital_investment) AS max_investment
		FROM ecd
		GROUP BY company) AS max_investment_per_company
INNER JOIN ecd
ON (max_investment_per_company.company = ecd.company) AND (max_investment_per_company.max_investment = ecd.capital_investment)
ORDER BY max_investment DESC;

-- Adjust the SELECT clause to calculate the average number of jobs created by county.

SELECT 
	county,
	ROUND(AVG(new_jobs), 2) AS avg_new_jobs
FROM (SELECT 
		company, 
		MAX(capital_investment) AS max_investment
		FROM ecd
		GROUP BY company) AS max_investment_per_company
INNER JOIN ecd
ON (max_investment_per_company.company = ecd.company) AND (max_investment_per_company.max_investment = ecd.capital_investment)
GROUP BY county;