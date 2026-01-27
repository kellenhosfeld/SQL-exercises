-- How many counties are represented? How many companies?

SELECT COUNT(DISTINCT county), COUNT(DISTINCT company)
FROM ecd;

-- How many companies did not get ANY Economic Development grants (ed) for any of their projects?

SELECT COUNT(DISTINCT company)
FROM ecd
WHERE ed IS NULL;

-- What is the total capital_investment, in millions, when there was a grant received from the fjtap? Call the column fjtap_cap_invest_mil.

SELECT SUM(capital_investment) / 1000000 AS fjtap_cap_invest_mil
FROM ecd
WHERE fjtap IS NOT NULL;

--What is the average number of new jobs for each county_tier?

SELECT AVG(new_jobs)
FROM ecd
GROUP BY county_tier;

-- How many companies are LLCs? Call this value llc_companies.

SELECT COUNT(DISTINCT company) AS llc_companies
FROM ecd
WHERE UPPER(company) LIKE '%LLC%';


