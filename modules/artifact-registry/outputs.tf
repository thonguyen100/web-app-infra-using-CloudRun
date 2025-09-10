output "artifact_registry_image_path_backend_v1" {
  description = "Artifact Registry image path"
  value       = "${var.project_region}-docker.pkg.dev/${var.project_id}/${google_artifact_registry_repository.full-stack-app-backend.name}/${var.environment}-backend-image"
}

output "artifact_registry_image_path_frontend_v1" {
  description = "Artifact Registry image path"
  value       = "${var.project_region}-docker.pkg.dev/${var.project_id}/${google_artifact_registry_repository.full-stack-app-frontend.name}/${var.environment}-frontend-image"
}
