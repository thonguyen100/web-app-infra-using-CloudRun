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