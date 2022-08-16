locals {
  isaamservice_exceptions         = contains(var.business_alerts, "isaamservice_exceptions") ? var.app_insights : {}
  ordermatchingservice_exceptions = contains(var.business_alerts, "ordermatchingservice_exceptions") ? var.app_insights : {}
  failure_anomalies_cru_nonprod_eastus  = contains(var.business_alerts, "failure_anomalies_cru_nonprod_eastus") ? var.app_insights : {}
  
}


#AK:
resource "azurerm_monitor_scheduled_query_rules_alert" "ordermatchingservice_exceptions" {
  for_each            = local.ordermatchingservice_exceptions
  name                = "OrderMatchingService_Exceptions"
  location            = var.names.location
  tags                = var.tags
  resource_group_name = var.resource_group

  action {
    action_group = [azurerm_monitor_action_group.businessalertactiongroup.id]
  }
  data_source_id = each.value.provider
  description    = "Alert for OrderMAtchingService_Exceptions"
  enabled        = true
  query          = <<-QUERY
  let timeGrain=5m; 
  exceptions     
  | where timestamp >= ago(timeGrain) and  client_Type != "Browser" and severityLevel >= 3 and cloud_RoleName == "OrderMatching Service"  
  | summarize _count=count()
  QUERY
  frequency      = var.frequency
  time_window    = var.time_window_response
  trigger {
    operator  = "GreaterThan"
    threshold = 5
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert" "isaamservice_exceptions" {
  for_each            = local.isaamservice_exceptions
  name                = "isaamservice_exceptions"
  location            = var.names.location
  resource_group_name = var.resource_group
  tags                = var.tags

  action {
    action_group = [azurerm_monitor_action_group.businessalertactiongroup.id]
  }
  data_source_id = each.value.provider
  description    = "Alert for ISAAMService_Exceptions"
  enabled        = true
  query          = <<-QUERY
  let timeGrain=5m;
  exceptions
  | where timestamp >= ago(timeGrain) and  client_Type != "Browser" and severityLevel >= 3 and cloud_RoleName == "Isaam Service"
  | summarize _count=count()
   QUERY
  frequency      = var.frequency
  time_window    = var.time_window_response
  trigger {
    operator  = "GreaterThan"
    threshold = 5
  }
}

resource "azurerm_monitor_smart_detector_alert_rule" "failure_anomalies_cru_nonprod_eastus" {
  for_each            = local.failure_anomalies_cru_nonprod_eastus
  name                = "failure_anomalies_cru_nonprod_eastus"
  resource_group_name = var.resource_group
  description         = "Failure Anomalies notifies you of an unusual rise in the rate of failed HTTP requests or dependency calls."
  severity            = "Sev3"
  scope_resource_ids  = var.applicationinsight_ids
  frequency           = "PT1M"
  detector_type       = "FailureAnomaliesDetector"

  action_group {
    ids = [azurerm_monitor_action_group.businessalertactiongroup.id]
  }
}
