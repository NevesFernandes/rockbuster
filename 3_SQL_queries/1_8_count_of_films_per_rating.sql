SELECT rating AS MPAA_rating, 
COUNT(DISTINCT film.film_id) AS number_of_films
FROM film
INNER JOIN inventory ON film.film_id = inventory.film_id
GROUP BY 1
ORDER BY 2 DESC