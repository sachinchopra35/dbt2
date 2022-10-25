-- uses results of "customer_order.sql"

-- o is result of customer_order.sql
-- p is payment

-- could instead group by city (from customer dataset) and show CITY total, not STATE total. Could use a macro to do these things

WITH a AS (
    o.customer_id,
    o.customer_state,
    o.order_id,
    p.payment_value
    FROM {{ref('customer_order')}}  AS o
    JOIN {{ref('payment')}} AS p
    ON o.order_id = p.order_id
)

SELECT
    SUM(payment_value) AS total_payment,
    customer_state
FROM a
GROUP BY customer_state
ORDER BY customer_state;