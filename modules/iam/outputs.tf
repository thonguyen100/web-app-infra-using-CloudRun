output "backend_cloud_run_email" {
  description = "The email of the service account for the backend Cloud Run service"
  value       = google_service_account.backend_cloud_run.email
}