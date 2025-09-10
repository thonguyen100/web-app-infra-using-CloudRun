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
  default     = "gcp-cloudsql-mysql"
}

variable "global_monitor_type" {
  description = "Global monitor type: custom or standard"
  default     = "standard"
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
  description = "Delay in seconds for the metric evaluation"
  default     = 15
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

## cloudsql_mysql_database_state

variable "cloudsql_mysql_database_state_counter_name" {
  description = "Name of counter cloudsql_mysql_database_state"
  type        = string
  default     = "Database state not healthy"
}

variable "activated_cloudsql_mysql_database_state" {
  description = "If the monitor cloudsql_mysql_database_state is activated"
  type        = string
  default     = "true"
}

variable "scope_activated_cloudsql_mysql_database_state" {
  description = "Scope for monitor cloudsql_mysql_database_state"
  type        = string
  default     = "\"database_id\",\"env\",\"lbnref\",\"project\",\"project_id\",\"region\""
}

variable "message_cloudsql_mysql_database_state" {
  description = "Custom message for monitor [cloudsql_mysql_database_state]"
  type        = string

  default = <<EOM
    This check verify if the database.state of the service cloudsql mysql state is normal.
    See IRP for more informations.
  EOM
}

variable "escalation_message_cloudsql_mysql_database_state" {
  description = "Escalation message for monitor [cloudsql_mysql_database_state]"
  type        = string
  default     = ""
}

variable "notify_cloudsql_mysql_database_state" {
  description = "Define notification hooks for monitor [notify_cloudsql_mysql_database_state]"
  default     = ""
}

variable "isprod_cloudsql_mysql_database_state" {
  description = "Define whether the monitor [cloudsql_mysql_database_state] is in production or not"
  default     = ""
}

variable "irp_cloudsql_mysql_database_state" {
  description = "Define the IRP for monitor [cloudsql_mysql_database_state]"
  default     = "http://intranet.linkbynet.com/v7/Monitoring/IRP/View?Id=8900"
}

variable "kb_cloudsql_mysql_database_state" {
  description = "KB tag value for cloudsql_mysql_database_state"
  type        = string
  default     = "KB0015061"
}

variable "severity_cloudsql_mysql_database_state" {
  description = "Define severity for monitor [cloudsql_mysql_database_state]"
  default     = "1"
}

variable "category_cloudsql_mysql_database_state" {
  description = "Define category for monitor [cloudsql_mysql_database_state]"
  default     = "235"
}

variable "scope_cloudsql_mysql_database_state" {
  description = "Scope for monitor [cloudsql_mysql_database_state]"
  type        = string
  default     = "!custom_cloudsql_mysql_database_state:true"
}

variable "timeframe_cloudsql_mysql_database_state" {
  description = "Monitor timeframe for monitor [cloudsql_mysql_database_state] [available values: `last_#m` (1, 5, 10, 15, or 30), `last_#h` (1, 2, or 4), or `last_1d`]"
  type        = string
  default     = "4"
}

variable "type_cloudsql_mysql_database_state" {
  description = "Type for monitor [cloudsql_mysql_database_state] among incident, information"
  type        = string
  default     = "incident"
}

variable "extra_tags_cloudsql_mysql_database_state" {
  description = "Extra tags for monitor [cloudsql_mysql_database_state]"
  type        = list(string)
  default     = []
}

variable "no_data_timeframe_cloudsql_mysql_database_state" {
  description = "No data timeframe in minutes for monitor [cloudsql_mysql_database_state]"
  default     = 0
}

variable "notify_no_data_cloudsql_mysql_database_state" {
  description = "Will raise no data alert if set to true"
  default     = false
}

variable "threshold_critical_cloudsql_mysql_database_state" {
  description = "Monitor [velero_volume_snapshot_failure] critical threshold"
  default     = "3"
}

variable "threshold_warning_cloudsql_mysql_database_state" {
  description = "Monitor [cloudsql_mysql_database_state] warning threshold"
  default     = "2"
}

variable "threshold_ok_cloudsql_mysql_database_state" {
  description = "Monitor [cloudsql_mysql_database_state] ok threshold"
  default     = "2"
}

## cloudsql_mysql_database_connection

variable "cloudsql_mysql_database_connection_counter_name" {
  description = "Name of counter cloudsql_mysql_database_connection"
  type        = string
  default     = "Connections over defined threshold"
}

variable "activated_cloudsql_mysql_database_connection" {
  description = "If the monitor cloudsql_mysql_database_connection is activated"
  type        = string
  default     = "true"
}

variable "message_cloudsql_mysql_database_connection" {
  description = "Custom message for monitor [cloudsql_mysql_database_connection]"
  type        = string

  default = <<EOM
    This check verify if the database.connections usage of the service cloudsql mysql is above defined threshold during the last timeframe hour.
    See IRP for more informations.  
  EOM
}

variable "escalation_message_cloudsql_mysql_database_connection" {
  description = "Escalation message for monitor [cloudsql_mysql_database_connection]"
  type        = string
  default     = ""
}

variable "notify_cloudsql_mysql_database_connection" {
  description = "Define notification hooks for monitor [notify_cloudsql_mysql_database_connection]"
  default     = ""
}

variable "isprod_cloudsql_mysql_database_connection" {
  description = "Define whether the monitor [cloudsql_mysql_database_connection] is in production or not"
  default     = ""
}

variable "irp_cloudsql_mysql_database_connection" {
  description = "Define the IRP for monitor [cloudsql_mysql_database_connection]"
  default     = "http://intranet.linkbynet.com/v7/Monitoring/IRP/View?Id=8900"
}

variable "kb_cloudsql_mysql_database_connection" {
  description = "KB tag value for cloudsql_mysql_database_connection"
  type        = string
  default     = "KB0015061"
}

variable "severity_cloudsql_mysql_database_connection" {
  description = "Define severity for monitor [cloudsql_mysql_database_connection]"
  default     = "4"
}

variable "category_cloudsql_mysql_database_connection" {
  description = "Define category for monitor [cloudsql_mysql_database_connection]"
  default     = "235"
}

variable "scope_cloudsql_mysql_database_connection" {
  description = "Scope for monitor [cloudsql_mysql_database_connection]"
  type        = string
  default     = "!custom_cloudsql_mysql_database_connection:true"
}

variable "timeframe_cloudsql_mysql_database_connection" {
  description = "Monitor timeframe for monitor [cloudsql_mysql_database_connection] [available values: `last_#m` (1, 5, 10, 15, or 30), `last_#h` (1, 2, or 4), or `last_1d`]"
  type        = string
  default     = "last_1h"
}

variable "type_cloudsql_mysql_database_connection" {
  description = "Type for monitor [cloudsql_mysql_database_connection] among incident, information"
  type        = string
  default     = "incident"
}

variable "extra_tags_cloudsql_mysql_database_connection" {
  description = "Extra tags for monitor [cloudsql_mysql_database_connection]"
  type        = list(string)
  default     = []
}

variable "no_data_timeframe_cloudsql_mysql_database_connection" {
  description = "No data timeframe in minutes for monitor [cloudsql_mysql_database_connection]"
  default     = 0
}

variable "notify_no_data_cloudsql_mysql_database_connection" {
  description = "Will raise no data alert if set to true"
  default     = false
}

variable "threshold_critical_cloudsql_mysql_database_connection" {
  description = "Monitor [cloudsql_mysql_database_connection] critical threshold"
  default     = "500"
}

variable "threshold_critical_recovery_cloudsql_mysql_database_connection" {
  description = "Monitor [cloudsql_mysql_database_connection] critical_recovery threshold"
  default     = "400"
}

## cloudsql_mysql_database_cpu

variable "cloudsql_mysql_database_cpu_counter_name" {
  description = "Name of counter cloudsql_mysql_database_cpu"
  type        = string
  default     = "CPU above threshold"
}

variable "activated_cloudsql_mysql_database_cpu" {
  description = "If the monitor cloudsql_mysql_database_cpu is activated"
  type        = string
  default     = "true"
}

variable "message_cloudsql_mysql_database_cpu" {
  description = "Custom message for monitor [cloudsql_mysql_database_cpu]"
  type        = string

  default = <<EOM
    This check verify if the database.cpu usage of the service cloudsql is above threshold during the last timeframe.
    See IRP for more informations.
  EOM
}

variable "escalation_message_cloudsql_mysql_database_cpu" {
  description = "Escalation message for monitor [cloudsql_mysql_database_cpu]"
  type        = string
  default     = ""
}

variable "notify_cloudsql_mysql_database_cpu" {
  description = "Define notification hooks for monitor [notify_cloudsql_mysql_database_cpu]"
  default     = ""
}

variable "isprod_cloudsql_mysql_database_cpu" {
  description = "Define whether the monitor [cloudsql_mysql_database_cpu] is in production or not"
  default     = ""
}

variable "irp_cloudsql_mysql_database_cpu" {
  description = "Define the IRP for monitor [cloudsql_mysql_database_cpu]"
  default     = "http://intranet.linkbynet.com/v7/Monitoring/IRP/View?Id=8900"
}

variable "kb_cloudsql_mysql_database_cpu" {
  description = "KB tag value for cloudsql_mysql_database_cpu"
  type        = string
  default     = "KB0015061"
}

variable "severity_cloudsql_mysql_database_cpu" {
  description = "Define severity for monitor [cloudsql_mysql_database_cpu]"
  default     = "3"
}

variable "category_cloudsql_mysql_database_cpu" {
  description = "Define category for monitor [cloudsql_mysql_database_cpu]"
  default     = "235"
}

variable "scope_cloudsql_mysql_database_cpu" {
  description = "Scope for monitor [cloudsql_mysql_database_cpu]"
  type        = string
  default     = "!custom_cloudsql_mysql_database_cpu:true"
}

variable "timeframe_cloudsql_mysql_database_cpu" {
  description = "Monitor timeframe for monitor [cloudsql_mysql_database_cpu] [available values: `last_#m` (1, 5, 10, 15, or 30), `last_#h` (1, 2, or 4), or `last_1d`]"
  type        = string
  default     = "last_1h"
}

variable "type_cloudsql_mysql_database_cpu" {
  description = "Type for monitor [cloudsql_mysql_database_cpu] among incident, information"
  type        = string
  default     = "incident"
}

variable "extra_tags_cloudsql_mysql_database_cpu" {
  description = "Extra tags for monitor [cloudsql_mysql_database_cpu]"
  type        = list(string)
  default     = []
}

variable "no_data_timeframe_cloudsql_mysql_database_cpu" {
  description = "No data timeframe in minutes for monitor [cloudsql_mysql_database_cpu]"
  default     = 0
}

variable "notify_no_data_cloudsql_mysql_database_cpu" {
  description = "Will raise no data alert if set to true"
  default     = false
}

variable "threshold_critical_cloudsql_mysql_database_cpu" {
  description = "Monitor [cloudsql_mysql_database_cpu] critical threshold"
  default     = "95"
}

variable "threshold_critical_recovery_cloudsql_mysql_database_cpu" {
  description = "Monitor [cloudsql_mysql_database_cpu] critical threshold"
  default     = "90"
}

## cloudsql_mysql_database_disk

variable "cloudsql_mysql_database_disk_counter_name" {
  description = "Name of counter cloudsql_mysql_database_disk"
  type        = string
  default     = "Disk usage over threshold"
}

variable "activated_cloudsql_mysql_database_disk" {
  description = "If the monitor cloudsql_mysql_database_disk is activated"
  type        = string
  default     = "true"
}

variable "message_cloudsql_mysql_database_disk" {
  description = "Custom message for monitor [cloudsql_mysql_database_disk]"
  type        = string

  default = <<EOM
    This check verify if the database connection usage of the service cloudsql mysql is above threshold during the last timeframe.
  EOM
}

variable "escalation_message_cloudsql_mysql_database_disk" {
  description = "Escalation message for monitor [cloudsql_mysql_database_disk]"
  type        = string
  default     = ""
}

variable "notify_cloudsql_mysql_database_disk" {
  description = "Define notification hooks for monitor [notify_cloudsql_mysql_database_disk]"
  default     = ""
}

variable "isprod_cloudsql_mysql_database_disk" {
  description = "Define whether the monitor [cloudsql_mysql_database_disk] is in production or not"
  default     = ""
}

variable "irp_cloudsql_mysql_database_disk" {
  description = "Define the IRP for monitor [cloudsql_mysql_database_disk]"
  default     = "http://intranet.linkbynet.com/v7/Monitoring/IRP/View?Id=8900"
}

variable "kb_cloudsql_mysql_database_disk" {
  description = "KB tag value for cloudsql_mysql_database_disk"
  type        = string
  default     = "KB0015061"
}

variable "severity_cloudsql_mysql_database_disk" {
  description = "Define severity for monitor [cloudsql_mysql_database_disk]"
  default     = "3"
}

variable "category_cloudsql_mysql_database_disk" {
  description = "Define category for monitor [cloudsql_mysql_database_disk]"
  default     = "235"
}

variable "scope_cloudsql_mysql_database_disk" {
  description = "Scope for monitor [cloudsql_mysql_database_disk]"
  type        = string
  default     = "!custom_cloudsql_mysql_database_disk:true"
}

variable "timeframe_cloudsql_mysql_database_disk" {
  description = "Monitor timeframe for monitor [cloudsql_mysql_database_disk] [available values: `last_#m` (1, 5, 10, 15, or 30), `last_#h` (1, 2, or 4), or `last_1d`]"
  type        = string
  default     = "last_1h"
}

variable "type_cloudsql_mysql_database_disk" {
  description = "Type for monitor [cloudsql_mysql_database_disk] among incident, information"
  type        = string
  default     = "incident"
}

variable "extra_tags_cloudsql_mysql_database_disk" {
  description = "Extra tags for monitor [cloudsql_mysql_database_disk]"
  type        = list(string)
  default     = []
}

variable "no_data_timeframe_cloudsql_mysql_database_disk" {
  description = "No data timeframe in minutes for monitor [cloudsql_mysql_database_disk]"
  default     = 0
}

variable "notify_no_data_cloudsql_mysql_database_disk" {
  description = "Will raise no data alert if set to true"
  default     = false
}

variable "threshold_critical_cloudsql_mysql_database_disk" {
  description = "Monitor [cloudsql_mysql_database_disk] critical threshold"
  default     = "95"
}

variable "threshold_critical_recovery_cloudsql_mysql_database_disk" {
  description = "Monitor [cloudsql_mysql_database_disk] critical_recovery threshold"
  default     = "90"
}

## cloudsql_mysql_database_memory

variable "cloudsql_mysql_database_memory_counter_name" {
  description = "Name of counter cloudsql_mysql_database_memory"
  type        = string
  default     = "Memory over threshold"
}

variable "activated_cloudsql_mysql_database_memory" {
  description = "If the monitor cloudsql_mysql_database_memory is activated"
  type        = string
  default     = "true"
}

variable "message_cloudsql_mysql_database_memory" {
  description = "Custom message for monitor [cloudsql_mysql_database_memory]"
  type        = string

  default = <<EOM
    This check verify if the database.memory usage of the service cloudsql mysql is above defined threshold during the last timeframe.
    See IRP for more informations.
  EOM
}

variable "escalation_message_cloudsql_mysql_database_memory" {
  description = "Escalation message for monitor [cloudsql_mysql_database_memory]"
  type        = string
  default     = ""
}

variable "notify_cloudsql_mysql_database_memory" {
  description = "Define notification hooks for monitor [notify_cloudsql_mysql_database_memory]"
  default     = ""
}

variable "isprod_cloudsql_mysql_database_memory" {
  description = "Define whether the monitor [cloudsql_mysql_database_memory] is in production or not"
  default     = ""
}

variable "irp_cloudsql_mysql_database_memory" {
  description = "Define the IRP for monitor [cloudsql_mysql_database_memory]"
  default     = "http://intranet.linkbynet.com/v7/Monitoring/IRP/View?Id=8900"
}

variable "kb_cloudsql_mysql_database_memory" {
  description = "KB tag value for cloudsql_mysql_database_memory"
  type        = string
  default     = "KB0015061"
}

variable "severity_cloudsql_mysql_database_memory" {
  description = "Define severity for monitor [cloudsql_mysql_database_memory]"
  default     = "1"
}

variable "category_cloudsql_mysql_database_memory" {
  description = "Define category for monitor [cloudsql_mysql_database_memory]"
  default     = "235"
}

variable "scope_cloudsql_mysql_database_memory" {
  description = "Scope for monitor [cloudsql_mysql_database_memory]"
  type        = string
  default     = "!custom_cloudsql_mysql_database_memory:true"
}

variable "timeframe_cloudsql_mysql_database_memory" {
  description = "Monitor timeframe for monitor [cloudsql_mysql_database_memory] [available values: `last_#m` (1, 5, 10, 15, or 30), `last_#h` (1, 2, or 4), or `last_1d`]"
  type        = string
  default     = "last_1h"
}

variable "type_cloudsql_mysql_database_memory" {
  description = "Type for monitor [cloudsql_mysql_database_memory] among incident, information"
  type        = string
  default     = "incident"
}

variable "extra_tags_cloudsql_mysql_database_memory" {
  description = "Extra tags for monitor [cloudsql_mysql_database_memory]"
  type        = list(string)
  default     = []
}

variable "no_data_timeframe_cloudsql_mysql_database_memory" {
  description = "No data timeframe in minutes for monitor [cloudsql_mysql_database_memory]"
  default     = 0
}

variable "notify_no_data_cloudsql_mysql_database_memory" {
  description = "Will raise no data alert if set to true"
  default     = false
}

variable "threshold_critical_cloudsql_mysql_database_memory" {
  description = "Monitor [cloudsql_mysql_database_memory] critical threshold"
  default     = "95"
}

variable "threshold_critical_recovery_cloudsql_mysql_database_memory" {
  description = "Monitor [cloudsql_mysql_database_memory] critical_recovery threshold"
  default     = "90"
}

## cloudsql_mysql_database_replica_lag

variable "cloudsql_mysql_database_replica_lag_counter_name" {
  description = "Name of counter cloudsql_mysql_database_replica_lag"
  type        = string
  default     = "Replica lag over defined threshold"
}

variable "activated_cloudsql_mysql_database_replica_lag" {
  description = "If the monitor cloudsql_mysql_database_replica_lag is activated"
  type        = string
  default     = "true"
}

variable "message_cloudsql_mysql_database_replica_lag" {
  description = "Custom message for monitor [cloudsql_mysql_database_replica_lag]"
  type        = string

  default = <<EOM
    This check verify if the database.replica lag of the service cloudsql mysql is above defined threshold (secondes) during the last timeframe.
    See IRP for more informations.
  EOM
}

variable "escalation_message_cloudsql_mysql_database_replica_lag" {
  description = "Escalation message for monitor [cloudsql_mysql_database_replica_lag]"
  type        = string
  default     = ""
}

variable "notify_cloudsql_mysql_database_replica_lag" {
  description = "Define notification hooks for monitor [notify_cloudsql_mysql_database_replica_lag]"
  default     = ""
}

variable "isprod_cloudsql_mysql_database_replica_lag" {
  description = "Define whether the monitor [cloudsql_mysql_database_replica_lag] is in production or not"
  default     = ""
}

variable "irp_cloudsql_mysql_database_replica_lag" {
  description = "Define the IRP for monitor [cloudsql_mysql_database_replica_lag]"
  default     = "http://intranet.linkbynet.com/v7/Monitoring/IRP/View?Id=8900"
}

variable "kb_cloudsql_mysql_database_replica_lag" {
  description = "KB tag value for cloudsql_mysql_database_replica_lag"
  type        = string
  default     = "KB0015061"
}

variable "severity_cloudsql_mysql_database_replica_lag" {
  description = "Define severity for monitor [cloudsql_mysql_database_replica_lag]"
  default     = "1"
}

variable "category_cloudsql_mysql_database_replica_lag" {
  description = "Define category for monitor [cloudsql_mysql_database_replica_lag]"
  default     = "235"
}

variable "scope_cloudsql_mysql_database_replica_lag" {
  description = "Scope for monitor [cloudsql_mysql_database_replica_lag]"
  type        = string
  default     = "!custom_cloudsql_mysql_database_replica_lag:true"
}

variable "timeframe_cloudsql_mysql_database_replica_lag" {
  description = "Monitor timeframe for monitor [cloudsql_mysql_database_replica_lag] [available values: `last_#m` (1, 5, 10, 15, or 30), `last_#h` (1, 2, or 4), or `last_1d`]"
  type        = string
  default     = "last_1h"
}

variable "type_cloudsql_mysql_database_replica_lag" {
  description = "Type for monitor [cloudsql_mysql_database_replica_lag] among incident, information"
  type        = string
  default     = "incident"
}

variable "extra_tags_cloudsql_mysql_database_replica_lag" {
  description = "Extra tags for monitor [cloudsql_mysql_database_replica_lag]"
  type        = list(string)
  default     = []
}

variable "no_data_timeframe_cloudsql_mysql_database_replica_lag" {
  description = "No data timeframe in minutes for monitor [cloudsql_mysql_database_replica_lag]"
  default     = 0
}

variable "notify_no_data_cloudsql_mysql_database_replica_lag" {
  description = "Will raise no data alert if set to true"
  default     = false
}

variable "threshold_critical_cloudsql_mysql_database_replica_lag" {
  description = "Monitor [cloudsql_mysql_database_replica_lag] critical threshold (lag in seconds)"
  default     = "300"
}

variable "threshold_critical_recovery_cloudsql_mysql_database_replica_lag" {
  description = "Monitor [cloudsql_mysql_database_replica_lag] critical_recovery threshold (lag in seconds)"
  default     = "250"
}

## no_data

variable "activated_no_data" {
  description = "If the monitor [no_data] is activated"
  type        = string
  default     = "true"
}

variable "monitor_type_no_data" {
  description = "Monitor [no_data] type: custom or standard"
  default     = ""
}

variable "message_no_data" {
  description = "Message for monitor [no_data]"
  type        = string

  default = ""
}

variable "custom_message_no_data" {
  description = "Custom message for monitor [no_data]"
  type        = string
  default     = ""
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
  default     = "-1"
}

variable "threshold_critical_recovery_no_data" {
  description = "Monitor [no_data] critical recovery threshold"
  default     = "0"
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
  default     = ""
}

variable "function_no_data" {
  description = "Allow more flexibility to change function of the monitor"
  default     = "avg"
}

variable "spatial_aggregation_no_data" {
  description = "Allow more flexibility to change spatial aggregation of the monitor"
  default     = "avg"
}

variable "threshold_comparator_no_data" {
  description = "Define the comparator for threshold for monitor [no_data]"
  default     = "<"
}

variable "threshold_unit_no_data" {
  description = "Define the comparator for threshold for monitor [no_data]"
  default     = ""
}

variable "additional_message_no_data" {
  description = "Add more information to message for [no_data]"
  default     = ""
}
