variable "environment" {
  description = "env of current infra"
  type        = string
}
variable "project_region" {
  description = "the region which current infra is deployed in"
}
variable "domain" {
  description = "domain of current env"
  type        = string
}

variable "cloud_run_frontend_service_name_v1" {
  description = "name of frontend Cloud Run"
  type        = string
}