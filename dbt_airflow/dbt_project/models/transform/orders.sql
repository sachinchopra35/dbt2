SELECT orders.order_id, orders.customer_id
FROM {{ ref('olist_orders_dataset') }} AS orders
