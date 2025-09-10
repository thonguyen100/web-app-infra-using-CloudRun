# Create a new Datadog cloudsql monitor
resource "datadog_monitor" "cloudsql_mysql_database_state" {
  name               = "[${var.asset_lbnref}] ${var.cloudsql_mysql_database_state_counter_name}"
  type               = "service check"
  count              = var.activated_cloudsql_mysql_database_state == "true" ? 1 : 0
  message            = format("%s Notify: %s", var.message_cloudsql_mysql_database_state, (var.notify_cloudsql_mysql_database_state != "" ? var.notify_cloudsql_mysql_database_state : var.notify_to))
  escalation_message = format("%s", (var.escalation_message_cloudsql_mysql_database_state != "" ? var.escalation_message_cloudsql_mysql_database_state : var.escalation_message))

  query = "\"gcp.cloudsql.database.state\".over(\"database_id:${var.asset_name}\").by(${var.scope_activated_cloudsql_mysql_database_state}).last(${var.timeframe_cloudsql_mysql_database_state}).count_by_status()"

  monitor_thresholds {
    warning  = var.threshold_warning_cloudsql_mysql_database_state
    critical = var.threshold_critical_cloudsql_mysql_database_state
    ok       = var.threshold_ok_cloudsql_mysql_database_state
  }

  evaluation_delay  = var.evaluation_delay
  new_host_delay    = var.new_host_delay
  no_data_timeframe = var.no_data_timeframe_cloudsql_mysql_database_state
  notify_no_data    = var.notify_no_data_cloudsql_mysql_database_state
  renotify_interval = 40
  include_tags      = false
  notify_audit      = true
  timeout_h         = 0


  tags = (concat(
    tolist(["monitor_resource_name:cloudsql_mysql_database_state",
      "lbnref:${var.asset_lbnref}",
      "asset_name:${var.asset_name}",
      "template:${var.template}",
      "isprod:${format("%s", (var.isprod_cloudsql_mysql_database_state != "" ? var.isprod_cloudsql_mysql_database_state : var.isprod))}",
      "severity:${var.severity_cloudsql_mysql_database_state}",
      "category:${var.category_cloudsql_mysql_database_state}",
      "customer_name:${var.customer_name}",
      "customer_id:${var.customer_id}",
      "team_in_charge:${var.team_in_charge}",
      "type:${var.type_cloudsql_mysql_database_state}",
      "irp:${var.irp_cloudsql_mysql_database_state}",
      "kb:${var.kb_cloudsql_mysql_database_state}",
    ]),
    var.extra_tags_cloudsql_mysql_database_state
  ))
}
