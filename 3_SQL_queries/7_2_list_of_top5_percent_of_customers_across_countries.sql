WITH cte_top_customers AS (
	SELECT D.country, A.customer_id, concat(A.first_name,' ',A.last_name), 
	SUM(P.amount) AS revenue
	FROM customer A
	INNER JOIN address B ON A.address_id = B.address_id
	INNER JOIN city C ON B.city_id = C.city_id
	INNER JOIN country D ON C.country_id = D.country_id
	INNER JOIN rental R ON A.customer_id = R.customer_id
	INNER JOIN payment P ON R.rental_id = P.rental_id
	GROUP BY 1, 2, 3
	ORDER BY 4 DESC
	LIMIT 30 --599 customers, so 5% is 30--TODO: make this dynamically calculated
)
SELECT country, count(customer_id) AS number_of_top5_percent_customers
FROM cte_top_customers
GROUP BY 1
ORDER BY 2 DESC