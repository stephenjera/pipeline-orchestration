import os

from dagster import Definitions, load_assets_from_modules
from dagster_dbt import DbtCliResource

from . import assets
from .constants import dbt_project_dir

all_assets = load_assets_from_modules([assets])

defs = Definitions(
    assets=all_assets,
    resources={
        "dbt": DbtCliResource(project_dir=os.fspath(dbt_project_dir)),
    },
)
