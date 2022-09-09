resource "azurerm_eventgrid_system_topic" "example" {
  name                   = "test-subtopic"
  resource_group_name    = "test-grp"
  location               = "eastus"
  source_arm_resource_id = "/subscriptions/cbfacc58-a6b3-4ddf-b84b-7f263275b03b/resourceGroups/test-grp/providers/Microsoft.Storage/storageAccounts/teststoragesub"
  topic_type             = "Microsoft.Storage.StorageAccounts"
}



resource "azurerm_eventgrid_system_topic_event_subscription" "subscription" {
      name                 = "testsub"
      system_topic         = azurerm_eventgrid_system_topic.example.name
      resource_group_name  = "test-grp"
      event_delivery_schema = "EventGridSchema"
      advanced_filtering_on_arrays_enabled = true
      service_bus_queue_endpoint_id = "/subscriptions/cbfacc58-a6b3-4ddf-b84b-7f263275b03b/resourceGroups/test-grp/providers/Microsoft.ServiceBus/namespaces/cru-sub/queues/subqueue"
      included_event_types =  ["Microsoft.Storage.BlobCreated"]
      retry_policy {
         max_delivery_attempts = "3"
         event_time_to_live = "1000"
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
