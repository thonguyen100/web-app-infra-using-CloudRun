# Outputs to automate Datadog monitors
output "asset_name" {
  description = "asset_name of all resources in this module"
  value       = ""

}

# Outputs for Cloud Run service names
output "cloud_run_backend_service_name_v1" {
  description = "The name of the Cloud Run service"
  value       = google_cloud_run_v2_service.back_end.name
}
output "cloud_run_frontend_service_name_v1" {
  description = "The name of the Cloud Run service"
  value       = google_cloud_run_v2_service.front_end.name
}

# Outputs for Cloud Run service URLs
output "cloud_run_backend_service_url_v1" {
  description = "The URL of the Cloud Run backend service"
  value       = google_cloud_run_v2_service.back_end.uri
}
output "cloud_run_frontend_service_url_v1" {
  description = "The URL of the Cloud Run frontend service"
  value       = google_cloud_run_v2_service.front_end.uri
}