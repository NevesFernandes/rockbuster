WITH cte_countries AS (
	SELECT D.country,COUNT(DISTINCT A.customer_id) AS number_of_customers, 
	SUM(P.amount) AS country_revenue
	FROM customer A
	INNER JOIN address B ON A.address_id = B.address_id
	INNER JOIN city C ON B.city_id = C.city_id
	INNER JOIN country D ON C.country_id = D.country_id
	INNER JOIN rental R ON A.customer_id = R.customer_id
	INNER JOIN payment P ON R.rental_id = P.rental_id
	GROUP BY 1
	ORDER BY 2 DESC
)
SELECT *, ROUND((country_revenue/number_of_customers),2) AS country_avg_revenue_per_customer
FROM cte_countries
ORDER BY 3 DESC, 4 DESC;