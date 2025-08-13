SELECT f.rental_rate, COUNT(DISTINCT f.film_id) AS number_of_films,
COUNT(r.rental_id) AS number_of_rentals,
SUM(p.amount) AS revenue_per_rental_rate, 
ROUND((SUM(p.amount)/COUNT(DISTINCT f.film_id)),2) AS rate_avg_revenue_per_film,
ROUND((SUM(p.amount)/COUNT(r.rental_id)),2) AS rate_avg_revenue_per_rental,
ROUND((SUM(p.amount)/(COUNT(DISTINCT r.rental_id)*rental_rate)),2) AS normalized_avg_revenue_per_rental
FROM film f
INNER JOIN inventory i ON f.film_id = i.film_id
INNER JOIN rental r ON i.inventory_id = r.inventory_id
INNER JOIN payment p ON r.rental_id = p.rental_id
GROUP BY 1
ORDER BY 1 DESC