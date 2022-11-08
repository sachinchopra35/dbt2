## Trainer's pre-requisites:
- TBC

---

# Jinja2 - basics walkthrough

Note: it may be beneficial to first go through this (as well as the main dbt tutorial) WITHOUT using Airflow, so that you get an idea of how dbt works locally. Then, the activity can be extended to using Airflow.

## Aim:
- Understand the benefits of referencing databases using Jinja in DBT (compared to using regular SQL syntax)
- Create and show variables using Jinja
- Create and apply macros using Jinja

## 1. Set up the DBT project
- This will be the longest step, and involves following separate instructions (see `adapted_setup.md` and the other files referenced by this)



## 2. Download the data
- In the `seeds` part of the project, we require 3 datasets from the Kaggle Brazil E-commerce dataset. Go to https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce and download the datasets. You want the following 3 in your `seeds` folder:
1. olist_customers_dataset.csv
2. olist_order_payments_dataset.csv
3. olist_orders_dataset.csv



## 3. Referencing

- We want to select everything from `olist_customers_dataset.csv`.
- Normally, using SQL, you would write the following:
```
SELECT *
FROM <warehouse>.<schema>.<dataset_name>
```
- However, thanks to Jinja's syntax in DBT, you do not need to explicitly give the location of the dataset in your data warehouse. Instead, you can reference the dataset in your `seeds` folder
- Therefore, create an SQL file in your `models` folder that says the following:
```
SELECT *
FROM {{ ref('olist_customers_dataset') }}
```
- Run this, and check whether the result of your query has appeared in Snowflake
- You should also see that, within your dbt project folder, a new folder called `targets` will have been created, which includes the compiled version of your code, where the references have been filled in.


## 4. Referencing using a Macro

- We have seen that DBT with Jinja makes it easier to reference datasets.
- We will now look at macros, which work in a similar way to Python functions. They are created once, and can be called at different times and with different parameters.

- In the `macros` folder, create an sql script called `macro_select_all.sql`
- Within this script, define your macro as follows:
```
{% macro select_all_from_dataset(dataset_name) %}

SELECT *
FROM {{ ref({{dataset_name}}) }}

{% endmacro %}
```
- In the `models` folder, create an sql script called `select_all_using_macro.sql`
- Within this script, call your macro by typing:
```
{{ select_all_from_dataset("<dataset_name>") }}
```
whilst replacing the parameter `<dataset_name>` with any dataset as a string, such as "`olist_customers_dataset`"

## 5. Using a `for` loop

- Let's say that, from the `olist_customers_dataset`, we want to select 3 columns: `customer_id`, `customer_city` and `customer_state`
- Without a `for` loop, this can be done as follows:
```
SELECT customer_id, customer_city, customer_state
FROM {{ ref('olist_customer_dataset') }}
```
- With a `for` loop, the same query can be made as follows:
```
SELECT
{% for column_required in ["customer_id", "customer_city", "customer_state"] %}
{{ column_required }}
{% endfor %}
FROM {{ ref('olist_customer_dataset') }}
```
- Finally, we can make this even neater by setting the required_column_list as a variable:

```
{% set required_columns = ["customer_id", "customer_city", "customer_state"] %}

SELECT
{% for column_required in required_column_list %}
{{ column_required }}
{% endfor %}
FROM {{ ref('olist_customer_dataset') }}
```


- Try running all 3 of these and ensure that they give the same result
- As an extension, create a macro that will select whichever columns you want, from whichever dataset (hint: as with Python functions, a Jinja macro can take in several parameters - for example, one can be a dataset name, one can be a list of required columns)

-- N.B: potentially add another for-loop exercise that shows how it can give dryer code. For example, summing over the number of sequential payments made by card / boleto.

## 6. Macro task: finding the total amound paid from each City or State

The code below uses the 3 datasets to find out how much money has been paid from each **State** in Brazil:
```
WITH a AS (
    SELECT
    o.customer_id,
    o.customer_state,
    o.order_id,
    p.payment_value
    FROM {{ref('customer_order')}} AS o
    JOIN {{ref('payment')}} AS p
    ON o.order_id = p.order_id
)

SELECT
    SUM(payment_value) AS total_payment,
    customer_state
FROM a
GROUP BY customer_state
ORDER BY customer_state
```
- Put this into a model and run it - check that your results make sense.
- Now, what if we also wanted to find out how much has been paid from each **City**?...
- Create a macro in `macros`, called `get_total_paid_by_partition` which takes one parameter, `city_or_state`, which can take the value `customer_city` or `customer_state`. Here is an idea to help you get started:
```
{% macro get_total_paid_by_partition(city_or_state) %}

WITH a AS (
    SELECT
    o.customer_id,
    o.{{city_or_state}},
    ...
```
- Create a new model in `models` that only contains the following code:
```
{{ get_total_paid_by_partition('customer_city') }}
```
- Check that this code successfully calls the macro and finds the total paid from each **City**
- Simply change the parameter 'customer_city' to 'customer_state' in the model, and see if this successfully finds the total paid from each **State**
- Equally, try changing the parameter to 'customer_zip_code_prefix'
- This macro has saved you from needing 3 separate large models. All you needed was to change the macro's parameter to allow you you find the different set of totals.



## Summary

You have used Jinja to:
- reference datasets (to avoid manually specifying their locations in your data warehouse)
- create `for` loops (to avoid needing to repeat yourself)
- create macros, which can be called with different parameters (to avoid needing to create different but similar models)

## After completing the exercise: 

- TBC. This should involve checking your Snowflake database to ensure that the desired transformations have been carried out.