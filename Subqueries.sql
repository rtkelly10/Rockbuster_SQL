-- Query 1: Average Total Amount Paid for Top 5 Customers in Selected Cities

SELECT
    AVG(total_amount_paid) AS "average"
FROM
(
    SELECT
        SUM(E.amount) AS total_amount_paid
    FROM
        customer A
        INNER JOIN address B ON A.address_id = B.address_id
        INNER JOIN city C ON B.city_id = C.city_id
        INNER JOIN country D ON C.country_id = D.country_id
        INNER JOIN payment E ON A.customer_id = E.customer_id
    WHERE
        C.city IN ('Aurora', 'Acua', 'Citrus Heights', 'Iwaki', 'Ambattur', 'Shanwei', 'Sao Leopoldo', 'Tianjin', 'Hami', 'Cianjur')
    GROUP BY A.customer_id
    ORDER BY total_amount_paid DESC
    LIMIT 5
) AS total_amount_paid_alias;

-- Explanation: This query calculates the average total amount paid for the top 5 customers in selected cities. It uses a subquery to find the total amount paid by each customer in the specified cities, orders them by the total amount paid in descending order, and limits the results to the top 5. The outer query then calculates the average of these total amounts.

-- Query 2: Customer Counts in Each Country, Including Top 5 Customers

SELECT
    D.country,
    COUNT(A.customer_id) AS all_customer_count,
    COUNT(top_5_customers.customer_id) AS top_customer_count
FROM
    customer AS A
    INNER JOIN address AS B ON A.address_id = B.address_id
    INNER JOIN city AS C ON B.city_id = C.city_id
    INNER JOIN country AS D ON C.country_id = D.country_id
    LEFT JOIN
    (
        SELECT
            A.customer_id,
            SUM(E.amount) AS total_amount_paid
        FROM
            customer AS A
            INNER JOIN address AS B ON A.address_id = B.address_id
            INNER JOIN city AS C ON B.city_id = C.city_id
            INNER JOIN country AS D ON C.country_id = D.country_id
            INNER JOIN payment AS E ON A.customer_id = E.customer_id
        WHERE
            C.city IN ('Aurora', 'Acua', 'Citrus Heights', 'Iwaki', 'Ambattur', 'Shanwei', 'So Leopoldo', 'Teboksary', 'Tianjin', 'Cianjur')
        GROUP BY A.customer_id
        ORDER BY total_amount_paid DESC
        LIMIT 5
    ) AS top_5_customers
ON A.customer_id = top_5_customers.customer_id
GROUP BY D.country
ORDER BY all_customer_count DESC;

-- Explanation: This query retrieves customer counts in each country, including counts of the top 5 customers based on their total amount paid. It utilizes a left join with a subquery that identifies the top 5 customers in specified cities based on their total amount paid. The results are grouped by country, and the counts are ordered in descending order of all customers.

