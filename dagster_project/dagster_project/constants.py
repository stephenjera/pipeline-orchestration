import os
from pathlib import Path

from dagster_airbyte import AirbyteResource, load_assets_from_airbyte_instance
from dagster_dbt import DbtCliResource

dbt_project_dir = Path.cwd().parent / "dbt_stocks"
# dbt_project_dir = Path(__file__).joinpath("..", "..", "..").resolve()
dbt = DbtCliResource(project_dir=os.fspath(dbt_project_dir))

# If DAGSTER_DBT_PARSE_PROJECT_ON_LOAD is set, a manifest will be created at run time.
# Otherwise, we expect a manifest to be present in the project's target directory.
if os.getenv("DAGSTER_DBT_PARSE_PROJECT_ON_LOAD"):
    dbt_manifest_path = (
        dbt.cli(
            ["--quiet", "parse"],
            target_path=Path("target"),
        )
        .wait()
        .target_path.joinpath("manifest.json")
    )
else:
    dbt_manifest_path = dbt_project_dir.joinpath("target", "manifest.json")

# Airbyte

airbyte_instance = AirbyteResource(
    host="localhost",
    port="8000",
    username="airbyte",
    password="password",
)

dbt_config = {
    "project_dir": dbt_project_dir,
    "profiles_dir": dbt_project_dir,
}
