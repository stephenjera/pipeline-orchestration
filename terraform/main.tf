terraform {
  required_providers {
    postgresql = {
      source  = "doctolib/postgresql"
      version = "2.22.0"
    }
    airbyte = {
      source  = "airbytehq/airbyte"
      version = "0.3.7"
    }
  }
}

provider "postgresql" {
  alias    = "postgres"
  host     = "localhost"
  port     = 5432
  username = "docker"
  password = "docker"
  sslmode  = "disable"
}

provider "airbyte" {
  alias      = "airbyte"
  username   = "airbyte"
  password   = "password"
  server_url = "http://localhost:8006/v1"
}

resource "postgresql_database" "databases" {
  provider = postgresql.postgres
  for_each = var.databases
  name     = each.value.name
}

# Create roles
resource "postgresql_role" "roles" {
  provider = postgresql.postgres
  for_each = var.roles
  name     = each.value.name
  login    = false
}

# Grant permissions
resource "postgresql_grant" "loader_role" {
  provider    = postgresql.postgres
  database    = postgresql_database.databases["analytics"].name
  role        = postgresql_role.roles["loader_role"].name
  object_type = "database"
  privileges  = ["CREATE", "TEMPORARY", "CONNECT"]
}

resource "postgresql_grant" "dagster_role" {
  provider    = postgresql.postgres
  database    = postgresql_database.databases["dagster"].name
  role        = postgresql_role.roles["dagster_role"].name
  object_type = "database"
  privileges  = ["CREATE", "TEMPORARY", "CONNECT"]
}

# Create users
resource "postgresql_role" "loader_user" {
  provider = postgresql.postgres
  name     = "loader_user"
  password = "loader"
  login    = true
  roles    = [postgresql_role.roles["loader_role"].name]
}

resource "postgresql_role" "dagster_user" {
  provider = postgresql.postgres
  name     = "dagster_user"
  password = "dagster"
  login    = true
  roles    = [postgresql_role.roles["dagster_role"].name]
}

# Airbyte
resource "airbyte_destination_postgres" "destination_postgres" {
  provider     = airbyte.airbyte
  name         = "analytics_postgres"
  workspace_id = var.workspace_id
  configuration = {
    database = postgresql_database.databases["analytics"].name
    host     = "localhost"
    username = "loader_user"
    password = "loader"
    port     = 5432
    schema   = "public"
    ssl_mode = {
      disable = {}
    }
  }
}

resource "airbyte_source_postgres" "superstore_postgres" {
  provider     = airbyte.airbyte
  name         = "superstore_postgres"
  workspace_id = var.workspace_id
  configuration = {
    database = postgresql_database.databases["global_superstore"].name
    host     = "localhost"
    username = "docker"
    password = "docker"
    port     = 5432
    schemas = [
      "public",
    ]
    ssl_mode = {
      disable = {}
    }
  }

}

resource "airbyte_connection" "superstore_to_postgres" {
  provider             = airbyte.airbyte
  data_residency       = "auto"
  destination_id       = airbyte_destination_postgres.destination_postgres.destination_id
  namespace_definition = "custom_format"
  namespace_format     = "superstore"
  schedule = {
    schedule_type = "manual"
  }
  source_id = airbyte_source_postgres.superstore_postgres.source_id

  configurations = {
    streams = [
      {
        name      = "orders"
        sync_mode = "full_refresh_overwrite"
      },
      {
        name      = "people"
        sync_mode = "full_refresh_overwrite"
      },
      {
        name      = "returns"
        sync_mode = "full_refresh_overwrite"
      },
    ]
  }
}




