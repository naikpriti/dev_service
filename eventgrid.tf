resource "azurerm_eventgrid_system_topic" "example" {
  name                   = var.system_topic_name
  resource_group_name    = "test-grp"
  location               = "eastus"
  source_arm_resource_id = var.source_arm_resource_id
  topic_type             = "Microsoft.Storage.StorageAccounts"
}



resource "azurerm_eventgrid_system_topic_event_subscription" "subscription" {
      name                 = var.event_sub_name
      system_topic         = var.system_topic_name
      resource_group_name  = "test-grp"
      event_delivery_schema = var.event_delivery_schema
      advanced_filtering_on_arrays_enabled = true
      service_bus_queue_endpoint_id = var.service_bus_queue_endpoint_id
      included_event_types =  var.included_event_types
      dynamic "retry_policy" {
         max_delivery_attempts = var.max_delivery_attempts
         event_time_to_live = var.event_time_to_live
       }   
      dynamic "advanced_filter" {
        for_each = length(try(var.advanced_filter[0], [])) != 0 ? [var.advanced_filter] : []
        content {
          dynamic "string_contains" {
            for_each = [for filter in advanced_filter.value : [filter.string_contains] if try(filter.string_contains, null) != null]
            content {
              key   = string_contains.value[0].key
              values = string_contains.value[0].values
            }
          }
    
          dynamic "number_greater_than" {
            for_each = [for filter in advanced_filter.value : [filter.number_greater_than] if try(filter.number_greater_than, null) != null]
            content {
              key   = number_greater_than.value[0].key
              value = number_greater_than.value[0].value
            }
          }
    
          dynamic "number_greater_than_or_equals" {
            for_each = [for filter in advanced_filter.value : [filter.number_greater_than_or_equals] if try(filter.number_greater_than_or_equals, null) != null]
            content {
              key   = number_greater_than_or_equals.value[0].key
              value = number_greater_than_or_equals.value[0].value
            }
          }

}
}
}
