SELECT f.rental_duration, COUNT(DISTINCT f.film_id) AS number_of_films,
SUM(p.amount) AS duration_total_revenue, 
ROUND((SUM(p.amount)/count(distinct f.film_id)),2) AS duration_avg_revenue_per_film,
COUNT(r.rental_id) AS number_of_rentals,
ROUND((SUM(p.amount)/count(r.rental_id)),2) AS duration_avg_revenue_per_rental
FROM film f
INNER JOIN inventory i ON f.film_id = i.film_id
INNER JOIN rental r ON i.inventory_id = r.inventory_id
INNER JOIN payment p ON r.rental_id = p.rental_id
GROUP BY 1
ORDER BY 3 DESC