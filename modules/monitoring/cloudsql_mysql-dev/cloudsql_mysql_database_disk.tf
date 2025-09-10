# Create a new Datadog cloudsql monitor
resource "datadog_monitor" "cloudsql_mysql_database_disk" {
  name               = "[${var.asset_lbnref}] ${var.cloudsql_mysql_database_disk_counter_name}"
  type               = "metric alert"
  count              = var.activated_cloudsql_mysql_database_disk == "true" ? 1 : 0
  message            = format("%s Notify: %s", var.message_cloudsql_mysql_database_disk, (var.notify_cloudsql_mysql_database_disk != "" ? var.notify_cloudsql_mysql_database_disk : var.notify_to))
  escalation_message = format("%s", (var.escalation_message_cloudsql_mysql_database_disk != "" ? var.escalation_message_cloudsql_mysql_database_disk : var.escalation_message))

  query = "avg(${var.timeframe_cloudsql_mysql_database_disk}):avg:gcp.cloudsql.database.disk.utilization{database_id:${var.asset_name}} * 100 > ${var.threshold_critical_cloudsql_mysql_database_disk}"

  monitor_thresholds {
    critical_recovery = var.threshold_critical_recovery_cloudsql_mysql_database_disk
    critical          = var.threshold_critical_cloudsql_mysql_database_disk
  }

  evaluation_delay  = var.evaluation_delay
  new_host_delay    = var.new_host_delay
  no_data_timeframe = var.no_data_timeframe_cloudsql_mysql_database_disk
  notify_no_data    = var.notify_no_data_cloudsql_mysql_database_disk
  renotify_interval = 40
  include_tags      = false
  notify_audit      = true
  timeout_h         = 0


  tags = (concat(
    tolist(["monitor_resource_name:cloudsql_mysql_database_disk",
      "lbnref:${var.asset_lbnref}",
      "asset_name:${var.asset_name}",
      "template:${var.template}",
      "isprod:${format("%s", (var.isprod_cloudsql_mysql_database_disk != "" ? var.isprod_cloudsql_mysql_database_disk : var.isprod))}",
      "severity:${var.severity_cloudsql_mysql_database_disk}",
      "category:${var.category_cloudsql_mysql_database_disk}",
      "customer_name:${var.customer_name}",
      "customer_id:${var.customer_id}",
      "team_in_charge:${var.team_in_charge}",
      "type:${var.type_cloudsql_mysql_database_disk}",
      "irp:${var.irp_cloudsql_mysql_database_disk}",
      "kb:${var.kb_cloudsql_mysql_database_disk}",
    ]),
    var.extra_tags_cloudsql_mysql_database_disk
  ))
}
