variable "project_name" {
  description = "Provide project name"
  type        = string
}

variable "environment" {
  description = "Provide environment name"
  type        = string
}

variable "costcenter" {
  description = "Provide environment name"
  type        = string
}

variable "resource_group_name" {
  description = "Provide resource group name"
  type        = string
}

variable "name_override" {
  description = "Override the default storage account naming convention"
  type        = string
  default     = null
}

variable "account_tier" {
  description = "Provide storage account tier"
  type        = string
  default     = "Standard"
}

variable "replication" {
  description = "Provide replication type"
  type        = string
  default     = "LRS"
}

variable "shared_access_key_enabled" {
  description = "Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. If false, then all requests, including shared access signatures, must be authorized with Azure Active Directory (Azure AD)."
  type        = bool
  default     = true
}

variable "network_rules" {
  description = "Network rules"

  type = object({
    default_action             = string
    bypass                     = list(string)
    ip_rules                   = list(string)
    virtual_network_subnet_ids = list(string)
  })

  default = {
    default_action             = "Deny"
    bypass                     = ["None"]
    ip_rules                   = []
    virtual_network_subnet_ids = []
  }
}

variable "keyvault_id" {
  description = "Existing azure keyvault id to create secrets"
  type        = string
  default     = null
}

variable "identity" {
  description = "An identity (Optional) block"
  type = object({
    type         = string
    identity_ids = list(string)
  })
  default = {
    type         = "SystemAssigned"
    identity_ids = null
  }
}

variable "containers" {
  description = "List of containers to create and their access levels"
  type        = list(any)
  default     = []
}

variable "queues" {
  description = "List of queues to create within an Azure Storage Account"
  type        = list(any)
  default     = []
}

variable "tables" {
  description = "List of tables to create within an Azure Storage Account"
  type        = list(any)
  default     = []
}

variable "shares" {
  description = "List of fileshares to create within an Azure Storage Account"
  type        = list(any)
  default     = []
}

variable "static_website" {
  description = "A static_website (Optional) block"
  type        = any
  default     = null
}

variable "tags" {
  description = "Tags to add to all resources created"
  type        = object({})
  default     = {}
}