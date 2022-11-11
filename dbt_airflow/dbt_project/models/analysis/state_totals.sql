WITH a AS (
    SELECT
    customer_id,
    customer_state,
    order_id
    FROM {{ref('customer_order')}}
),

b AS (
    SELECT
    order_id,
    payment_value
    FROM {{ref('payment')}}
)

SELECT
    a.customer_state,
    SUM(b.payment_value) AS total_payment
FROM a
JOIN b 
ON a.order_id = b.order_id
GROUP BY a.customer_state
ORDER BY a.customer_state