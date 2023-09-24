## resource group
variable "rg_resource_group_name" {
  description = "The name of the resource group in which to create the storage account."
  type        = string
  default     = null
}

variable "rg_location" {
  description = "Specifies the supported Azure location where the resource should be created."
  type        = string
  default     = null
}

## container registry
variable "acr_registry_create" {
  description = "Controls if container registry should be created."
  type        = bool
}

variable "acr_registry_name" {
  description = "Name of the container registry resource created in the specified Azure Resource Group."
  type        = string
  default     = null
}

variable "acr_sku_name" {
  description = "The SKU name of the container registry."
  type        = string
  default     = null
}

variable "acr_admin_enabled" {
  description = "Specifies whether the admin user is enabled."
  type        = bool
  default     = null
}

variable "acr_trust_policy" {
  description = "indicates whether the policy is enabled. (For premium SKU only)."
  type        = bool
  default     = null
}

variable "acr_retention_policy" {
  description = "Retention policy an untagged manifest. (For premium SKU only)"
  type = object({
    enabled = bool
    days    = number
  })
}

variable "acr_allow_cird_ranges" {
  description = "Allow access to the container-registry from the CIDR blocks. (For premium SKU only)"
  type        = list(string)
  default     = []
}

variable "acr_allow_subnets" {
  description = "Allow access to the container-registry from listed subnets. (For premium SKU only)"
  type        = list(any)
  default     = []
}

variable "acr_enable_private_endpoint" {
  description = "Manages a Private Endpoint to Azure container registry."
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}