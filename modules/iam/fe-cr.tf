# This grants permission for FE CR to invoke BE CR
resource "google_cloud_run_service_iam_member" "backend_invoker" {
  service = var.cloud_run_backend_service_name_v1
  role = "roles/run.invoker"
  member = "serviceAccount:${google_service_account.frontend_cloud_run.email}"

  depends_on = [ google_service_account.frontend_cloud_run ]
}
resource "google_service_account" "frontend_cloud_run" {
  account_id   = "${var.environment}-frontend-cloud-run"
  display_name = "${var.environment} Frontend Cloud Run Service Account"
}