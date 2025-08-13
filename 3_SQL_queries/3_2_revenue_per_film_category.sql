SELECT c.name AS film_category, 
COUNT(DISTINCT f.film_id) AS count_of_films, 
SUM(p.amount) AS category_revenue, 
ROUND((sum(p.amount)/count(distinct f.film_id)),2) AS category_avg_revenue
FROM film f
INNER JOIN inventory i ON f.film_id = i.film_id
INNER JOIN rental r ON i.inventory_id = r.inventory_id
INNER JOIN payment p ON r.rental_id = p.rental_id
INNER JOIN film_category fc ON f.film_id = fc.film_id
INNER JOIN category c ON fc.category_id = c.category_id
GROUP BY 1
HAVING COUNT(DISTINCT f.film_id) > 1 /*to filter Crime category with only 1 film*/
ORDER BY 3 DESC