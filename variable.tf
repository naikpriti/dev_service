variable "resource_group" {
  description = "A container that holds related resources for an Azure solution"
  type        = string

}

variable "messages_queue_name" {
  description = "messagesqueue_name"
  type = map(object({
    services_bus_namespace_name = any
    max_size = string
  }))
  default = {}
}


variable "services_bus_namespace_name" {
  description = "services_bus_namespace_name"
  type = any
}

variable "location" {
  description = "The location/region to keep all your network resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table'"
  default     = "useast2"
}   

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "max_size_in_megabytes" {
  description = "max_size_in_megabytes"
  type        = any
  default     = 1024
}

/*variable "subscription_id" {
  description = "max_size_in_megabytes"
  type        = any
}*/


variable "names" {
  description = "A map of key value pairs to add to all resources"
  type        = map(string)
  default     = {}
}



variable "subscription_name" {
  description = "subscription_name"
  type = map(object({
    az_subscription_name = string
    storage_account_name = string
  }))
  default = {}
}

variable "system_topic_name" {
  description = "action group short name"
   type = map(object({
    name = any
    storage_account_id = any
  }))
  default = {}
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


/*variable "advanced_filter" {
  description = "action group short name"
  type        = string
}*/





variable "event_subscription" {
  description = "action group short name"
   type = map(object({
    name = any
    system_topic_name = any 
    storage_account_id = any
    included_event_types = any 
    service_bus_queue_endpoint_id = any 
    max_delivery_attempts = any 
    event_time_to_live = any 
    key = any 
    values= any 
    opertor = any 
  }))
  default = {}
}