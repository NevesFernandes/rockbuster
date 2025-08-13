/* removed NULL return_date (183 records)
these correspond to films not yet returned 
Real Duration was calculated according to company policy, i.e.,
the calendar days is what matters, with a return on the same day meaning 0 days*/

SELECT date_trunc('day',return_date) - date_trunc('day',rental_date) AS real_duration,
COUNT(rental_id) AS number_of_rentals
FROM rental
WHERE return_date is not null
GROUP BY 1
ORDER BY 1 DESC
