SELECT rental_duration, COUNT(DISTINCT film.film_id) AS film_count 
FROM film
INNER JOIN inventory ON film.film_id = inventory.film_id
GROUP BY 1
ORDER BY 1


