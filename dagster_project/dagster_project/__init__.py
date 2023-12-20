import os

from dagster import (
    Definitions,
    ScheduleDefinition,
    define_asset_job,
    load_assets_from_modules,
)
from dagster_dbt import DbtCliResource

from .assets import dbt, airbyte, assets
from .assets.dbt import dbt_project_dir


all_assets = load_assets_from_modules([assets])
#dbt_assets = load_assets_from_modules([dbt], group_name="dbt")
airbyte_assets = load_assets_from_modules([airbyte])


defs = Definitions(
    assets=[*airbyte_assets, *all_assets],
    resources={
        "dbt": DbtCliResource(project_dir=os.fspath(dbt_project_dir)),
    },
    # schedules={ScheduleDefinition(job=define_asset_job("all_assets", selection="*"), cron_schedule="@daily")},
)
