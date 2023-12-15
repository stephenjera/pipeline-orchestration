# Pipline Orchestration

## Setup the project

### db_setup

- Follow the instructions in the db_setup readme

### Airbyte

- Clone Airbyte from GitHub ```git clone --depth=1 https://github.com/airbytehq/airbyte.git```

- Switch into Airbyte directory ```cd airbyte```

- Start Airbyte ```./run-ab-platform.sh```

## Terraform

- ```cd terraform``` and run ```terraform apply --auto-approve```

## Dagster

- In project root activate python env with ```poetry shell```
- Install packages with ```poetry install --no-root```
- Then ```pip install -e ".[dev]"```
- ```cd dagster_project``` and run ```DAGSTER_DBT_PARSE_PROJECT_ON_LOAD=1 dagster dev```

## Running project

NO terrafrom provider for yahoo finance so setup airbyt connecter and connection manually and then run sync
