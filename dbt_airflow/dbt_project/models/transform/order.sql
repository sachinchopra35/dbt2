SELECT
customer_id, order_id
FROM
{{ ref('olist_orders_dataset') }}