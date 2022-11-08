# Creating a DBT project with Airflow integration

# Done after installing_airflow_wsl

This is assuming you've followed the previous Airflow installation tutorial using WSL, and if not then you should know where your `dags` folder is.

## Installing and using DBT

> N.B. I did all of the following in WSL

DBT can be pip installed - you just need to know which connector to use, in this case `pip install dbt-snowflake`.

When this is finished, make a project directory and inside it run `dbt init <project-name>` (the project name can be whatever you want).

Follow the instructions connecting it to your Snowflake account - it's v. self explanatory.

This will create a bunch of dbt files/folders.

enter the dbt project folder and open vscode with `code .` (this works inside WSL too).

Assuming you already know how to use DBT, go ahead and make your models.

## Airflow Integration

Inside your airflow home directory, if there is not a folder called `dags`, then make one.

Inside here, make a .py file to represent your DAG.

Define your DAG according to the airflow tutorial - for DBT core (i.e. local installation) we can use the BashOperator to run dbt commands, however for DBT cloud there are a whole host of operators that I haven't explored yet.

My DAG looked something like this:

```python
from datetime import datetime
from airflow import DAG
from airflow.operators.bash import BashOperator

dag = DAG('dbt_pipeline', description='dbt pipeline test',
          schedule_interval='@once', start_date=datetime(2022, 1, 1), catchup=False)    

dbt_run = BashOperator(
    task_id='dbt_run',
    bash_command="dbt run",
    cwd="/z/airflow_dbt_project/dbt",
    dag=dag
)

dbt_run
```

`cwd` is the directory that the command should be run in, i.e. your dbt project directory.

When trying to run airflow after all of this I encountered an error: `TypeError: LocalProxy.__init__() got an unexpected keyword argument 'unbound_message'`.

I fixed this by downgrading `flask` to version 2.1.3 with `pip install flask==2.1.3`.

At this point, when your DAG runs, it should run your dbt models too.

You can definitely add [more specific commands](https://docs.getdbt.com/reference/dbt-commands), for example running a model individually, or testing your models etc - I just did the basics to check that everything was working as intended.
