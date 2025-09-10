terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
    datadog = {
      source = "DataDog/datadog"
    }
  }

  backend "gcs" {
    bucket = "stg-mysterious-bucket"
    prefix = "stg/remote-backend"
  }
}
# Configure the Datadog provider
provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
  api_url = "https://api.ap1.datadoghq.com"

}
# Github
provider "github" {
  token = var.github_token
}

# GCP-config
provider "google" {
  project     = var.project_id
  region      = var.project_region
  zone        = var.project_zone
  credentials = var.credentials_file

}

# All-apis
resource "google_project_service" "all_apis" {
  project = var.project_id
  for_each = toset(
    [
      "networkservices.googleapis.com",
      "sqladmin.googleapis.com",
      "run.googleapis.com",
      "secretmanager.googleapis.com",
      "artifactregistry.googleapis.com",
      "storage.googleapis.com",
      "compute.googleapis.com",
    ]
  )
  service            = each.key
  disable_on_destroy = false
}

# Artifact Registry
module "artifact_registry" {
  source         = "../../modules/artifact-registry"
  project_id     = var.project_id
  project_region = var.project_region
  environment    = var.environment
}

# IAM
module "iam" {
  source               = "../../modules/iam"
  project_id           = var.project_id
  project_region       = var.project_region
  environment          = var.environment
  backend_github_repo  = var.backend_github_repo
  frontend_github_repo = var.frontend_github_repo
}

# Cloud Run
module "cloud_run" {
  source         = "../../modules/cloud_run"
  environment    = var.environment
  project_id     = var.project_id
  project_region = var.project_region
  project_zone   = var.project_zone

  # Inject variables from root
  domain = var.domain

  # Inject outputs from DB
  db_instance_connection_name = module.database.db_instance_connection_name
  app_database_name           = module.database.app_database_name
  db_user_name                = module.database.db_user_name


  # Inject outputs from Secret Manager
  db_user_password    = module.secret_manager.db_user_password
  db_user_password_v1 = module.secret_manager.db_user_password_v1

  # Inject outputs from Artifact Registry
  artifact_registry_image_path_backend_v1  = module.artifact_registry.artifact_registry_image_path_backend_v1
  artifact_registry_image_path_frontend_v1 = module.artifact_registry.artifact_registry_image_path_frontend_v1

  # Inject variables for webhook handler
  github_token_for_datadog = var.github_token_for_datadog
  github_repo_for_datadog  = var.github_repo_for_datadog
}

# Database 
module "database" {
  source                 = "../../modules/database"
  project_id             = var.project_id
  project_region         = var.project_region
  project_zone           = var.project_zone
  environment            = var.environment
  web_app_vpc_name       = module.network.web_app_vpc_name
  private_vpc_connection = module.network.private_vpc_connection
  db_user_password       = module.secret_manager.db_user_password_v1
}

# Secret_Manager
module "secret_manager" {
  source              = "../../modules/secret_manager"
  project_id          = var.project_id
  project_region      = var.project_region
  environment         = var.environment
  db_user_password_v1 = var.db_user_password_v1

  ## Inject outputs from Artifact Registry
  # Backend
  artifact_registry_image_path_backend_v1 = module.artifact_registry.artifact_registry_image_path_backend_v1
  # Frontend
  artifact_registry_image_path_frontend_v1 = module.artifact_registry.artifact_registry_image_path_frontend_v1

  # Inject outputs from Database
  db_instance_connection_v1 = module.database.db_instance_connection_name
  app_db_name_v1            = module.database.app_database_name
  db_user_name_v1           = module.database.db_user_name

  ## Inject outputs from Cloud Run
  # Backend
  cloud_run_backend_service_name_v1 = module.cloud_run.cloud_run_backend_service_name_v1
  cloud_run_backend_service_url_v1  = module.cloud_run.cloud_run_backend_service_url_v1
  # Frontend
  cloud_run_frontend_service_name_v1 = module.cloud_run.cloud_run_frontend_service_name_v1
}

# Cloud Storage
module "cloud_storage" {
  source      = "../../modules/cloud_storage"
  project_id  = var.project_id
  environment = var.environment
}

# Network
module "network" {
  source         = "../../modules/network"
  project_id     = var.project_id
  project_region = var.project_region
  environment    = var.environment
}

# DNS
module "dns_record" {
  source             = "../../modules/dns_record"
  cloudflare_token   = var.cloudflare_token
  cloudflare_zone_id = var.cloudflare_zone_id
  environment        = var.environment
  domain             = var.domain

  # Inject outputs from Load Balancer
  lb_static_ip               = module.load_balancer.lb_static_ip
  lb_static_ip_resource_name = module.load_balancer.lb_static_ip_resource_name

  # Inject outputs from Cloud Run
  cloud_run_frontend_service_url_v1 = module.cloud_run.cloud_run_frontend_service_url_v1
}

# Load Balancer
module "load_balancer" {
  source         = "../../modules/load_balancer"
  project_region = var.project_region
  environment    = var.environment
  domain         = var.domain

  # Inject outputs from Cloud Run
  cloud_run_frontend_service_name_v1 = module.cloud_run.cloud_run_frontend_service_name_v1
}

# Monitoring
# module "monitoring" {
#   source          = "../../modules/monitoring/cloudrun-dev"
#   environment     = var.environment
#   datadog_api_key = var.datadog_api_key
#   datadog_app_key = var.datadog_app_key
#   customer_id     = var.customer_id
#   asset_name      = module.cloud_run.cloud_run_frontend_service_name_v1
#   asset_lbnref    = var.asset_lbnref
#   customer_name   = var.customer_name
# }


