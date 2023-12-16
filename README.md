# Pipline Orchestration

## Setup database

- In the db_setup directory run:

```shell
docker compose up 
```

- In the db_setup/scripts folder run:

```shell
./load_databases.sh
 ```

## Setup PG Admin

Navigate to **localhost:5050**

email = <test@mail.com>

password = docker

## Airbyte

- Clone Airbyte from GitHub to root directory

```shell
git clone --depth=1 https://github.com/airbytehq/airbyte.git
```

- Switch into Airbyte directory

```shell
cd airbyte
```

- Start Airbyte

```shell
./run-ab-platform.sh
```

## Terraform

- Go to Terraform directory and run:

```shell
terraform import 'postgresql_database.databases["global_superstore"]' global_superstore
```

 ```shell
 terraform apply --auto-approve
 ```

## Dagster

- In project root activate python env

 ```shell
poetry shell
```

```shell
poetry install --no-root
```

In the dagster_project directory:

```shell
pip install -e ".[dev]"
```

- To run Dagster run:

```shell
export DAGSTER_HOME=$(pwd)
```

```shell
DAGSTER_DBT_PARSE_PROJECT_ON_LOAD=1 dagster dev
```
