# Create a new Datadog cloudsql monitor
resource "datadog_monitor" "cloudsql_mysql_database_memory" {
  name               = "[${var.asset_lbnref}] ${var.cloudsql_mysql_database_memory_counter_name}"
  type               = "metric alert"
  count              = var.activated_cloudsql_mysql_database_memory == "true" ? 1 : 0
  message            = format("%s Notify: %s", var.message_cloudsql_mysql_database_memory, (var.notify_cloudsql_mysql_database_memory != "" ? var.notify_cloudsql_mysql_database_memory : var.notify_to))
  escalation_message = format("%s", (var.escalation_message_cloudsql_mysql_database_memory != "" ? var.escalation_message_cloudsql_mysql_database_memory : var.escalation_message))

  query = "avg(${var.timeframe_cloudsql_mysql_database_memory}):avg:gcp.cloudsql.database.memory.utilization{database_id:${var.asset_name}} * 100 > ${var.threshold_critical_cloudsql_mysql_database_memory}"

  monitor_thresholds {
    critical_recovery = var.threshold_critical_recovery_cloudsql_mysql_database_memory
    critical          = var.threshold_critical_cloudsql_mysql_database_memory
  }

  evaluation_delay  = var.evaluation_delay
  new_host_delay    = var.new_host_delay
  no_data_timeframe = var.no_data_timeframe_cloudsql_mysql_database_memory
  notify_no_data    = var.notify_no_data_cloudsql_mysql_database_memory
  renotify_interval = 40
  include_tags      = false
  notify_audit      = true
  timeout_h         = 0


  tags = (concat(
    tolist(["monitor_resource_name:cloudsql_mysql_database_memory",
      "lbnref:${var.asset_lbnref}",
      "asset_name:${var.asset_name}",
      "template:${var.template}",
      "isprod:${format("%s", (var.isprod_cloudsql_mysql_database_memory != "" ? var.isprod_cloudsql_mysql_database_memory : var.isprod))}",
      "severity:${var.severity_cloudsql_mysql_database_memory}",
      "category:${var.category_cloudsql_mysql_database_memory}",
      "customer_name:${var.customer_name}",
      "customer_id:${var.customer_id}",
      "team_in_charge:${var.team_in_charge}",
      "type:${var.type_cloudsql_mysql_database_memory}",
      "irp:${var.irp_cloudsql_mysql_database_memory}",
      "kb:${var.kb_cloudsql_mysql_database_memory}",
    ]),
    var.extra_tags_cloudsql_mysql_database_memory
  ))
}
