# Frontend-image
resource "google_artifact_registry_repository" "full-stack-app-frontend" {
  location      = var.project_region
  repository_id = "${var.environment}-full-stack-app-frontend"
  description   = "${var.environment}-full-stack-app-frontend Docker repo"
  format        = "DOCKER"

  docker_config {
    immutable_tags = false
  }
}

# Backend-image
resource "google_artifact_registry_repository" "full-stack-app-backend" {
  location      = var.project_region
  repository_id = "${var.environment}-full-stack-app-backend"
  description   = "${var.environment}-full-stack-app-backend Docker repo"
  format        = "DOCKER"

  docker_config {
    immutable_tags = false
  }
}

# Datadog-webhook-handler-image
# resource "google_artifact_registry_repository" "datadog_webhook_handler_repo" {
#   location = var.project_region
#   repository_id = "${var.environment}-datadog-webhook-handler-repo"
#   format = "DOCKER"
# }
