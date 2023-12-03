-- Query 1: Top 10 countries by customer count
SELECT D.country AS country_name,
       COUNT(A.customer_id) AS customer_count
FROM customer A
INNER JOIN address B ON A.address_id = B.address_id
INNER JOIN city C ON B.city_id = C.city_id
INNER JOIN country D ON C.country_ID = D.country_ID
GROUP BY D.country
ORDER BY customer_count DESC
LIMIT 10;

-- Explanation: The query efficiently retrieves the top 10 countries based on customer count using inner joins between the customer, address, city, and country tables.

-- Query 2: Top 10 cities in selected countries by customer count
SELECT D.country AS country_name,
       C.city AS city_name,
       COUNT(A.customer_id) AS number_of_customers
FROM customer A
INNER JOIN address B ON A.address_id = B.address_id
INNER JOIN city C ON B.city_id = C.city_id
INNER JOIN country D ON C.country_ID = D.country_ID
WHERE D.country IN ('India', 'China', 'United States', 'Japan', 'Mexico', 'Brazil', 'Russian Federation', 'Philippines', 'Turkey', 'Indonesia')
GROUP BY D.country, C.city
ORDER BY number_of_customers DESC
LIMIT 10;

-- Explanation: This query retrieves the top 10 cities in selected countries based on customer count, utilizing inner joins and filtering results for specific countries.

-- Query 3: Top 5 customers by total amount paid in selected cities
SELECT A.customer_id AS customer_id,
       A.first_name AS customer_first_name,
       A.last_name AS customer_last_name,
       D.country AS country_name,
       C.city AS city_name,
       SUM(E.amount) AS total_amount_paid
FROM customer A
INNER JOIN address B ON A.address_id = B.address_id
INNER JOIN city C ON B.city_id = C.city_id
INNER JOIN country D ON C.country_id = D.country_id
INNER JOIN payment E ON A.customer_id = E.customer_id
WHERE C.city IN ('Aurora', 'Acua', 'Citrus Heights', 'Iwaki', 'Ambattur', 'Shanwei', 'Sao Leopoldo', 'Tianjin', 'Hami', 'Cianjur')
GROUP BY A.customer_id, customer_first_name, customer_last_name, country_name, city_name
ORDER BY total_amount_paid DESC
LIMIT 5;

-- Explanation: This query identifies the top 5 customers by the total amount paid in selected cities, incorporating inner joins and filtering results for specific cities. Improved column aliasing enhances readability.
