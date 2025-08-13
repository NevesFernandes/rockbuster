SELECT rental_rate, SUM(payment.amount) AS total_revenue,
COUNT(DISTINCT rental.rental_id) AS rentals_count, 
COUNT(DISTINCT film.film_id) AS film_count, 
COUNT(DISTINCT inventory.inventory_id) AS copies_count, 
ROUND(SUM(payment.amount)/COUNT(DISTINCT film.film_id),2) AS revenue_per_film, 
ROUND(SUM(payment.amount)/COUNT(DISTINCT inventory.inventory_id),2) AS revenue_per_copy,
ROUND(SUM(payment.amount)/COUNT(DISTINCT rental.rental_id),2) AS revenue_per_rental
FROM film
INNER JOIN inventory ON film.film_id = inventory.film_id
INNER JOIN rental ON inventory.inventory_id = rental.inventory_id
INNER JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY rental_rate
