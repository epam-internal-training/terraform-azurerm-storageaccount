resource "random_string" "main" {
  length  = 3
  special = false
  upper   = false
}

data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

resource "azurerm_storage_account" "main" {
  name                      = local.storage_account_name
  resource_group_name       = var.resource_group_name
  location                  = data.azurerm_resource_group.main.location
  account_kind              = "StorageV2"
  account_tier              = var.account_tier
  account_replication_type  = var.replication
  enable_https_traffic_only = true
  min_tls_version           = "TLS1_2"
  tags                      = local.tags

  lifecycle {
    ignore_changes = [
      tags["costcenter"],
      tags["projectcode"],
      tags["environment"],
      customer_managed_key
    ]
  }
}

module "container" {
  source = "./modules/containers"

  for_each = { for container in var.containers : container.name => container }

  name                 = each.value.name
  storage_account_name = local.storage_account_name
  access_type          = lookup(each.value, "access_type", "private")

  depends_on = [ azurerm_storage_account.main ]
}