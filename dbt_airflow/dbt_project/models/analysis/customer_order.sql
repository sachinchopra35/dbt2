-- uses results of "customer.sql" and "order.sql"
-- we could also give them "olist_customers_dataset.csv" as 2 csv's, to join like in Tutorial step 5 part 1.

-- c is customer
-- o is order

SELECT
c.customer_id,
c.customer_state,
o.order_id
FROM {{ref('customer')}}  AS c
JOIN {{ref('order')}} AS o
ON c.customer_id = o.customer_id;