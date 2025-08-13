/*
1 - For this analysis, I removed NULL return_date (183 out of 15861 total rentals)
2 - cte_hourlyspan was separated to produce one single result for the full 
hourlyspan in analysis
*/


WITH cte_copies_occupation AS (
SELECT i.inventory_id, f.film_id, f.title,
24 * EXTRACT(DAY FROM SUM(r.return_date - r.rental_date)) + EXTRACT(HOUR FROM SUM(return_date - rental_date)) AS total_rentals_duration_in_hours
FROM inventory i
INNER JOIN rental r ON i.inventory_id = r.inventory_id
INNER JOIN film f ON f.film_id = i.film_id
WHERE return_date IS NOT NULL
GROUP BY 1, 2, 3
ORDER BY 4
), cte_hourlyspan AS (
SELECT 24 * EXTRACT(DAY FROM (MAX(return_date) - MIN(rental_date))) + EXTRACT(HOUR FROM (MAX(return_date) - MIN(rental_date))) AS hourlyspan
FROM rental
)
SELECT cte_copies_occupation.*,
ROUND(((100*total_rentals_duration_in_hours/hourlyspan)),2) AS percentual_occupation_ratio
FROM cte_copies_occupation, cte_hourlyspan
ORDER BY 5 DESC


