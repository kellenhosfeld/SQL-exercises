SELECT *
FROM data_analyst_jobs
LIMIT 5;

-- Question: List all jobs with salaries over $60k
SELECT *
FROM data_analyst_jobs
WHERE review_count > 50
ORDER BY review_count DESC;