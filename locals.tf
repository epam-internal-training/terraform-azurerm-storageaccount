locals {
  storage_account_name = format("%s%s%s", var.project_name, var.environment, random_string.main.result)

  defatlt_tags = {
    project     = var.project_name
    environment = var.environment
    costcenter  = var.costcenter
  }

  tags = merge(local.defatlt_tags, var.tags)
}