{% macro get_total_paid_by_partition(city_or_state) %}

WITH a AS (
    SELECT
    customer_id,
    {{city_or_state}},
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
    a.{{city_or_state}},
    SUM(b.payment_value) AS total_payment
FROM a JOIN b 
ON a.order_id = b.order_id
GROUP BY {{city_or_state}}
ORDER BY {{city_or_state}}

{% endmacro %}