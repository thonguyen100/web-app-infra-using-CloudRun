# Create a new Datadog template-skeleton monitor
resource "datadog_monitor" "no_data" {
  name  = "[${var.asset_lbnref}] Missing monitoring data on service ${var.template}"
  type  = "metric alert"
  count = var.activated_no_data == "true" ? 1 : 0

  message = <<EOM
    "${(var.custom_message_no_data != "" ? var.custom_message_no_data :
  format(
    "Alert will be risen if there was missing data for service during %s. Notify: %s Additonal informations: %s.",
    var.timeframe_no_data,
    (var.notify_no_data != "" ? var.notify_no_data : var.notify_to),
    var.additional_message_no_data
))}"
  EOM

escalation_message = format("%s", (var.escalation_message_no_data != "" ? var.escalation_message_no_data : var.escalation_message))

query = <<EOQ
    ${var.function_no_data}(${var.timeframe_no_data}):${var.spatial_aggregation_no_data}:gcp.cloudsql.database.network.connections{
      ${format("%s", (var.scope_no_data != "" ? var.scope_no_data : format("lbnref:%s", var.asset_lbnref)))}
    } ${var.group_by_no_data} ${var.threshold_comparator_no_data} ${var.threshold_critical_no_data}
  EOQ

monitor_thresholds {
  critical_recovery = var.threshold_critical_recovery_no_data
  critical          = var.threshold_critical_no_data
}

evaluation_delay    = var.evaluation_delay
new_host_delay      = var.new_host_delay
no_data_timeframe   = var.no_data_timeframe_no_data
notify_no_data      = var.notify_no_data_no_data
renotify_interval   = format("%s", (var.renotify_interval_no_data != -42 ? var.renotify_interval_no_data : var.renotify_interval))
include_tags        = var.include_tags
require_full_window = true
notify_audit        = true
timeout_h           = 0


tags = (concat(
  tolist(["monitor_resource_name:no_data",
    "asset_name:${var.asset_name}",
    "lbnref:${var.asset_lbnref}",
    "template:${var.template}",
    "monitor_type:${format("%s", (var.monitor_type_no_data != "" ? var.monitor_type_no_data : var.global_monitor_type))}",
    "isprod:${format("%s", (var.isprod_no_data != "" ? var.isprod_no_data : var.isprod))}",
    "severity:${var.severity_no_data}",
    "category:${format("%s", (var.category_no_data != "" ? var.category_no_data : var.category))}",
    "customer_name:${var.customer_name}",
    "customer_id:${var.customer_id}",
    "team_in_charge:${var.team_in_charge}",
    "type:${var.type_no_data}",
    "irp:${format("%s", (var.irp != "" ? var.irp : var.irp_no_data))}",
    "kb:${format("%s", (var.kb != "" ? var.kb : var.kb_no_data))}",
  ]),
  var.extra_tags_no_data
))
}
