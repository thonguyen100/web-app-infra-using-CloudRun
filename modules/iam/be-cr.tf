# This grants permissions to backend Cloud Run to access VPC Connector
resource "google_project_iam_member" "cloudsql_backend_access" {
  project = var.project_id
  role    = "roles/cloudsql.client"
  member  = "serviceAccount:${google_service_account.backend_cloud_run.email}"
}

resource "google_project_iam_member" "secret_manager_backend_access" {
  project = var.project_id
  role    = "roles/secretmanager.secretAccessor"
  member  = "serviceAccount:${google_service_account.backend_cloud_run.email}"
}

resource "google_service_account" "backend_cloud_run" {
  account_id   = "${var.environment}-backend-cloud-run"
  display_name = "${var.environment} Backend Cloud Run Service Account"
}