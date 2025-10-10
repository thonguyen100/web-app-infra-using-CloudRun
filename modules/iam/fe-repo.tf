## IAM permissions for Frontend Repo
# Grant Github Front Repo some access to GCP resources
resource "google_iam_workload_identity_pool" "frontend_github_repo_pool" {

  workload_identity_pool_id = "${var.environment}-frontend-github-ci-pool"
  display_name              = "${var.environment} Frontend GitHub CI Pool"
  description               = "Workload Identity Pool for GitHub Actions CI of frontend in ${var.environment} environment"
}

resource "google_iam_workload_identity_pool_provider" "frontend_github_repo_as_identity_provider" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.frontend_github_repo_pool.workload_identity_pool_id
  workload_identity_pool_provider_id = "${var.environment}-frontend-repo"
  display_name                       = "${var.environment} Frontend as ID Provider"
  description                        = "Provider for GitHub Actions CI of frontend in ${var.environment} environment"

  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.repository" = "assertion.repository"
    "attribute.aud"        = "assertion.aud"
  }
  attribute_condition = "assertion.repository == \"${var.frontend_github_repo}\""
}

# This grants frontend SA permission to use WIF
resource "google_service_account_iam_member" "frontend_github_repo_as_service_account" {
  service_account_id = google_service_account.frontend_github_repo.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.frontend_github_repo_pool.name}/attribute.repository/${var.frontend_github_repo}"

  depends_on = [google_service_account.frontend_github_repo]
}

# This grants frontend SA permission to write to Artifact Registry
resource "google_project_iam_member" "frontend_github_repo_ar_writer" {
  project = var.project_id
  role    = "roles/artifactregistry.writer"
  member  = "serviceAccount:${google_service_account.frontend_github_repo.email}"

  depends_on = [google_service_account.frontend_github_repo]
}

# This grants frontend SA permission to deploy to Cloud Run
resource "google_project_iam_member" "frontend_github_repo_run_admin" {
  project = var.project_id
  role    = "roles/run.admin"
  member  = "serviceAccount:${google_service_account.frontend_github_repo.email}"

  depends_on = [google_service_account.frontend_github_repo]
}

# This grants frontend SA permission to use the runtime service account when deploying to Cloud Run
resource "google_project_iam_member" "frontend_github_repo_sa_user" {
  project = var.project_id
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${google_service_account.frontend_github_repo.email}"

  depends_on = [google_service_account.frontend_github_repo]
}

# This grants frontend SA permission as Secret Manager Admin
resource "google_project_iam_member" "frontend_github_repo_secret_admin" {
  project = var.project_id
  role    = "roles/secretmanager.admin"
  member  = "serviceAccount:${google_service_account.frontend_github_repo.email}"

  depends_on = [google_service_account.frontend_github_repo]
}

resource "google_service_account" "frontend_github_repo" {
  account_id   = "${var.environment}-frontend-github-ci"
  display_name = "${var.environment} Frontend GitHub CI Service Account"
}

# ## IAM permissions for Backend Repo
# # Grant Github Backend Repo some access to GCP resources
# resource "google_iam_workload_identity_pool" "backend_github_repo_pool" {

#   workload_identity_pool_id = "${var.environment}-backend-github-ci-pool"
#   display_name              = "${var.environment} Backend GitHub CI Pool"
#   description               = "Workload Identity Pool for GitHub Actions CI of backend in ${var.environment} environment"
# }

# resource "google_iam_workload_identity_pool_provider" "backend_github_repo_as_identity_provider" {
#   workload_identity_pool_id          = google_iam_workload_identity_pool.backend_github_repo_pool.workload_identity_pool_id
#   workload_identity_pool_provider_id = "${var.environment}-backend-repo"
#   display_name                       = "${var.environment} Backend as ID Provider"
#   description                        = "Provider for GitHub Actions CI of backend in ${var.environment} environment"

#   oidc {
#     issuer_uri = "https://token.actions.githubusercontent.com"
#   }
#   attribute_mapping = {
#     "google.subject"       = "assertion.sub"
#     "attribute.repository" = "assertion.repository"
#     "attribute.aud"        = "assertion.aud"
#   }
#   attribute_condition = "assertion.repository == \"${var.backend_github_repo}\""
# }

# # This grants backend SA permission to use WIF
# resource "google_service_account_iam_member" "backend_github_repo_as_service_account" {
#   service_account_id = google_service_account.backend_github_repo.name
#   role               = "roles/iam.workloadIdentityUser"
#   member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.backend_github_repo_pool.name}/attribute.repository/${var.backend_github_repo}"

#   depends_on = [google_service_account.backend_github_repo]
# }

# # This grants backend SA permission to write to Artifact Registry
# resource "google_project_iam_member" "backend_github_repo_ar_writer" {
#   project = var.project_id
#   role    = "roles/artifactregistry.writer"
#   member  = "serviceAccount:${google_service_account.backend_github_repo.email}"

#   depends_on = [google_service_account.backend_github_repo]
# }

# # This grants backend SA permission to deploy to Cloud Run
# resource "google_project_iam_member" "backend_github_repo_run_admin" {
#   project = var.project_id
#   role    = "roles/run.admin"
#   member  = "serviceAccount:${google_service_account.backend_github_repo.email}"

#   depends_on = [google_service_account.backend_github_repo]
# }

# # This grants backend SA permission to use the runtime service account when deploying to Cloud Run
# resource "google_project_iam_member" "backend_github_repo_sa_user" {
#   project = var.project_id
#   role    = "roles/iam.serviceAccountUser"
#   member  = "serviceAccount:${google_service_account.backend_github_repo.email}"

#   depends_on = [google_service_account.backend_github_repo]
# }

# # This grants backend SA permission as Cloud SQL Client
# resource "google_project_iam_member" "backend_github_repo_sql_reader_writer" {
#   project = var.project_id
#   role    = "roles/cloudsql.client"
#   member  = "serviceAccount:${google_service_account.backend_github_repo.email}"

#   depends_on = [google_service_account.backend_github_repo]
# }

# # This grants backend SA permission as Secret Manager Admin
# resource "google_project_iam_member" "backend_github_repo_secret_admin" {
#   project = var.project_id
#   role    = "roles/secretmanager.admin"
#   member  = "serviceAccount:${google_service_account.backend_github_repo.email}"

#   depends_on = [google_service_account.backend_github_repo]
# }

# # The grants backend SA permission as Storage Admin (to access Cloud Storage)
# resource "google_project_iam_member" "backend_github_repo_storage_admin" {
#   project = var.project_id
#   role    = "roles/storage.admin"
#   member  = "serviceAccount:${google_service_account.backend_github_repo.email}"

#   depends_on = [google_service_account.backend_github_repo]
# }

# resource "google_service_account" "backend_github_repo" {
#   account_id   = "${var.environment}-backend-github-ci"
#   display_name = "${var.environment} Backend GitHub CI Service Account"
# }

# # If above code run well, we will do the same thing to frontend

## IAM permissions for web app visitors (to invoke the app)
# This grants permissions for all website visitors to invoke the frontend
# Note: create this iam permission when push to prod
# resource "google_cloud_run_service_iam_member" "frontend_invoker" {
#   service = google_cloud_run_v2_service.front_end.name
#   role = "roles/run.invoker"
#   member = "allUsers"
# }

## IAM permissions for cloud run as webhook handler
# This allows public access
# resource "google_cloud_run_service_iam_member" "webhook_handler_public_invoker" {
#   service = google_cloud_run_service.datadog_webhook_handler.name
#   location = google_cloud_run_service.datadog_webhook_handler.location
#   role = "roles/run.invoker"
#   member = "allUsers"

# }