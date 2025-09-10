# Project varriables
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

# Network variables
variable "web_app_vpc_name" {
  description = "value of the VPC network name"
  type        = string
}
variable "private_vpc_connection" {
  description = "The private VPC connection for the SQL instance."
  type        = string

}

# Secret Manager variables
variable "db_user_password" {
  description = "The password for the database user."
  type        = string
  sensitive   = true
}