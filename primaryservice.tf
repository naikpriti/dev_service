resource "azurerm_servicebus_namespace" "busNamespace" {
  for_each      =var.services_bus_namespace_name
  name                = each.key
  location            = var.location
  resource_group_name = var.resource_group
  sku                 = "Standard"
  tags                = var.tags
  local_auth_enabled  = false
}

# Queue for regular messages
resource "azurerm_servicebus_queue" "app1MessagesQueue" {
  for_each            = var.messages_queue_name
  name                = each.key
  #resource_group_name = var.resource_group
  #namespace_id      = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group}/providers/Microsoft.ServiceBus/namespaces/"
  namespace_id = each.value.services_bus_namespace_name
  max_size_in_megabytes = var.max_size_in_megabytes   
}


resource "azurerm_monitor_action_group" "businessalertactiongroup" {
  name                = var.business_action_group_name
  resource_group_name = var.resource_group
  short_name          = var.business_action_group_short_name
  tags                = var.tags

  dynamic "email_receiver" {
    for_each = var.business_email_receiver_list
    content {
      name                    = lookup(email_receiver.value, "name", null)
      email_address           = lookup(email_receiver.value, "email_address", null)
      use_common_alert_schema = lookup(email_receiver.value, "use_common_alert_schema", true)
    }
  }
}