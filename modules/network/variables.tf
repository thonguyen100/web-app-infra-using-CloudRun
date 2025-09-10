variable "project_region" {
  description = "The GCP region for the project"
  type        = string

}
variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "environment" {
  description = "The environment for the deployment (e.g., staging, production)"
  type        = string
}

