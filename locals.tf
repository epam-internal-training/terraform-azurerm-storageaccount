locals {
  storage_account_name = format("%s%s%s", var.project_name, var.environment, random_string.main.result)

  defatlt_tags = {
    project     = var.project_name
    environment = var.environment
    costcenter  = var.costcenter
  }

  secrets = [
    "primary_access_key",
    "secondary_access_key",
    "primary_connection_string",
    "secondary_connection_string",
    "primary_blob_connection_string",
    "secondary_blob_connection_string"
  ]

  tags = merge(local.defatlt_tags, var.tags)
}