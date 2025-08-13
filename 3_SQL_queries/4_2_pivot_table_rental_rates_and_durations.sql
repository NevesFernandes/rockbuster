/*
PIVOT doesn't exist in Postgresql, crosstab function was used instead
Note that the CREATE query below should be executed beforehand, to enable the 
usage of the function (in case it's not yet active)
*/
CREATE EXTENSION IF NOT EXISTS tablefunc;

SELECT * 
FROM crosstab(
'SELECT f.rental_duration, f.rental_rate, sum(p.amount)
FROM film f
INNER JOIN inventory i ON f.film_id = i.film_id
INNER JOIN rental r ON i.inventory_id = r.inventory_id
INNER JOIN payment p ON r.rental_id = p.rental_id
GROUP BY 1,2
ORDER BY 1,2'
) AS duration_rate_crosstab ("Duration" smallint, "0.99" numeric, "2.99" numeric, "4.99" numeric);

