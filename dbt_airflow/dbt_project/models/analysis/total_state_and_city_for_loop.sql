
{% for city_or_state in ["customer_city", "customer_state"] %}

{{ get_total_paid_by_partition('city_or_state') }}

{% endfor %}

-- danger - there are 2 SELECT statements here, since the macro involves a SELECT. Will it work?