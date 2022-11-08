from datetime import datetime
import os

from airflow import DAG
from airflow.operators.python import PythonOperator, BranchPythonOperator
from airflow.operators.bash import BashOperator
from airflow.operators.empty import EmptyOperator

default_args = {
    'owner': 'sachin',
    'depends_on_past': False,
    'start_date': datetime(2020,8,1),
    'retries': 0
}


with DAG('dbt_operations', default_args=default_args, schedule_interval='@once') as dag:

    task_1 = BashOperator(
        task_id='dbt_seed',
        cwd='/c/dbt2/dbt_airflow/dbt',
        bash_command='dbt seed',
        dag=dag
    )

    task_2 = BashOperator(
        task_id='dbt_run',
        cwd='/c/dbt2/dbt_airflow/dbt',
        bash_command='dbt run',
        dag=dag
    )

    task_1 >> task_2