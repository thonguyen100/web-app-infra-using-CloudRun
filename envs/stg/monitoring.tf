# Monitoring-frontend
module "monitoring_frontend" {
  source      = "../../modules/monitoring/cloudrun-dev"
  environment = var.environment

  datadog_api_key = var.datadog_api_key
  datadog_app_key = var.datadog_app_key

  customer_id   = var.customer_id
  asset_name    = module.cloud_run.cloud_run_frontend_service_name_v1
  asset_lbnref  = "${var.environment}-cloud-run-frontend"
  customer_name = var.customer_name
}

# Monitoring-backend
module "monitoring_backend" {
  source      = "../../modules/monitoring/cloudrun-dev"
  environment = var.environment

  datadog_api_key = var.datadog_api_key
  datadog_app_key = var.datadog_app_key

  customer_id   = var.customer_id
  asset_name    = module.cloud_run.cloud_run_backend_service_name_v1
  asset_lbnref  = "${var.environment}-cloud-run-backend"
  customer_name = var.customer_name
}

# Monitoring for the mysql db
module "monitoring_db" {
  source      = "../../modules/monitoring/cloudsql_mysql-dev"
  environment = var.environment

  datadog_api_key = var.datadog_api_key
  datadog_app_key = var.datadog_app_key

  customer_id   = var.customer_id
  asset_name    = module.database.db_instance_connection_name
  asset_lbnref  = "${var.environment}-db"
  customer_name = var.customer_name
}

# Monitoring for the test_cr
# module "test_monitor" {
#   source      = "../../modules/monitoring/cloudrun-dev"
#   environment = var.environment

#   datadog_api_key = var.datadog_api_key
#   datadog_app_key = var.datadog_app_key

#   customer_id   = var.customer_id
#   asset_name    = "${var.environment}-test-cr-by-terraform"
#   asset_lbnref  = "${var.environment}-test-cr"
#   customer_name = var.customer_name
# }