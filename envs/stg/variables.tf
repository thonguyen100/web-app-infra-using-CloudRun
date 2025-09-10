#Project: Terraform Practice

variable "environment" {
  description = "The environment for the deployment (e.g., staging, production)"
  type        = string
  # default     = "stg"

}

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
variable "project_zone" {
  description = "The GCP zone to deploy resources in"
  type        = string
  sensitive   = false
}
variable "credentials_file" {
  description = "value of the GCP credentials file"
  type        = string
  sensitive   = true
}

# Cloudflare
variable "cloudflare_token" {
  description = "Cloudflare API token for managing DNS records"
  type        = string
  sensitive   = true
}
variable "cloudflare_zone_id" {
  description = "The Cloudflare zone ID for the domain"
  type        = string
  sensitive   = false
}

# GITHUB
# variable "github_token" {
#   description = "GitHub token for accessing private repositories"
#   type        = string
#   sensitive   = true
# }
variable "repo_name" {
  description = "Name of the GitHub repository"
  type        = string
  default     = "terraform-practice-repo"
}
variable "github_repo_url" {
  description = "URL of the GitHub repository to clone"
  type        = string
  sensitive   = true
  default     = ""
}
variable "backend_github_repo" {
  description = "The GitHub repository for the backend application"
  type        = string
  sensitive   = true
}
variable "frontend_github_repo" {
  description = "The GitHub repository for the frontend application"
  type        = string
  sensitive   = true
}
variable "github_token_for_datadog" {
  description = "token for datadog to run CICD"
  sensitive   = true
  default     = ""
}
variable "github_repo_for_datadog" {
  description = "url of the github repo containing terraform files"
  default     = ""
}

variable "domain" {
  description = "The domain name to be managed by Cloudflare"
  type        = string
  sensitive   = false
}

# Database and Secret Manager
variable "db_user_password_v1" {
  description = "The password for the database user"
  type        = string
  sensitive   = true
}

# Monitoring variables
variable "datadog_api_key" {
  description = "api key from datadoghq"
  type        = string
}
variable "datadog_app_key" {
  description = "app key from datadoghq"
  type        = string
}
variable "customer_id" {
  description = "id of customer"
  type        = string
  default     = "0000"
}
variable "asset_name" {
  description = "name of asset being monitored"
  type        = string
  default     = ""
}
variable "asset_lbnref" {
  description = "linkbynet internal id for asset"
  type        = string
  default     = ""
}
variable "customer_name" {
  description = "name of customer"
  type        = string
  default     = "tho-nguyen"
}