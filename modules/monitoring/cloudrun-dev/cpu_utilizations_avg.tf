# Create a new Datadog template-skeleton monitor
resource "datadog_monitor" "cpu_utilizations_avg" {
  name = "[${var.asset_lbnref}] Average CPU utilization to high"
  type = "metric alert" # This is a metric alert for the metric gcp.run.container.cpu.utilizations.avg
  # only create the monitor if ...
  count = var.activated_cpu_utilizations_avg == "true" ? 1 : 0
  # Main noti message for the alert
  message = format("%s Notify: %s", var.message_cpu_utilizations_avg, (var.notify_cpu_utilizations_avg != "" ? var.notify_cpu_utilizations_avg : var.notify_to))
  # Massage sent if the alert escalates
  escalation_message = format("%s", (var.escalation_message_cpu_utilizations_avg != "" ? var.escalation_message_cpu_utilizations_avg : var.escalation_message))

  # This builds a Datadog metric query for Cloud Run CPU usage. This uses multiple vars for: 
  ## aggregation function
  ## time window
  ## scope (filters)
  ## grouping
  ## threshold
  query = "${var.function_cpu_utilizations_avg}(${var.timeframe_cpu_utilizations_avg}):${var.spatial_aggregation_cpu_utilizations_avg}:gcp.run.container.cpu.utilizations.avg{${format("%s", (var.scope_cpu_utilizations_avg != "" ? var.scope_cpu_utilizations_avg : format("service_name:%s", var.asset_name)))}} ${var.group_by_cpu_utilizations_avg} >= ${var.threshold_critical_cpu_utilizations_avg}"

  # This is for critical alert and recovery values
  monitor_thresholds {
    critical_recovery = var.threshold_critical_recovery_cpu_utilizations_avg

    critical = var.threshold_critical_cpu_utilizations_avg
  }

  # These are vars for Timing & Notification Options
  ## evaluation_delay = delay between event and evaluation
  ## new_host_delay = delay before evaluating new hosts
  ## no_data_timeframe = time to consider "no data" a failure
  ## notify_no_data = alert if no data received
  ## renotify_interval = re-notify interval. uses default if -42 is used
  ## include_tags, require_full_window, notify_audit, timeout_h = various alert behaviors
  evaluation_delay    = var.evaluation_delay
  new_host_delay      = var.new_host_delay
  no_data_timeframe   = var.no_data_timeframe_cpu_utilizations_avg
  notify_no_data      = var.notify_no_data_cpu_utilizations_avg
  renotify_interval   = format("%s", (var.renotify_interval_cpu_utilizations_avg != -42 ? var.renotify_interval_cpu_utilizations_avg : var.renotify_interval))
  include_tags        = var.include_tags
  require_full_window = false
  notify_audit        = true
  timeout_h           = 0

  # Theses are monitor-specific tags, mostly derived from vars
  # These use fallback values when some are empty
  # Includes metadata like:
  ## customer info
  ## severity
  ## team
  ## type
  ## IRP / KB
  # extra_tags_cpu_utilizations_avg = a list of extra tags
  tags = (concat(
    tolist(["monitor_resource_name:cpu_utilizations_avg",
      "asset_name:${var.asset_name}",
      "lbnref:${var.asset_lbnref}",
      "template:${var.template}",
      "isprod:${format("%s", (var.isprod_cpu_utilizations_avg != "" ? var.isprod_cpu_utilizations_avg : var.isprod))}",
      "severity:${var.severity_cpu_utilizations_avg}",
      "category:${format("%s", (var.category_cpu_utilizations_avg != "" ? var.category_cpu_utilizations_avg : var.category))}",
      "customer_name:${var.customer_name}",
      "customer_id:${var.customer_id}",
      "team_in_charge:${var.team_in_charge}",
      "type:${var.type_cpu_utilizations_avg}",
      "irp:${format("%s", (var.irp != "" ? var.irp : var.irp_cpu_utilizations_avg))}",
      "kb:${format("%s", (var.kb != "" ? var.kb : var.kb_cpu_utilizations_avg))}",
    ]),
    var.extra_tags_cpu_utilizations_avg
  ))
}
