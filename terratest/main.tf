provider "azurerm" {
  features {
  }
  skip_provider_registration = true
}

resource "azurerm_key_vault" "akv" {
  name                = "epmakvinttest20230901"
  sku_name            = "standard"
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = var.azure_tenant_id

}

locals {
  keyvault_id = "/subscriptions/${var.azure_subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.KeyVault/vaults/epmakvinttest20230901"
}

module "storage_account" {
  source              = "../"
  project_name        = "epmint"
  environment         = "dev"
  costcenter          = "TF1001"
  resource_group_name = var.resource_group_name

  for_each = local.storageaccounts

  name_override             = each.value.storage_name
  account_tier              = lookup(each.value, "account_tier", "Standard")
  replication               = lookup(each.value, "replication", "LRS")
  shared_access_key_enabled = lookup(each.value, "shared_access_key_enabled", true)
  keyvault_id               = lookup(each.value, "keyvault_id", local.keyvault_id )
  containers                = lookup(each.value, "containers", [])
  queues                    = lookup(each.value, "queues", [])
  tables                    = lookup(each.value, "tables", [])
  shares                    = lookup(each.value, "shares", [])
  static_website            = lookup(each.value, "static_website", null)
  tags                      = lookup(each.value, "tags", {})

  identity = lookup(each.value, "identity", {
    type         = "SystemAssigned"
    identity_ids = null
    }
  )

  network_rules = lookup(each.value, "network_rules", {
    default_action             = "Allow"
    bypass                     = ["None"]
    ip_rules                   = []
    virtual_network_subnet_ids = []
    }
  )

  depends_on = [azurerm_key_vault.akv]
}