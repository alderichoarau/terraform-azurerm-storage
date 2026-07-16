variable "name" {
  description = "Name of the Storage Account (lowercase letters and digits only, 3-24 chars)"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]{3,24}$", var.name))
    error_message = "name must be 3-24 chars, lowercase letters and digits only."
  }
}

variable "resource_group_name" {
  description = "Name of the Resource Group to deploy into"
  type        = string
}

variable "location" {
  description = "Azure region for the storage account"
  type        = string
}

variable "private_container_name" {
  description = "Name of the private blob container"
  type        = string
  default     = "api-logs"
}

variable "public_container_name" {
  description = "Name of the public blob container (blob-level anonymous access)"
  type        = string
  default     = "api-config"
}

variable "tags" {
  description = "Tags applied to all resources in this module"
  type        = map(string)
  default     = {}
}
