SELECT total_payment, customer_state
FROM {{ ref('state_totals') }}
WHERE SUM(payment_value) >= 0