resource "random_string" "main" {
  length  = 3
  special = false
  upper   = false
}

data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

resource "azurerm_storage_account" "main" {
  name                      = var.name_override == null ? lower(format("%sst", replace(local.storage_account_name, "/[[:^alnum:]]/", ""))) : lower(replace(var.name_override, "/[[:^alnum:]]/", ""))
  resource_group_name       = var.resource_group_name
  location                  = data.azurerm_resource_group.main.location
  account_kind              = "StorageV2"
  account_tier              = var.account_tier
  account_replication_type  = var.replication
  enable_https_traffic_only = true
  min_tls_version           = "TLS1_2"
  tags                      = local.tags

  network_rules {
    default_action             = try(var.network_rules["default_action"], "Deny")
    bypass                     = try(var.network_rules["bypass"], ["None"])
    ip_rules                   = try(var.network_rules["ip_rules"], [])
    virtual_network_subnet_ids = try(var.network_rules["virtual_network_subnet_ids"], null)
  }

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.type == "SystemAssigned" ? null : identity.value.identity_ids
    }
  }

  dynamic "static_website" {
    for_each = var.static_website == null ? [] : [var.static_website]
    content {
      index_document     = lookup(static_website.value, "index_document", null)
      error_404_document = lookup(static_website.value, "error_404_document", null)
    }
  }

  lifecycle {
    ignore_changes = [
      tags["costcenter"],
      tags["projectcode"],
      tags["environment"],
      customer_managed_key
    ]
  }
}

resource "azurerm_storage_container" "main" {

  for_each              = { for container in var.containers : container.name => container }
  name                  = each.value.name
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = lookup(each.value, "access_type", "private")
}

resource "azurerm_storage_queue" "main" {

  for_each             = { for queue in var.queues : queue.name => queue }
  name                 = each.value.name
  storage_account_name = azurerm_storage_account.main.name
}

resource "azurerm_storage_share" "main" {

  for_each             = { for share in var.shares : share.name => share }
  name                 = each.value.name
  storage_account_name = azurerm_storage_account.main.name
  quota                = each.value.quota

  dynamic "acl" {
    for_each = lookup(each.value, "acl", [])
    content {
      id = acl.value.id
      dynamic "access_policy" {
        for_each = lookup(acl.value, "access_policy", [])
        content {
          start       = access_policy.value.start
          expiry      = access_policy.value.expiry
          permissions = access_policy.value.permissions
        }
      }
    }
  }
}

resource "azurerm_storage_table" "main" {
  for_each             = { for table in var.tables : table.name => table }
  name                 = lower(each.key)
  storage_account_name = azurerm_storage_account.main.name

  dynamic "acl" {
    for_each = lookup(each.value, "acl", [])
    content {
      id = acl.value.id
      dynamic "access_policy" {
        for_each = lookup(acl.value, "access_policy", [])
        content {
          start       = access_policy.value.start
          expiry      = access_policy.value.expiry
          permissions = access_policy.value.permissions
        }
      }
    }
  }
}