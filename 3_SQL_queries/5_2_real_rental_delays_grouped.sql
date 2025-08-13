/*calculations with dates are per calendar day
positive delay means return beyond rental duration defined for the film
negative delay means return in advance to duration defined*/

SELECT COUNT(rental_id) AS count_of_rentals, 
ROUND(CAST(AVG(date_part('day',date_trunc('day',return_date) - date_trunc('day',rental_date))) AS numeric), 1) AS avg_real_duration, 
date_part('day',date_trunc('day',return_date) - date_trunc('day',rental_date)) - film.rental_duration AS delay_in_days, 
ROUND(avg(film.rental_duration),2) AS avg_catalog_rental_duration
FROM rental
INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
INNER JOIN film ON inventory.film_id = film.film_id
WHERE return_date IS NOT NULL
GROUP BY 3
ORDER BY 3 DESC



/*
removed NULL return_date (183 records)
*/
