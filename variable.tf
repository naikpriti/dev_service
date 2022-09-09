variable "system_topic_name" {
  description = "action group short name"
  type  = string
}

variable "advanced_filter" {
  description = "Advanced filter maps"
  type        = any
  default     = []
}

variable "event_sub_name" {
  description = "action group short name"
  type  = string
}

variable "event_delivery_schema" {
  description = "action group short name"
  type        = string
  default = "EventGridSchema"
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

variable "topic_type" {
  description = "ID of the Event Grid System Topic ARM Source."
  type        = string
}
