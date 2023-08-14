variable "project_name" {
  type        = string
  description = "Provide project name"
}

variable "environment" {
  type        = string
  description = "Provide environment name"
}

variable "costcenter" {
  type        = string
  description = "Provide environment name"
}

variable "resource_group_name" {
  type        = string
  description = "Provide resource group name"
}

variable "account_tier" {
  type        = string
  description = "Provide storage account tier"
  default     = "Standard"
}

variable "replication" {
  type        = string
  description = "Provide replication type"
  default     = "LRS"
}

variable "tags" {
  type    = object({})
  default = {}
}

variable "containers" {
  type        = any
  default     = []
}