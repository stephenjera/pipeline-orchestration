from dagster_airbyte import AirbyteResource, load_assets_from_airbyte_instance

airbyte_instance = AirbyteResource(
    host="localhost",
    port="8000",
    username="airbyte",
    password="password",
)

# Use the airbyte_instance resource we defined in Step 1
airbyte_assets = load_assets_from_airbyte_instance(
    airbyte_instance, key_prefix=["superstore"]
)
