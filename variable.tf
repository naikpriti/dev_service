variable "resource_group_name" {
  description = "A container that holds related resources for an Azure solution"
  type        = string

}

variable "location" {
  description = "The location/region to keep all your network resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table'"
  default     = "eastus"
}   

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}



/*variable "subscription_id" {
  description = "max_size_in_megabytes"
  type        = any
}*/


variable "retry_policy" {
  description = "A map of key value pairs to add to all resources"
  type        = any
  }


variable "subscription_name" {
  description = "subscription_name"
  type = map(object({
    az_subscription_name = string
    storage_account_name = string
  }))
  default = {}
}

variable "advanced_filter" {
  description = "advanced_filter"
  type = any
}


variable "system_topic_name" {
  description = "action group short name"
  type  = string
}


variable "event_subscription_name" {
  description = "action group short name"
  type  = string
}

variable "event_delivery_schema" {
  description = "action group short name"
  type        = string
  default = "EventGridSchema"
}

variable "advanced_filtering_on_arrays_enabled" {
  description = "action group short name"
  type        = bool
  default = true
}

variable "source_resource_id" {
  description = "ID of the Event Grid System Topic ARM Source."
  type        = string
}

variable "included_event_types" {
  description = "ID of the Event Grid System Topic ARM Source."
  type        = list(string)
}

variable "service_bus_queue_endpoint_id" {
  description = "ID of the Event Grid System Topic ARM Source."
  type        = string
}


variable "event_subscription_custom_name" {
  description = "ID of the Event Grid System Topic ARM Source."
  type        = string
}

variable "topic_type" {
  description = "ID of the Event Grid System Topic ARM Source."
  type        = string
}






