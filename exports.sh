#!/bin/bash

export DAGSTER_HOME=$(pwd)/dagster_project
export DAGSTER_PG_USERNAME=docker
export DAGSTER_PG_PASSWORD=docker
export DAGSTER_PG_HOST=localhost
export DAGSTER_PG_DB=dagster
export LOCAL_COMPUTE_LOG_MANAGER_DIRECTORY=./storage/log_manager
export DAGSTER_LOCAL_ARTIFACT_STORAGE_DIR=./storage/local_artifact