from pathlib import Path

from dagster import AssetExecutionContext, asset
from dagster_dbt import DbtCliResource, dbt_assets, get_asset_key_for_model

from .constants import dbt_manifest_path


@dbt_assets(manifest=dbt_manifest_path)
def dbt_project_assets(context: AssetExecutionContext, dbt: DbtCliResource):
    yield from dbt.cli(["build"], context=context).stream()


@asset(
    deps=[get_asset_key_for_model([dbt_project_assets], "stg_superstore__orders")],
)
def hello_world():
    return "Hello World"
