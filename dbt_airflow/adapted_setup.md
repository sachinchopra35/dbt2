[comment]: <> (For the tutorial, there will probably be 5 main documents. adapted_setup, installing_airflow_wsl, adapted_setup_cheat_sheet, jinja_questions, jinja_answers)

[comment]: <> (2 main differences. Using WSL instead of Docker; Using Kaggle data instead of manually created csvs)

[comment]: <> (Is a for-loop even necessary? You could just do a groupby. Seems like a workaround for people who are more used to Python.)

# Airflow, Snowlake and DBT - Tutorial

 This tutorial combines the existing tutorial, and Will's WSL2 instructions (to avoid Docker).  

Adapted from https://quickstarts.snowflake.com/guide/data_engineering_with_apache_airflow/index.html?index=..%2F..index#0

## 1. Overview

---

### What are dbt and Airflow?

Numerous business are looking at modern data strategy built on platforms that could support agility, growth and operational efficiency. Snowflake is Data Cloud, a future proof solution that can simplify data pipelines for all your businesses so you can focus on your data and analytics instead of infrastructure management and maintenance.

Apache Airflow is an open-source workflow management platform that can be used to author and manage data pipelines. Airflow uses worklows made of directed acyclic graphs (DAGs) of tasks.

dbt is a modern data engineering framework maintained by dbt Labs that is becoming very popular in modern data architectures, leveraging cloud data platforms like Snowflake. dbt CLI is the command line interface for running dbt projects. The CLI is free to use and open source.

In this virtual hands-on lab, you will follow a step-by-step guide to using Airflow with dbt to create data transformation job schedulers.


[comment]: <> (Also mention that Jinja will be involved afterwards)

---
<br>

[comment]: <> (Now add the adapted setup instructions)

### Initial Setup

#### 1. Snowflake
    1. Create a snowflake account
        - make a note of the login details, as you may need to type them elsewhere
    2. You will need a snowflake user with the permission to create objects in the DEMO_DB database

#### 2. GitHub
    1. Create a Git repository and clone it to your local system

#### 3. WSL
    1. Set up WSL ("Windows System for Linux") according to the instructions in "installing_airflow_wsl.md". This will allow you to run the Airflow UI on your localhost:8080 later on

Now, we will build a working Airflow pipeline using dbt and Snowflake

## 2. Environment Setup

- Within your repo, create a folder called `dbt_airflow` and go into this folder.
  
[comment]: <> (This is where you would curl the docker-compose file, if using Docker)
- 