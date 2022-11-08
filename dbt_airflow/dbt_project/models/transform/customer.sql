SELECT
customer_id, customer_city, customer_state, customer_zip_code_prefix
FROM
{{ ref('olist_customers_dataset') }}