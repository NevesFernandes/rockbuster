SELECT c.name AS film_category, 
COUNT(DISTINCT f.film_id) AS count_of_films
FROM film f
INNER JOIN inventory i ON f.film_id = i.film_id
INNER JOIN film_category fc ON f.film_id = fc.film_id
INNER JOIN category c ON fc.category_id = c.category_id
GROUP BY 1
ORDER BY 2 DESC