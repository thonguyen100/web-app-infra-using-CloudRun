variable "environment" {
  description = "The environment for which the database is being created (e.g., dev, staging, prod)."
  type        = string
}
variable "project_id" {
  description = "The GCP project ID where the database instance will be created."
  type        = string
}
variable "project_region" {
  description = "The GCP region where the database instance will be deployed."
  type        = string

}
variable "project_zone" {
  description = "The GCP zone where the database instance will be deployed."
  type        = string
}
variable "domain" {
  description = "The custom domain for the Cloud Run frontend service."
  type        = string
}

# Variables for Cloud Run Front End
variable "max_instance_count" {
  description = "Max number of frontend instances"
  type        = number
  default     = 3
}

# Output variables from Database module
variable "db_instance_connection_name" {
  description = "The connection name of the Cloud SQL database instance."
  type        = string

}
variable "app_database_name" {
  description = "The name of the application database."
  type        = string
}
variable "db_user_name" {
  description = "The name of the database user."
  type        = string

}

# Output variables from Secret Manager module
variable "db_user_password" {
  description = "The ID of the Secret Manager secret for the database user password."
  type        = string
}
variable "db_user_password_v1" {
  description = "The version of the Secret Manager secret for the database user password."
  type        = string
}

# Output variables from Artifact Registry module
variable "artifact_registry_image_path_backend_v1" {
  description = "The Artifact Registry image path."
  type        = string
  default     = "us-docker.pkg.dev/cloudrun/container/hello"
}
variable "artifact_registry_image_path_frontend_v1" {
  description = "The Artifact Registry image path."
  type        = string
  default     = "us-docker.pkg.dev/cloudrun/container/hello"
}
variable "artifact_registry_image_path_webhook_v1" {
  description = "The Artifact Registry image path of webhook"
  type        = string
  default     = "us-docker.pkg.dev/cloudrun/container/hello"
}

# Variables for Datadog Webhook Handler Cloud Run
variable "github_token_for_datadog" {
  description = "GitHub token to trigger repo_dispatch"
  sensitive   = true
}
variable "github_repo_for_datadog" {
  description = "GitHub repo to trigger"

}