resource "azurerm_eventgrid_system_topic" "system_topic" {
  name                   = var.system_topic_name
  resource_group_name    = var.resource_group_name
  location               = var.location
  source_arm_resource_id = var.storage_account_id
  topic_type             = "Microsoft.Storage.StorageAccounts"
  tags                   = var.tag

}

/*resource "azurerm_eventgrid_system_topic_event_subscription" "event_subscription" {
  name                = each.key
  system_topic        = var.system_topic_name
  resource_group_name = var.resource_group
  event_delivery_schema = var.event_delivery_schema
  advanced_filtering_on_arrays_enabled = var.advanced_filtering_on_arrays_enabled
  service_bus_queue_endpoint_id = each.value.service_bus_queue_endpoint_id
 
  dynamic "retry_policy" {
    for_each = var.retry_policy
    content {
      max_delivery_attempts = each.value.max_delivery_attempts
      event_time_to_live    = each.value.event_time_to_live
     }
   }
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
  
}*/
