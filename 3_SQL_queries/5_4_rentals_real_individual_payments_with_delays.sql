SELECT p.payment_id, p.customer_id, p.rental_id, r.inventory_id,
r.rental_date, r.return_date, f.rental_rate, p.amount AS amount_paid, f.rental_duration,
date_part('day',(date_trunc('day',return_date) - date_trunc('day',rental_date))) AS real_duration,
date_part('day',(date_trunc('day',return_date) - date_trunc('day',rental_date))) - f.rental_duration AS delay,
f.film_id, f.title  
FROM payment p
INNER JOIN rental r ON r.rental_id = p.rental_id
INNER JOIN inventory i ON i.inventory_id = r.inventory_id
INNER JOIN film f ON f.film_id = i.film_id