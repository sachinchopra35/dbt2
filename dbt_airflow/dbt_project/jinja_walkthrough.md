## Trainer's pre-requisites:
- TBC

---

# Jinja2 - basics walkthrough

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
- Run this (this involves sorting out your Dags and having the Airflow UI up), and check whether the result of your query has appeared in Snowflake


## 4. Referencing using a Macro

- We have seen that DBT with Jinja makes it easier to reference datasets.
- We will now look at macros, which 


## After completing the exercise: 

- TBC. This should involve checking your Snowflake database to ensure that the desired transformations have been carried out.