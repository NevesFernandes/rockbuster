WITH cte_real_rental_durations AS (
	SELECT date_part('day',date_trunc('day',return_date) - date_trunc('day',rental_date)) AS real_duration,
	COUNT(r.rental_id) AS count_of_rentals, 
	SUM(p.amount) AS duration_total_revenue
	FROM rental r
	INNER JOIN inventory i ON r.inventory_id = i.inventory_id
	INNER JOIN payment p ON r.rental_id = p.rental_id
	WHERE return_date IS NOT NULL
	GROUP BY 1
	ORDER BY 1 DESC
)
SELECT *,
ROUND((duration_total_revenue/count_of_rentals),2) AS duration_avg_revenue_per_rental,
ROUND(duration_total_revenue/CAST(real_duration AS numeric),2) AS duration_avg_revenue_per_day,
ROUND(duration_total_revenue/(count_of_rentals * CAST(real_duration AS numeric)),2) AS duration_avg_revenue_per_rental_per_day
FROM cte_real_rental_durations
WHERE real_duration > 0


/*
removed NULL return_date (183 records)
removed real_duration = 0 (97 records) It was to avoid division by 0.
TO-DO: find a more elegant solution for real_duration problem!!!
*/
