SELECT
customer_id, customer_state
FROM
{{ ref('olist_customers_dataset') }}