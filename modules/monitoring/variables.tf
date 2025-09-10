# Global variables
variable "environment" {
  description = "The environment for the deployment (e.g., staging, production)"
  type        = string
}
variable "datadog_api_key" {
  description = "api key from datadoghq"
  type        = string
}
variable "datadog_app_key" {
  description = "app key from datadoghq"
  type        = string
}

variable "template" {
  description = "Template name"
  default     = "gcp-cloudrun"
}

variable "asset_lbnref" {
  description = "Asset lbnref"
}

variable "asset_name" {
  description = "Asset name"
}

variable "default_tags" {
  description = "map of default tags to set on ressources"
  type        = map(string)
  default     = {}
}

variable "custom_tags" {
  description = "map of custom tags to set on ressources"
  type        = map(string)
  default     = {}
}

variable "isprod" {
  description = "activate the monitor on production on Sentinel"
  default     = "false"
}

variable "notify_to" {
  description = "Define notification hooks"
  default     = "@webhook-SGCProd @monitoring-teams"
}

variable "notify_capacity" {
  description = "to who notify capacity alerts"
  default     = ""
}

variable "category" {
  description = "Category of the monitors"
  default     = "235"
}


variable "kb" {
  description = "KB tag value"
  type        = string
  default     = ""
}

variable "irp" {
  description = "Global IRP for template"
  default     = ""
}

variable "customer_name" {
  description = "Client name as in Idefix"
}

variable "customer_id" {
  description = "ID of the client in Idefix"
}

variable "team_in_charge" {
  description = "Define the team in charge"
  default     = "Undefined"
}

variable "evaluation_delay" {
  description = "Delay in seconds for the metric evaluation, for cloud 900s is recommended by Datadog"
  default     = 900
}

variable "new_host_delay" {
  description = "Delay in seconds before monitor new resource"
  default     = 300
}

variable "escalation_message" {
  description = "Default escalation message"
  default     = ""
}

variable "renotify_interval" {
  description = "Delay in minutes before monitor is renotified"
  default     = 15
}

variable "include_tags" {
  description = "Include triggered event tags in title"
  default     = false
}

# Datadog monitors variables

## cpu_utilizations_avg

variable "activated_cpu_utilizations_avg" {
  description = "If the monitor [cpu_utilizations_avg] is activated"
  type        = string
  default     = "true"
}

variable "message_cpu_utilizations_avg" {
  description = "Custom message for monitor [cpu_utilizations_avg]"
  type        = string

  default = <<EOM
    Average CPU utilization was over defined threshold during last check interval.
    See IRP for more informations.
  EOM
}

variable "escalation_message_cpu_utilizations_avg" {
  description = "Escalation message for monitor [cpu_utilizations_avg]"
  type        = string
  default     = ""
}

variable "notify_cpu_utilizations_avg" {
  description = "Define notification hooks for monitor [notify_cpu_utilizations_avg]"
  default     = ""
}

variable "isprod_cpu_utilizations_avg" {
  description = "Define whether the monitor [cpu_utilizations_avg] is in production or not"
  default     = "false"
}

variable "irp_cpu_utilizations_avg" {
  description = "Define the IRP for monitor [cpu_utilizations_avg]"
  default     = "http://intranet.linkbynet.com/v7/Monitoring/IRP/View?Id=8983"
}



variable "kb_cpu_utilizations_avg" {
  description = "KB tag value for cpu_utilizations_avg"
  type        = string
  default     = "KB0015115"
}

variable "severity_cpu_utilizations_avg" {
  description = "Define severity for monitor [cpu_utilizations_avg]"
  default     = "2"
}

variable "category_cpu_utilizations_avg" {
  description = "Define category for monitor [cpu_utilizations_avg]"
  default     = ""
}

variable "scope_cpu_utilizations_avg" {
  description = "Scope for monitor [cpu_utilizations_avg]"
  type        = string
  default     = ""
}

variable "timeframe_cpu_utilizations_avg" {
  description = "Monitor timeframe for monitor [cpu_utilizations_avg] [available values: `last_#m` (1, 5, 10, 15, or 30), `last_#h` (1, 2, or 4), or `last_1d`]"
  type        = string
  default     = "last_1h"
}

variable "type_cpu_utilizations_avg" {
  description = "Type for monitor [cpu_utilizations_avg] among incident, information"
  type        = string
  default     = "incident"
}

variable "extra_tags_cpu_utilizations_avg" {
  description = "Extra tags for monitor [cpu_utilizations_avg]"
  type        = list(string)
  default     = []
}

variable "no_data_timeframe_cpu_utilizations_avg" {
  description = "No data timeframe in minutes for monitor [cpu_utilizations_avg]"
  default     = 0
}

variable "notify_no_data_cpu_utilizations_avg" {
  description = "Will raise no data alert if set to true"
  default     = false
}

variable "threshold_critical_cpu_utilizations_avg" {
  description = "Monitor [cpu_utilizations_avg] critical threshold"
  default     = "0.0015"
}

variable "threshold_critical_recovery_cpu_utilizations_avg" {
  description = "Monitor [cpu_utilizations_avg] critical recovery threshold"
  default     = "0.0009"
}

variable "tolerance_cpu_utilizations_avg" {
  description = "Give leverage for a mitigation value to limit in case of low connection"
  default     = "1"
}

variable "renotify_interval_cpu_utilizations_avg" {
  description = "Delay in minutes before monitor [cpu_utilizations_avg] is renotified, default: check renotify_interval"
  default     = -42
}

variable "group_by_cpu_utilizations_avg" {
  description = "Define a custom group_by for monitor [cpu_utilizations_avg]"
  default     = "by {configuration_name,service_name}"
}

variable "function_cpu_utilizations_avg" {
  description = "Allow more flexibility to change function of the monitor"
  default     = "avg"
}

variable "spatial_aggregation_cpu_utilizations_avg" {
  description = "Allow more flexibility to change spatial aggregaion of the monitor"
  default     = "min"
}

## memory_utilizations_avg

variable "activated_memory_utilizations_avg" {
  description = "If the monitor [memory_utilizations_avg] is activated"
  type        = string
  default     = "true"
}

variable "message_memory_utilizations_avg" {
  description = "Custom message for monitor [memory_utilizations_avg]"
  type        = string

  default = <<EOM
    Average Memory utilization was over defined threshold during last check interval.
    See IRP for more informations.
  EOM
}

variable "escalation_message_memory_utilizations_avg" {
  description = "Escalation message for monitor [memory_utilizations_avg]"
  type        = string
  default     = ""
}

variable "notify_memory_utilizations_avg" {
  description = "Define notification hooks for monitor [notify_memory_utilizations_avg]"
  default     = ""
}

variable "isprod_memory_utilizations_avg" {
  description = "Define whether the monitor [memory_utilizations_avg] is in production or not"
  default     = "false"
}

variable "irp_memory_utilizations_avg" {
  description = "Define the IRP for monitor [memory_utilizations_avg]"
  default     = "http://intranet.linkbynet.com/v7/Monitoring/IRP/View?Id=8983"
}



variable "kb_memory_utilizations_avg" {
  description = "KB tag value for memory_utilizations_avg"
  type        = string
  default     = "KB0015115"
}

variable "severity_memory_utilizations_avg" {
  description = "Define severity for monitor [memory_utilizations_avg]"
  default     = "1"
}

variable "category_memory_utilizations_avg" {
  description = "Define category for monitor [memory_utilizations_avg]"
  default     = ""
}

variable "scope_memory_utilizations_avg" {
  description = "Scope for monitor [memory_utilizations_avg]"
  type        = string
  default     = ""
}

variable "timeframe_memory_utilizations_avg" {
  description = "Monitor timeframe for monitor [memory_utilizations_avg] [available values: `last_#m` (1, 5, 10, 15, or 30), `last_#h` (1, 2, or 4), or `last_1d`]"
  type        = string
  default     = "last_1h"
}

variable "type_memory_utilizations_avg" {
  description = "Type for monitor [memory_utilizations_avg] among incident, information"
  type        = string
  default     = "incident"
}

variable "extra_tags_memory_utilizations_avg" {
  description = "Extra tags for monitor [memory_utilizations_avg]"
  type        = list(string)
  default     = []
}

variable "no_data_timeframe_memory_utilizations_avg" {
  description = "No data timeframe in minutes for monitor [memory_utilizations_avg]"
  default     = 0
}

variable "notify_no_data_memory_utilizations_avg" {
  description = "Will raise no data alert if set to true"
  default     = false
}

variable "threshold_critical_memory_utilizations_avg" {
  description = "Monitor [memory_utilizations_avg] critical threshold"
  default     = "3"
}

variable "threshold_critical_recovery_memory_utilizations_avg" {
  description = "Monitor [memory_utilizations_avg] critical recovery threshold"
  default     = "2"
}

variable "tolerance_memory_utilizations_avg" {
  description = "Give leverage for a mitigation value to limit in case of low connection"
  default     = "1"
}

variable "renotify_interval_memory_utilizations_avg" {
  description = "Delay in minutes before monitor [memory_utilizations_avg] is renotified, default: check renotify_interval"
  default     = -42
}

variable "group_by_memory_utilizations_avg" {
  description = "Define a custom group_by for monitor [memory_utilizations_avg]"
  default     = "by {configuration_name,service_name}"
}

variable "function_memory_utilizations_avg" {
  description = "Allow more flexibility to change function of the monitor"
  default     = "avg"
}

variable "spatial_aggregation_memory_utilizations_avg" {
  description = "Allow more flexibility to change spatial aggregaion of the monitor"
  default     = "avg"
}

## request_5xx_count

variable "activated_request_5xx_count" {
  description = "If the monitor [request_5xx_count] is activated"
  type        = string
  default     = "true"
}

variable "message_request_5xx_count" {
  description = "Custom message for monitor [request_5xx_count]"
  type        = string

  default = <<EOM
    5xx requests count was over the defined threshold during last check interval.
    See IRP for more informations.
  EOM
}

variable "escalation_message_request_5xx_count" {
  description = "Escalation message for monitor [request_5xx_count]"
  type        = string
  default     = ""
}

variable "notify_request_5xx_count" {
  description = "Define notification hooks for monitor [notify_request_5xx_count]"
  default     = ""
}

variable "isprod_request_5xx_count" {
  description = "Define whether the monitor [request_5xx_count] is in production or not"
  default     = "false"
}

variable "irp_request_5xx_count" {
  description = "Define the IRP for monitor [request_5xx_count]"
  default     = "http://intranet.linkbynet.com/v7/Monitoring/IRP/View?Id=8983"
}



variable "kb_request_5xx_count" {
  description = "KB tag value for request_5xx_count"
  type        = string
  default     = "KB0015115"
}

variable "severity_request_5xx_count" {
  description = "Define severity for monitor [request_5xx_count]"
  default     = "1"
}

variable "category_request_5xx_count" {
  description = "Define category for monitor [request_5xx_count]"
  default     = ""
}

variable "scope_request_5xx_count" {
  description = "Scope for monitor [request_5xx_count]"
  type        = string
  default     = ""
}

variable "timeframe_request_5xx_count" {
  description = "Monitor timeframe for monitor [request_5xx_count] [available values: `last_#m` (1, 5, 10, 15, or 30), `last_#h` (1, 2, or 4), or `last_1d`]"
  type        = string
  default     = "last_1h"
}

variable "type_request_5xx_count" {
  description = "Type for monitor [request_5xx_count] among incident, information"
  type        = string
  default     = "incident"
}

variable "extra_tags_request_5xx_count" {
  description = "Extra tags for monitor [request_5xx_count]"
  type        = list(string)
  default     = []
}

variable "no_data_timeframe_request_5xx_count" {
  description = "No data timeframe in minutes for monitor [request_5xx_count]"
  default     = 0
}

variable "notify_no_data_request_5xx_count" {
  description = "Will raise no data alert if set to true"
  default     = false
}

variable "threshold_critical_request_5xx_count" {
  description = "Monitor [request_5xx_count] critical threshold"
  default     = "3"
}

variable "threshold_critical_recovery_request_5xx_count" {
  description = "Monitor [request_5xx_count] critical recovery threshold"
  default     = "2"
}

variable "tolerance_request_5xx_count" {
  description = "Give leverage for a mitigation value to limit in case of low connection"
  default     = "1"
}

variable "renotify_interval_request_5xx_count" {
  description = "Delay in minutes before monitor [request_5xx_count] is renotified, default: check renotify_interval"
  default     = -42
}

variable "group_by_request_5xx_count" {
  description = "Define a custom group_by for monitor [request_5xx_count]"
  default     = "by {response_code,service_name}"
}

variable "function_request_5xx_count" {
  description = "Allow more flexibility to change function of the monitor"
  default     = "sum"
}

variable "spatial_aggregation_request_5xx_count" {
  description = "Allow more flexibility to change spatial aggregaion of the monitor"
  default     = "sum"
}

## request_4xx_count

variable "activated_request_4xx_count" {
  description = "If the monitor [request_4xx_count] is activated"
  type        = string
  default     = "true"
}

variable "message_request_4xx_count" {
  description = "Custom message for monitor [request_4xx_count]"
  type        = string

  default = <<EOM
    5xx requests count was over the defined threshold during last check interval.
    See IRP for more informations.
  EOM
}

variable "escalation_message_request_4xx_count" {
  description = "Escalation message for monitor [request_4xx_count]"
  type        = string
  default     = ""
}

variable "notify_request_4xx_count" {
  description = "Define notification hooks for monitor [notify_request_4xx_count]"
  default     = ""
}

variable "isprod_request_4xx_count" {
  description = "Define whether the monitor [request_4xx_count] is in production or not"
  default     = "false"
}

variable "irp_request_4xx_count" {
  description = "Define the IRP for monitor [request_4xx_count]"
  default     = "http://intranet.linkbynet.com/v7/Monitoring/IRP/View?Id=8983"
}



variable "kb_request_4xx_count" {
  description = "KB tag value for request_4xx_count"
  type        = string
  default     = "KB0015115"
}

variable "severity_request_4xx_count" {
  description = "Define severity for monitor [request_4xx_count]"
  default     = "3"
}

variable "category_request_4xx_count" {
  description = "Define category for monitor [request_4xx_count]"
  default     = ""
}

variable "scope_request_4xx_count" {
  description = "Scope for monitor [request_4xx_count]"
  type        = string
  default     = ""
}

variable "timeframe_request_4xx_count" {
  description = "Monitor timeframe for monitor [request_4xx_count] [available values: `last_#m` (1, 5, 10, 15, or 30), `last_#h` (1, 2, or 4), or `last_1d`]"
  type        = string
  default     = "last_1h"
}

variable "type_request_4xx_count" {
  description = "Type for monitor [request_4xx_count] among incident, information"
  type        = string
  default     = "incident"
}

variable "extra_tags_request_4xx_count" {
  description = "Extra tags for monitor [request_4xx_count]"
  type        = list(string)
  default     = []
}

variable "no_data_timeframe_request_4xx_count" {
  description = "No data timeframe in minutes for monitor [request_4xx_count]"
  default     = 0
}

variable "notify_no_data_request_4xx_count" {
  description = "Will raise no data alert if set to true"
  default     = false
}

variable "threshold_critical_request_4xx_count" {
  description = "Monitor [request_4xx_count] critical threshold"
  default     = "3"
}

variable "threshold_critical_recovery_request_4xx_count" {
  description = "Monitor [request_4xx_count] critical recovery threshold"
  default     = "2"
}

variable "tolerance_request_4xx_count" {
  description = "Give leverage for a mitigation value to limit in case of low connection"
  default     = "1"
}

variable "renotify_interval_request_4xx_count" {
  description = "Delay in minutes before monitor [request_4xx_count] is renotified, default: check renotify_interval"
  default     = -42
}

variable "group_by_request_4xx_count" {
  description = "Define a custom group_by for monitor [request_4xx_count]"
  default     = "by {response_code,service_name}"
}

variable "function_request_4xx_count" {
  description = "Allow more flexibility to change function of the monitor"
  default     = "sum"
}

variable "spatial_aggregation_request_4xx_count" {
  description = "Allow more flexibility to change spatial aggregaion of the monitor"
  default     = "sum"
}

## no_data

variable "activated_no_data" {
  description = "If the monitor [no_data] is activated"
  type        = string
  default     = "true"
}

variable "message_no_data" {
  description = "Custom message for monitor [no_data]"
  type        = string

  default = <<EOM
    This check verify if the current service returns correctly data to Datadog. 
    See IRP for more informations.
  EOM
}

variable "escalation_message_no_data" {
  description = "Escalation message for monitor [no_data]"
  type        = string
  default     = ""
}

variable "notify_no_data" {
  description = "Define notification hooks for monitor [notify_no_data]"
  default     = ""
}

variable "isprod_no_data" {
  description = "Define whether the monitor [no_data] is in production or not"
  default     = "false"
}

variable "irp_no_data" {
  description = "Define the IRP for monitor [no_data]"
  default     = "http://intranet.linkbynet.com/v7/Monitoring/IRP/View?Id=10298"
}



variable "kb_no_data" {
  description = "KB tag value for no_data"
  type        = string
  default     = "KB0016296"
}

variable "severity_no_data" {
  description = "Define severity for monitor [no_data]"
  default     = "2"
}

variable "category_no_data" {
  description = "Define category for monitor [no_data]"
  default     = "293"
}

variable "scope_no_data" {
  description = "Scope for monitor [no_data]"
  type        = string
  default     = ""
}

variable "timeframe_no_data" {
  description = "Monitor timeframe for monitor [no_data] [available values: `last_#m` (1, 5, 10, 15, or 30), `last_#h` (1, 2, or 4), or `last_1d`]"
  type        = string
  default     = "last_1h"
}

variable "type_no_data" {
  description = "Type for monitor [no_data] among incident, information"
  type        = string
  default     = "incident"
}

variable "extra_tags_no_data" {
  description = "Extra tags for monitor [no_data]"
  type        = list(string)
  default     = []
}

variable "no_data_timeframe_no_data" {
  description = "No data timeframe in minutes for monitor [no_data]"
  default     = 1440
}

variable "notify_no_data_no_data" {
  description = "Will raise no data alert if set to true"
  default     = true
}

variable "threshold_critical_no_data" {
  description = "Monitor [no_data] critical threshold"
  default     = "100"
}

variable "threshold_critical_recovery_no_data" {
  description = "Monitor [no_data] critical recovery threshold"
  default     = "99"
}

variable "tolerance_no_data" {
  description = "Give leverage for a mitigation value to limit in case of low connection"
  default     = "1"
}

variable "renotify_interval_no_data" {
  description = "Delay in minutes before monitor [no_data] is renotified, default: check renotify_interval"
  default     = -42
}

variable "group_by_no_data" {
  description = "Define a custom group_by for monitor [no_data]"
  default     = "by {state,service_name}"
}

variable "function_no_data" {
  description = "Allow more flexibility to change function of the monitor"
  default     = "avg"
}

variable "spatial_aggregation_no_data" {
  description = "Allow more flexibility to change spatial aggregaion of the monitor"
  default     = "avg"
}
