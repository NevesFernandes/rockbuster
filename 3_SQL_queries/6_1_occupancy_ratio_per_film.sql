/*
1 - For this analysis, I removed NULL return_date (183 out of 15861 total rentals)
2 - cte_hourlyspan was separated to produce one single result for the full 
hourlyspan in analysis
*/

WITH cte_copies_occupancy AS (
SELECT f.title, COUNT(DISTINCT i.inventory_id) AS number_of_copies,
24 * EXTRACT(DAY FROM SUM(r.return_date - r.rental_date)) + EXTRACT(HOUR FROM SUM(return_date - rental_date)) AS total_rentals_duration_in_hours
FROM film f
INNER JOIN inventory i ON f.film_id = i.film_id
INNER JOIN rental r ON i.inventory_id = r.inventory_id
WHERE return_date IS NOT NULL
GROUP BY 1
ORDER BY 3
), cte_hourlyspan AS (
SELECT 24 * EXTRACT(DAY FROM (MAX(return_date) - MIN(rental_date))) + EXTRACT(HOUR FROM (MAX(return_date) - MIN(rental_date))) AS hourlyspan
FROM rental
)
SELECT cte_copies_occupancy.*,
ROUND(((100*total_rentals_duration_in_hours/(number_of_copies*hourlyspan))),2) AS percentual_occupancy_ratio
FROM cte_copies_occupancy, cte_hourlyspan
ORDER BY 4 DESC





