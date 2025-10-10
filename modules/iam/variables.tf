variable "environment" {
  description = "The environment for which the resource is being created (e.g., dev, staging, prod)."
  type        = string
}
variable "project_id" {
  description = "The GCP project ID where the resource will be created."
  type        = string
}
variable "project_region" {
  description = "The GCP region where the resource will be deployed."
  type        = string

}

# Vars for Github Repos
variable "backend_github_repo" {
  description = "Backend GitHub repo = your-username/your-repo"
  type        = string
}
variable "frontend_github_repo" {
  description = "Frontend GitHub repo = your-username/your-repo"
  type        = string
}

# Outputs from CR Module 
variable "cloud_run_backend_service_name_v1" {
  description = "The name of the backend Cloud Run service (v1)."
  type        = string
}