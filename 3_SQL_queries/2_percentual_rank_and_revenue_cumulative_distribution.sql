WITH cte_film_revenue AS (
SELECT film.title AS film_title, SUM(payment.amount) AS film_revenue,
PERCENT_RANK() OVER(ORDER BY SUM(payment.amount)) AS percentual_film_rank
FROM film
INNER JOIN inventory ON film.film_id = inventory.film_id
INNER JOIN rental ON rental.inventory_id = inventory.inventory_id
INNER JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY 1
ORDER BY 2 DESC
), cte_total_revenue AS(
SELECT SUM(payment.amount) AS total_revenue FROM payment)
SELECT film_title, film_revenue, 
ROUND( CAST(percentual_film_rank as numeric), 4) AS film_percentual_position, 
SUM(film_revenue) OVER(ORDER BY film_revenue) AS running_total, 
ROUND(((SUM(film_revenue) OVER(ORDER BY film_revenue))/total_revenue),4) AS percentual_cumulative_revenue
FROM cte_film_revenue, cte_total_revenue
ORDER BY 2 DESC

