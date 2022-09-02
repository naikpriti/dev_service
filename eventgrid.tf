resource "azurerm_eventgrid_system_topic" "eventgrid_system_topic" {
  name                = var.system_topic_name
  resource_group_name = var.resource_group
  location            = var.location

  source_arm_resource_id = var.source_resource_id
  topic_type             = var.topic_type

  identity {
    type = "SystemAssigned"
  }

 
}


resource "azurerm_eventgrid_system_topic_event_subscription" "event_subscription" {
  name                = var.event_subscription_name
  system_topic        = element(split("/", var.eventgrid_system_topic_id), 8)
  resource_group_name = var.resource_group

  event_delivery_schema = var.event_delivery_schema
  service_bus_queue_endpoint_id = try(var.service_bus_queue_endpoint_id, "")

  included_event_types = var.included_event_types

  dynamic "advanced_filter" {
    for_each = var.advanced_filter != null ? ["advanced_filter"] : []
    content {
      dynamic "bool_equals" {
        for_each = lookup(var.advanced_filter, "bool_equals", {}) != {} ? ["bool_equals"] : []
        content {
          key   = lookup(var.advanced_filter, "bool_equals.key", null)
          value = lookup(var.advanced_filter, "bool_equals.value", null)
        }
      }
      dynamic "number_greater_than" {
        for_each = lookup(var.advanced_filter, "number_greater_than", {}) != {} ? ["number_greater_than"] : []
        content {
          key   = lookup(var.advanced_filter, "number_greater_than.key", null)
          value = lookup(var.advanced_filter, "number_greater_than.value", null)
        }
      }
      dynamic "number_greater_than_or_equals" {
        for_each = lookup(var.advanced_filter, "number_greater_than_or_equals", {}) != {} ? ["number_greater_than_or_equals"] : []
        content {
          key   = lookup(var.advanced_filter, "number_greater_than_or_equals.key", null)
          value = lookup(var.advanced_filter, "number_greater_than_or_equals.value", null)
        }
      }
      dynamic "number_less_than" {
        for_each = lookup(var.advanced_filter, "number_less_than", {}) != {} ? ["number_less_than"] : []
        content {
          key   = lookup(var.advanced_filter, "number_less_than.key", null)
          value = lookup(var.advanced_filter, "number_less_than.value", null)
        }
      }
      dynamic "number_less_than_or_equals" {
        for_each = lookup(var.advanced_filter, "number_less_than_or_equals", {}) != {} ? ["number_less_than_or_equals"] : []
        content {
          key   = lookup(var.advanced_filter, "number_less_than_or_equals.key", null)
          value = lookup(var.advanced_filter, "number_less_than_or_equals.value", null)
        }
      }
      dynamic "number_in" {
        for_each = lookup(var.advanced_filter, "number_in", {}) != {} ? ["number_in"] : []
        content {
          key    = lookup(var.advanced_filter, "number_in.key", null)
          values = lookup(var.advanced_filter, "number_in.values", null)
        }
      }
      dynamic "number_not_in" {
        for_each = lookup(var.advanced_filter, "number_not_in", {}) != {} ? ["number_not_in"] : []
        content {
          key    = lookup(var.advanced_filter, "number_not_in.key", null)
          values = lookup(var.advanced_filter, "number_not_in.values", null)
        }
      }
      dynamic "string_begins_with" {
        for_each = lookup(var.advanced_filter, "string_begins_with", {}) != {} ? ["string_begins_with"] : []
        content {
          key    = lookup(var.advanced_filter, "string_begins_with.key", null)
          values = lookup(var.advanced_filter, "string_begins_with.values", null)
        }
      }
      dynamic "string_not_begins_with" {
        for_each = lookup(var.advanced_filter, "string_not_begins_with", {}) != {} ? ["string_not_begins_with"] : []
        content {
          key    = lookup(var.advanced_filter, "string_not_begins_with.key", null)
          values = lookup(var.advanced_filter, "string_not_begins_with.values", null)
        }
      }
      dynamic "string_ends_with" {
        for_each = lookup(var.advanced_filter, "string_ends_with", {}) != {} ? ["string_ends_with"] : []
        content {
          key    = lookup(var.advanced_filter, "string_ends_with.key", null)
          values = lookup(var.advanced_filter, "string_ends_with.values", null)
        }
      }
      dynamic "string_not_ends_with" {
        for_each = lookup(var.advanced_filter, "string_not_ends_with", {}) != {} ? ["string_not_ends_with"] : []
        content {
          key    = lookup(var.advanced_filter, "string_not_ends_with.key", null)
          values = lookup(var.advanced_filter, "string_not_ends_with.values", null)
        }
      }
      dynamic "string_contains" {
        for_each = lookup(var.advanced_filter, "string_contains", {}) != {} ? ["string_contains"] : []
        content {
          key    = lookup(var.advanced_filter, "string_contains.key", null)
          values = lookup(var.advanced_filter, "string_contains.values", null)
        }
      }
      dynamic "string_not_contains" {
        for_each = lookup(var.advanced_filter, "string_not_contains", {}) != {} ? ["string_not_contains"] : []
        content {
          key    = lookup(var.advanced_filter, "string_not_contains.key", null)
          values = lookup(var.advanced_filter, "string_not_contains.values", null)
        }
      }
      dynamic "string_in" {
        for_each = lookup(var.advanced_filter, "string_in", {}) != {} ? ["string_in"] : []
        content {
          key    = lookup(var.advanced_filter, "string_in.key", null)
          values = lookup(var.advanced_filter, "string_in.values", null)
        }
      }
      dynamic "string_not_in" {
        for_each = lookup(var.advanced_filter, "string_not_in", {}) != {} ? ["string_not_in"] : []
        content {
          key    = lookup(var.advanced_filter, "string_not_in.key", null)
          values = lookup(var.advanced_filter, "string_not_in.values", null)
        }
      }
      dynamic "is_not_null" {
        for_each = lookup(var.advanced_filter, "is_not_null", {}) != {} ? ["is_not_null"] : []
        content {
          key = lookup(var.advanced_filter, "is_not_null.key", null)
        }
      }
      dynamic "is_null_or_undefined" {
        for_each = lookup(var.advanced_filter, "is_null_or_undefined", {}) != {} ? ["is_null_or_undefined"] : []
        content {
          key = lookup(var.advanced_filter, "is_null_or_undefined.key", null)
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

  advanced_filtering_on_arrays_enabled = var.advanced_filtering_on_arrays_enabled
}