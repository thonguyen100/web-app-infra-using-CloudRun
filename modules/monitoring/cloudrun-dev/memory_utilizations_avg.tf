# Create a new Datadog template-skeleton monitor
resource "datadog_monitor" "memory_utilizations_avg" {
  name               = "[${var.asset_lbnref}] Average memory utilization to high"
  type               = "metric alert"
  count              = var.activated_memory_utilizations_avg == "true" ? 1 : 0
  message            = format("%s Notify: %s", var.message_memory_utilizations_avg, (var.notify_memory_utilizations_avg != "" ? var.notify_memory_utilizations_avg : var.notify_to))
  escalation_message = format("%s", (var.escalation_message_memory_utilizations_avg != "" ? var.escalation_message_memory_utilizations_avg : var.escalation_message))

  query = "${var.function_memory_utilizations_avg}(${var.timeframe_memory_utilizations_avg}):${var.spatial_aggregation_memory_utilizations_avg}:gcp.run.container.memory.utilizations.avg{${format("%s", (var.scope_memory_utilizations_avg != "" ? var.scope_memory_utilizations_avg : format("service_name:%s", var.asset_name)))}} ${var.group_by_memory_utilizations_avg} >= ${var.threshold_critical_memory_utilizations_avg}"

  monitor_thresholds {
    critical_recovery = var.threshold_critical_recovery_memory_utilizations_avg
    critical          = var.threshold_critical_memory_utilizations_avg
  }

  evaluation_delay    = var.evaluation_delay
  new_host_delay      = var.new_host_delay
  no_data_timeframe   = var.no_data_timeframe_memory_utilizations_avg
  notify_no_data      = var.notify_no_data_memory_utilizations_avg
  renotify_interval   = format("%s", (var.renotify_interval_memory_utilizations_avg != -42 ? var.renotify_interval_memory_utilizations_avg : var.renotify_interval))
  include_tags        = var.include_tags
  require_full_window = false
  notify_audit        = true
  timeout_h           = 0


  tags = (concat(
    tolist(["monitor_resource_name:memory_utilizations_avg",
      "asset_name:${var.asset_name}",
      "lbnref:${var.asset_lbnref}",
      "template:${var.template}",
      "isprod:${format("%s", (var.isprod_memory_utilizations_avg != "" ? var.isprod_memory_utilizations_avg : var.isprod))}",
      "severity:${var.severity_memory_utilizations_avg}",
      "category:${format("%s", (var.category_memory_utilizations_avg != "" ? var.category_memory_utilizations_avg : var.category))}",
      "customer_name:${var.customer_name}",
      "customer_id:${var.customer_id}",
      "team_in_charge:${var.team_in_charge}",
      "type:${var.type_memory_utilizations_avg}",
      "irp:${format("%s", (var.irp != "" ? var.irp : var.irp_memory_utilizations_avg))}",
      "kb:${format("%s", (var.kb != "" ? var.kb : var.kb_memory_utilizations_avg))}",
    ]),
    var.extra_tags_memory_utilizations_avg
  ))
}
