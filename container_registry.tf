## container registry
resource "azurerm_container_registry" "acr" {
  count      = var.acr_registry_create ? 1 : 0

  resource_group_name = var.rg_resource_group_name
  location            = var.rg_location

  name                = format("%s", var.acr_registry_name)
  sku                 = var.acr_sku_name
  admin_enabled       = var.acr_admin_enabled

  dynamic "retention_policy" {
    for_each = var.acr_sku_name == "Premium" ? [{}] : []

    content {
      enabled = var.acr_retention_policy.enabled
      days    = var.acr_retention_policy.days
    }
  }

  dynamic "trust_policy" {
    for_each = var.acr_sku_name == "Premium" ? [{}] : []

    content {
      enabled = var.acr_trust_policy
    }
  }

  dynamic "network_rule_set" {
    for_each = var.acr_sku_name == "Premium" && var.acr_enable_private_endpoint == true ? [{
      allow_subnets     = var.acr_allow_subnets
      allow_cird_ranges = var.acr_allow_cird_ranges
    }] : []

    content {
      default_action = "Deny"

      dynamic "virtual_network" {
        for_each = { for index, subnet in network_rule_set.value.allow_subnets : index => subnet }

        content {
          action    = "Allow"
          subnet_id = virtual_network.value.id
        }
      }

      dynamic "ip_rule" {
        for_each = { for index, rule in network_rule_set.value.allow_cird_ranges : index => rule }

        content {
          action   = "Allow"
          ip_range = ip_rule.value
        }
      }
    }
  }

  tags     = merge({ "Resource Name" = format("%s", var.acr_registry_name) }, var.tags, )
}
