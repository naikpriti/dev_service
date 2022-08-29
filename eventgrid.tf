resource "azurerm_eventgrid_system_topic" "system_topic" {
  for_each               = var.system_topic
  name                   = each.key
  resource_group_name    = var.resource_group
  location               = var.location
  source_arm_resource_id = each.value.storage_account_id
  topic_type             = "Microsoft.Storage.StorageAccounts"
  tags                   = []

}

resource "azurerm_eventgrid_system_topic_event_subscription" "event_subscription" {
  for_each            = var.system_topic_event_subscription
  name                = each.key
  system_topic        = each.value.system_topic_name
  resource_group_name = var.resource_group
  event_delivery_schema = var.event_delivery_schema
  advanced_filtering_on_arrays_enabled = var.advanced_filtering_on_arrays_enabled
  included_event_types = each.value.included_event_types
  service_bus_queue_endpoint_id = each.value.service_bus_queue_endpoint_id
  retry_policy {
      max_delivery_attempts = "${each.value.max_delivery_attempts}"
      event_time_to_live    = "${each.value.event_time_to_live}"
  }
  advanced_filter {
     key = "${each.value.key}"
     values = "${each.value.values}"
     opertor = "${each.value.operator}" 
     
  }

}
