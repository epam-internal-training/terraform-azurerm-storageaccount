resource "azurerm_key_vault_secret" "main" {
  for_each = var.keyvault_id == null || var.shared_access_key_enabled ==  false ? [] : toset(local.secrets)
  name     = replace(each.key , "_", "-")
  value    = lookup(azurerm_storage_account.main, each.key )

  key_vault_id = var.keyvault_id

  depends_on = [ azurerm_storage_account.main ]
}