SELECT count(rental_id) AS count_of_rentals, 
MIN(rental_date) AS first_rental, MAX(return_date) AS las_return,
MAX(return_date) - MIN(rental_date) AS time_window
FROM rental
INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
INNER JOIN film ON inventory.film_id = film.film_id
WHERE return_date is not null

/*
removed NULL return_date (183 records)
these are the latest rented movies not yet returned
*/
