-- uses results of "customer_order.sql"

-- here, use a macro to decide whether to group by City or State.

SELECT *
FROM get_total_paid_by_partition(customer_state)