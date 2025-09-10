#Outputs for root

output "credentials_file" {
  value       = var.credentials_file
  description = "The path to the GCP credentials file"
  sensitive   = true
}
# output "vm_public_ip" {
#   value       = "http://${module.compute.instance_public_ip}"
#   description = "The public IP address of the VM instance from the module"
# }

output "project_zone" {
  value       = var.project_zone
  description = "The project zone where the resources are created"
  sensitive   = false

}

# Outputs for DATABASE MODULE
output "db_private_ip" {
  value = module.database.db_private_ip
}
output "app_database_name" {
  value = module.database.app_database_name
}
output "db_user_name" {
  value = module.database.db_user_name
}
output "db_user_password" {
  value     = module.database.db_user_password
  sensitive = true
}

# Outputs from Cloud Run
output "cloud_run_frontend_service_url_v1" {
  description = "URL of frontend Cloud Run"
  value       = module.cloud_run.cloud_run_frontend_service_url_v1
}

