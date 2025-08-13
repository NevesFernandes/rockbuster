SELECT count(distinct film.film_id) AS count_of_films
FROM film
INNER JOIN inventory ON film.film_id = inventory.film_id