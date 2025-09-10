# resource "datadog_webhook_integration" "github_dispatch_webhook" {
#   name = "${var.environment}-github-actions-trigger"
#   url  = google_cloud_run_service.datadog_webhook_handler.status[0].url

#   headers = {
#     "Content-Type" = "application/json"
#   }

#   payload = jsonencode({
#     alert_type = "{{alert_type}}",
#     title      = "{{title}}",
#     text       = "{{text}}"
#   })

#   encode_as = "json"
# }

# resource "datadog_monitor" "frontend_request_count_sum" {
#   name = "${var.environment}-frontend-request-count-sum"
#   type = "metric alert"
#   # message            = "Monitor triggered. stg frontend in DANGER. Notify: @tho.c.nguyen@accenture.com , @haithonguyen0305@gmail.com"
#   message = <<EOT
#   Monitor triggered. stg frontend in DANGER. 
#   Notify: @tho.c.nguyen@accenture.com , @haithonguyen0305@gmail.com ,
#   @webhook
#   {{#is_alert}}Scaling up Cloud Run.{{/is_alert}}
#   {{#is_recovery}}Scaling down Cloud Run.{{/is_recovery}}
#   EOT

#   escalation_message = "Escalation message @tho.c.nguyen@accenture.com"

#   query = "sum(last_1h):sum:gcp.run.request_count{configuration_name:stg-front-end-by-terraform}.as_count() > 175"

#   monitor_thresholds {
#     warning = 150

#     critical = 175

#     critical_recovery = 150
#   }

#   include_tags        = true
#   require_full_window = false

#   tags = ["test", "team:stg"]
# }
