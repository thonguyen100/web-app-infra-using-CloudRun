# Create a new Datadog template-skeleton monitor
resource "datadog_monitor" "request_4xx_count" {
  name               = "[${var.asset_lbnref}] High client request errors"
  type               = "metric alert"
  count              = var.activated_request_4xx_count == "true" ? 1 : 0
  message            = format("%s Notify: %s", var.message_request_4xx_count, (var.notify_request_4xx_count != "" ? var.notify_request_4xx_count : var.notify_to))
  escalation_message = format("%s", (var.escalation_message_request_4xx_count != "" ? var.escalation_message_request_4xx_count : var.escalation_message))

  query = "${var.function_request_4xx_count}(${var.timeframe_request_4xx_count}):${var.spatial_aggregation_request_4xx_count}:gcp.run.request_count{${format("%s", (var.scope_request_4xx_count != "" ? var.scope_request_4xx_count : format("service_name:%s, response_code_class:4xx", var.asset_name)))}} ${var.group_by_request_4xx_count} >= ${var.threshold_critical_request_4xx_count}"

  monitor_thresholds {
    critical_recovery = var.threshold_critical_recovery_request_4xx_count
    critical          = var.threshold_critical_request_4xx_count
  }

  evaluation_delay    = var.evaluation_delay
  new_host_delay      = var.new_host_delay
  no_data_timeframe   = var.no_data_timeframe_request_4xx_count
  notify_no_data      = var.notify_no_data_request_4xx_count
  renotify_interval   = format("%s", (var.renotify_interval_request_4xx_count != -42 ? var.renotify_interval_request_4xx_count : var.renotify_interval))
  include_tags        = var.include_tags
  require_full_window = false
  notify_audit        = true
  timeout_h           = 0


  tags = (concat(
    tolist(["monitor_resource_name:request_4xx_count",
      "asset_name:${var.asset_name}",
      "lbnref:${var.asset_lbnref}",
      "template:${var.template}",
      "isprod:${format("%s", (var.isprod_request_4xx_count != "" ? var.isprod_request_4xx_count : var.isprod))}",
      "severity:${var.severity_request_4xx_count}",
      "category:${format("%s", (var.category_request_4xx_count != "" ? var.category_request_4xx_count : var.category))}",
      "customer_name:${var.customer_name}",
      "customer_id:${var.customer_id}",
      "team_in_charge:${var.team_in_charge}",
      "type:${var.type_request_4xx_count}",
      "irp:${format("%s", (var.irp != "" ? var.irp : var.irp_request_4xx_count))}",
      "kb:${format("%s", (var.kb != "" ? var.kb : var.kb_request_4xx_count))}",
    ]),
    var.extra_tags_request_4xx_count
  ))
}
