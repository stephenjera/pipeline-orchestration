from dagster import AssetExecutionContext, asset
from dagster_airbyte import load_assets_from_airbyte_instance
from dagster_dbt import DbtCliResource, dbt_assets, get_asset_key_for_model

from .constants import airbyte_instance, dbt_manifest_path

# Use the airbyte_instance resource we defined in Step 1
airbyte_assets = load_assets_from_airbyte_instance(
    airbyte_instance, key_prefix=["superstore"]
)


@dbt_assets(manifest=dbt_manifest_path)
def dbt_project_assets(context: AssetExecutionContext, dbt: DbtCliResource):
    yield from dbt.cli(["build"], context=context).stream()


@asset(
    deps=[
        get_asset_key_for_model([dbt_project_assets], "global_superstore"),
    ],
    group_name="Hello",
)
def hello_world():
    return "Hello World"
