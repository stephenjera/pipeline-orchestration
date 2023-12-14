# Postgres
variable "databases" {
  default = {
    raw = {
      name     = "raw"
      ssl_mode = "disable"
    },
    dagster = {
      name     = "dagster"
      ssl_mode = "disable"
    },
    global_superstore = {
      name     = "global_superstore"
      ssl_mode = "disable"
    }
  }
}

variable "roles" {
  default = {
    airbyte_role = {
      name = "airbyte_role"
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

# variable "destination_postgres" {
#   default = {
#     countries = {
#       configuration = {
#         database = "raw"
#         host     = "localhost"
#         username = "airbyte_user"
#         password = "airbyte"
#         port     = 5432
#         schema   = "countries"
#         ssl_mode = {
#           prefer = {}
#         }

#       }
#       name = "countries"
#     }
#   }
# }
