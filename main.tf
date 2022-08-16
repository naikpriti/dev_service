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

