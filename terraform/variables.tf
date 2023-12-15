# Postgres
variable "databases" {
  default = {
    analytics = {
      name = "analytics"
    },
    dagster = {
      name = "dagster"
    },
    global_superstore = {
      name = "global_superstore"
    }
  }
}

variable "roles" {
  default = {
    loader_role = {
      name = "loader_role"
    },
    dagster_role = {
      name = "dagster_role"
    }
  }
}

# Airbyte
variable "workspace_id" {
  type    = string
  default = "10778cc8-13b4-4af7-a6d9-67667a1b88c8"
}
