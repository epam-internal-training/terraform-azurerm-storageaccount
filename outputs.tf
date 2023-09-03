output "storage_account_name" {
  value       = azurerm_storage_account.main.name
  description = "Name of storage account create"
}

output "storage_account_id" {
  value       = azurerm_storage_account.main.id
  description = "Resource id of storage account create"
}

output "storage_account_primary_blob_endpoint" {
  value       = azurerm_storage_account.main.primary_blob_endpoint
  description = "The endpoint URL for blob storage in the primary location"
}

output "storage_account_secondary_blob_endpoint" {
  value       = azurerm_storage_account.main.secondary_blob_endpoint
  description = "The endpoint URL for blob storage in the secondary location"
}

output "storage_account_primary_queue_endpoint" {
  value       = azurerm_storage_account.main.primary_queue_endpoint
  description = "The endpoint URL for queue storage in the primary location"
}

output "storage_account_secondary_queue_endpoint" {
  value       = azurerm_storage_account.main.secondary_queue_endpoint
  description = "The endpoint URL for queue storage in the secondary location"
}

output "storage_account_primary_table_endpoint" {
  value       = azurerm_storage_account.main.primary_table_endpoint
  description = "The endpoint URL for table storage in the primary location"
}

output "storage_account_secondary_table_endpoint" {
  value       = azurerm_storage_account.main.secondary_table_endpoint
  description = "The endpoint URL for table storage in the secondary location"
}

output "storage_account_primary_file_endpoint" {
  value       = azurerm_storage_account.main.primary_file_endpoint
  description = "The endpoint URL for file storage in the primary location"
}

output "storage_account_secondary_file_endpoint" {
  value       = azurerm_storage_account.main.secondary_file_endpoint
  description = "The endpoint URL for file storage in the secondary location"
}

output "storage_account_primary_web_endpoint" {
  value       = azurerm_storage_account.main.primary_web_endpoint
  description = "The endpoint URL for web storage in the primary location"
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

output "storage_account_identity" {
  value       = azurerm_storage_account.main.identity.0.principal_id
  description = "The Principal ID for the Service Principal associated with the Identity of this Storage Account."
}