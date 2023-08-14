output "storage_account_name" {
  value       = azurerm_storage_account.main.name
  description = "Name of storage account create"
}

output "storage_account_primary_blob_endpoint" {
  value       = azurerm_storage_account.main.primary_blob_endpoint
  description = "The endpoint URL for blob storage in the primary location"
}

output "storage_account_primary_access_key" {
  value       = azurerm_storage_account.main.primary_access_key
  description = "The primary access key for the storage account"
  sensitive   = true
}

output "storage_account_secondary_access_key" {
  value       = azurerm_storage_account.main.secondary_access_key
  description = "The secondary access key for the storage account"
  sensitive   = true
}

output "storage_account_primary_connection_string" {
  value       = azurerm_storage_account.main.primary_connection_string
  description = "The connection string associated with the primary location"
  sensitive   = true
}

output "storage_account_secondary_connection_string" {
  value       = azurerm_storage_account.main.secondary_connection_string
  description = "The connection string associated with the secondary location"
  sensitive   = true
}