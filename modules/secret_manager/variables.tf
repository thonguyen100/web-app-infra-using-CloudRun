variable "project_id" {
  description = "The GCP project ID to deploy resources in"
  type        = string
  sensitive   = true
}
variable "project_region" {
  description = "The GCP region to deploy resources in"
  type        = string
  sensitive   = true
}
variable "environment" {
  description = "The environment to deploy resources in"
  type        = string
  sensitive   = true
}

# Variables from artifact registry
variable "artifact_registry_image_path_backend_v1" {
  description = "Artifact Registry backend image path "
  type        = string
  sensitive   = true
}
variable "artifact_registry_image_path_frontend_v1" {
  description = "Artifact Registry frontend image path"
  type        = string
  sensitive   = true
}

# Variables from cloud run
variable "cloud_run_backend_service_name_v1" {
  description = "The name of the Cloud Run backend service"
  type        = string
  sensitive   = true
}
variable "cloud_run_frontend_service_name_v1" {
  description = "The name of the Cloud Run frontend service"
  type        = string
  sensitive   = true
}
variable "cloud_run_backend_service_url_v1" {
  description = "The URL of the backend service for frontend to call"
  type        = string
  sensitive   = true

}

# Variables from database
variable "db_instance_connection_v1" {
  description = "DB instance connection name"
  type        = string
  sensitive   = true
}
variable "app_db_name_v1" {
  description = "DB name"
  type        = string
  sensitive   = true
}
variable "db_user_name_v1" {
  description = "DB user name"
  type        = string
  sensitive   = true
}
variable "db_user_password_v1" {
  description = "Password of DB user"
  type        = string
  sensitive   = true
}
