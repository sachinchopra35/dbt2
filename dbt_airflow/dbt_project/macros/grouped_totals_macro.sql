{% macro get_total_paid_by_partition(city_or_state) %}

WITH a AS (
    SELECT
    o.customer_id,
    o.{{city_or_state}},
    o.order_id,
    p.payment_value
    FROM {{ref('customer_order')}} AS o
    JOIN {{ref('payment')}} AS p
    ON o.order_id = p.order_id
)

SELECT
    SUM(payment_value) AS total_payment,
    {{city_or_state}}
FROM a
GROUP BY {{city_or_state}}
ORDER BY {{city_or_state}}

{% endmacro %}