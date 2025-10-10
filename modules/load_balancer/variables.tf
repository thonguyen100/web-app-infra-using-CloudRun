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

# Variables from Cloud Run module
variable "cloud_run_frontend_service_name_v1" {
  description = "name of frontend Cloud Run"
  type        = string
}
variable "cloud_run_backend_service_name_v1" {
  description = "name of backend Cloud Run"
  type        = string
}

# Variables from Network module
variable "web_app_vpc_name" {
  description = "name of VPC"
  type        = string
}
variable "subnet_be_name" {
  description = "name of backend subnet"
  type        = string
}