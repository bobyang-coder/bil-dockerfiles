Attaching to airflow_airflow-init_1
airflow-init_1       | 
airflow-init_1       | WARNING! You should run the image with GID (Group ID) set to 0
airflow-init_1       |          even if you use 'airflow' user (UID=50000)
airflow-init_1       | 
airflow-init_1       |  You started the image with UID=50000 and GID=50000
airflow-init_1       | 
airflow-init_1       |  This is to make sure you can run the image with an arbitrary UID in the future.
airflow-init_1       | 
airflow-init_1       |  See more about it in the Airflow's docker image documentation
airflow-init_1       |      http://airflow.apache.org/docs/docker-stack/entrypoint
airflow-init_1       | 
airflow-init_1       | BACKEND=postgresql+psycopg2
airflow-init_1       | DB_HOST=postgres
airflow-init_1       | DB_PORT=5432
airflow-init_1       | 
airflow-init_1       | DB: postgresql+psycopg2://airflow:***@postgres/airflow
airflow-init_1       | [2021-07-16 08:31:21,204] {db.py:692} INFO - Creating tables
airflow-init_1       | INFO  [alembic.runtime.migration] Context impl PostgresqlImpl.
airflow-init_1       | INFO  [alembic.runtime.migration] Will assume transactional DDL.
airflow-init_1       | Upgrades done
airflow-init_1       | airflow already exist in the db
airflow-init_1       | 2.1.2
airflow_airflow-init_1 exited with code 0