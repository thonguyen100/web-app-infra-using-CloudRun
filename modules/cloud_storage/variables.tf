variable "environment" {
  description = "The environment for the Cloud Storage bucket (e.g., dev, staging, prod)"
  type        = string

}

variable "project_id" {
  description = "The GCP project ID where the Cloud Storage bucket will be created"
  type        = string

}