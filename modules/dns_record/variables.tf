variable "environment" {
  description = "The environment for the deployment (e.g., staging, production)"
  type        = string
}

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

variable "domain" {
  description = "The domain name to be managed by Cloudflare"
  type        = string
  sensitive   = false
}

# Inject outputs from Cloud Run
variable "cloud_run_frontend_service_url_v1" {
  description = "The URL of the Cloud Run frontend service"
  type        = string
  sensitive   = false
}

# Inject outputs from LB to dns record
variable "lb_static_ip" {
  description = "lb static ip"
  type        = string
}
variable "lb_static_ip_resource_name" {
  description = "lb static ip resource name"
  type        = string
}