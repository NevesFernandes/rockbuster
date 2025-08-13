SELECT COUNT(customer_id) AS count_of_customers, 
COUNT(DISTINCT country.country_id) AS count_of_countries
FROM customer
INNER JOIN address ON customer.address_id = address.address_id
INNER JOIN city ON address.city_id = city.city_id
INNER JOIN country ON city.country_id = country.country_id;