SELECT
order_id, payment_value
FROM
{{ ref('olist_order_payments_dataset') }}