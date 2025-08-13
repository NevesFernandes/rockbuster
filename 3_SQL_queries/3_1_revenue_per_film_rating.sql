SELECT rating, COUNT(DISTINCT film.film_id), 
SUM(payment.amount) AS rating_total_revenue, 
ROUND((SUM(payment.amount)/COUNT(DISTINCT film.film_id)),2) AS rating_avg_revenue
FROM film
INNER JOIN inventory ON film.film_id = inventory.film_id
INNER JOIN rental ON inventory.inventory_id = rental.inventory_id 
INNER JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY 1
ORDER BY 3 DESC