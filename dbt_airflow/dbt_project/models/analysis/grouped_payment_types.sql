SELECT
order_id
, {% for payment_type in ["credit_card", "debit_card", "boleto", "voucher"] %}
SUM(CASE WHEN payment_type = '{{payment_type}}' THEN payment_value END) as {{payment_type}}_amount,
{% endfor %}
SUM(payment_value) AS total_amount
FROM {{ ref('olist_order_payments_dataset') }}
GROUP BY order_id