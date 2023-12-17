import pandas as pd
import psycopg2
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
    group_name="Tableau",
)
def save_to_csv_global_superstore():
    # Connect to your postgres DB
    conn = psycopg2.connect(
        dbname="analytics",
        user="docker",
        password="docker",
        host="localhost",
        port="5432",
    )

    # Use a context manager to handle the cursor
    with conn.cursor() as cur:
        cur.execute("SELECT * FROM dbt_marts.global_superstore")
        rows = cur.fetchall()
        column_names = [desc[0] for desc in cur.description]
        df = pd.DataFrame(rows, columns=column_names)
        df.to_csv("./data/global_superstore.csv", index=False)
