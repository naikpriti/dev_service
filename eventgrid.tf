resource "azurerm_eventgrid_system_topic" "eventgrid_system_topic" {
  name                = var.system_topic_name
  resource_group_name = var.resource_group_name
  location            = var.location
  source_arm_resource_id = var.source_resource_id
  topic_type             = var.topic_type

  identity {
    type = "SystemAssigned"
  }

 
}


resource "azurerm_eventgrid_system_topic_event_subscription" "event_subscription" {
  name                = var.event_subscription_name
  system_topic        = var.system_topic_name
  resource_group_name = var.resource_group_name
  event_delivery_schema = var.event_delivery_schema
  service_bus_queue_endpoint_id = try(var.service_bus_queue_endpoint_id, "")
  advanced_filtering_on_arrays_enabled = var.advanced_filtering_on_arrays_enabled
  included_event_types = var.included_event_types

  dynamic "advanced_filter" {
    for_each = var.advanced_filter != null ? ["advanced_filter"] : []
    content {
      dynamic "string_ends_with" {
        for_each = lookup(var.advanced_filter, "string_ends_with", {}) != {} ? ["string_ends_with"] : []
        content {
          key    = lookup(var.advanced_filter, "string_ends_with.key", null)
          values = lookup(var.advanced_filter, "string_ends_with.values", null)
        }
      }
      dynamic "string_contains" {
        for_each = lookup(var.advanced_filter, "string_contains", {}) != {} ? ["string_contains"] : []
        content {
          key    = lookup(var.advanced_filter, "string_contains.key", null)
          values = lookup(var.advanced_filter, "string_contains.values", null)
        }
      }
    }
  }

  dynamic "retry_policy" {
    for_each = var.retry_policy
     content {
      max_delivery_attempts = lookup(var.retry_policy, "max_delivery_attempts", null)
      event_time_to_live    = lookup(var.retry_policy, "event_time_to_live", null)
   }
  }

  
}