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
}
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
# resource "google_project_service" "all_apis" {
#   project = var.project_id
#   for_each = toset(
#     [
#       "networkservices.googleapis.com",
#       "sqladmin.googleapis.com",
#       "run.googleapis.com",
#       "secretmanager.googleapis.com",
#       "artifactregistry.googleapis.com",
#       "storage.googleapis.com",
#       "compute.googleapis.com",
#     ]
#   )
#   service            = each.key
#   disable_on_destroy = false
# }

# IAM permissions for web app visitors (to invoke the app)
# This grants permissions for all website visitors to invoke the frontend
# Note: create this iam permission when push to prod
resource "google_cloud_run_service_iam_member" "frontend_invoker" {
  location = each.value.region
  service  = each.value.asset_name
  for_each = local.monitored_resources
  role     = "roles/run.invoker"
  member   = "allUsers"
}

# A Cloud Run for testing datadog automation
resource "google_cloud_run_v2_service" "test_frontend" {
  for_each = {
    fe1 = { asset_name = "${var.environment}-frontend1", region = "us-central1" }
    fe2 = { asset_name = "${var.environment}-frontend2", region = "asia-east1" }
    fe3 = { asset_name = "${var.environment}-frontend3", region = "asia-east1" }
    fe4 = { asset_name = "${var.environment}-frontend4", region = "asia-east1" }
  }

  name     = each.value.asset_name
  location = each.value.region
  ingress  = "INGRESS_TRAFFIC_ALL"

  template {
    scaling {
      max_instance_count = 3
    }
    containers {
      image = "asia-east1-docker.pkg.dev/peak-nimbus-466309-n1/stg-full-stack-app-frontend/stg-frontend-image@sha256:aef04efe0754b4cb97b318433d9eee6d52c3ad06c038c0639ad9a9fb595d6b10"
      resources {
        limits = {
          cpu    = "2"
          memory = "1024Mi"
        }
      }
    }
  }
  labels = {
    monitor_cpu   = "true" # tells Terraform to create a CPU monitor
    resource_env  = "test"
    resource_type = "cloud_run" # tells the monitoring module what this is
  }
}

locals {
  monitored_resources = {
    for svc_key, svc in google_cloud_run_v2_service.test_frontend :
    svc_key => {
      asset_name                                       = svc.name
      asset_lbnref                                     = "${svc.name}-${svc.location}"
      region                                           = "${svc.location}"
      activated_cpu_utilizations_avg                   = lookup(svc.labels, "monitor_cpu", "false") == "true"
      scope_cpu_utilizations_avg                       = "service_name:${svc.name}"
      isprod                                           = lookup(svc.labels, "resource_env", "") == "prod"
      isprod_cpu_utilizations_avg                      = lookup(svc.labels, "resource_env", "") == "prod" ? "true" : "false"
      customer_name                                    = "ExampleCorp"
      customer_id                                      = "cust-000"
      type_cpu_utilizations_avg                        = lookup(svc.labels, "resource_type", "unknown")
      extra_tags_cpu_utilizations_avg                  = ["region:${svc.location}"]
      message_cpu_utilizations_avg                     = "CPU alert on ${svc.name}"
      threshold_critical_cpu_utilizations_avg          = 80
      threshold_critical_recovery_cpu_utilizations_avg = 60
    }
    if contains(keys(svc.labels), "monitor_cpu") && svc.labels["monitor_cpu"] == "true"
  }
}

# Monitoring
module "monitoring" {
  for_each    = local.monitored_resources
  source      = "../../modules/monitoring/cloudrun-dev"
  environment = var.environment

  asset_name    = each.value.asset_name
  customer_name = each.value.customer_name

  asset_lbnref    = each.value.asset_lbnref
  customer_id     = each.value.customer_id
  datadog_api_key = var.datadog_api_key
  datadog_app_key = var.datadog_app_key
}

# Artifact Registry
# module "artifact_registry" {
#   source         = "../../modules/artifact-registry"
#   project_id     = var.project_id
#   project_region = var.project_region
#   environment    = var.environment
# }

# IAM
# module "iam" {
#   source               = "../../modules/iam"
#   project_id           = var.project_id
#   project_region       = var.project_region
#   environment          = var.environment
#   backend_github_repo  = var.backend_github_repo
#   frontend_github_repo = var.frontend_github_repo
# }

# Cloud Run
# module "cloud_run" {
#   source         = "../../modules/cloud_run"
#   environment    = var.environment
#   project_id     = var.project_id
#   project_region = var.project_region
#   project_zone   = var.project_zone

#   # Inject variables from root
#   domain = var.domain

#   # Inject outputs from DB
#   db_instance_connection_name = module.database.db_instance_connection_name
#   app_database_name           = module.database.app_database_name
#   db_user_name                = module.database.db_user_name


#   # Inject outputs from Secret Manager
#   db_user_password    = module.secret_manager.db_user_password
#   db_user_password_v1 = module.secret_manager.db_user_password_v1

#   # Inject outputs from Artifact Registry
#   artifact_registry_image_path_backend_v1  = module.artifact_registry.artifact_registry_image_path_backend_v1
#   artifact_registry_image_path_frontend_v1 = module.artifact_registry.artifact_registry_image_path_frontend_v1

#   # Inject variables for webhook handler
#   github_token_for_datadog = var.github_token_for_datadog
#   github_repo_for_datadog = var.github_repo_for_datadog
# }

# Database 
# module "database" {
#   source                 = "../../modules/database"
#   project_id             = var.project_id
#   project_region         = var.project_region
#   project_zone           = var.project_zone
#   environment            = var.environment
#   web_app_vpc_name       = module.network.web_app_vpc_name
#   private_vpc_connection = module.network.private_vpc_connection
#   db_user_password       = module.secret_manager.db_user_password_v1
# }

# Secret_Manager
# module "secret_manager" {
#   source              = "../../modules/secret_manager"
#   project_id          = var.project_id
#   project_region      = var.project_region
#   environment         = var.environment
#   db_user_password_v1 = var.db_user_password_v1

#   ## Inject outputs from Artifact Registry
#   # Backend
#   artifact_registry_image_path_backend_v1 = module.artifact_registry.artifact_registry_image_path_backend_v1
#   # Frontend
#   artifact_registry_image_path_frontend_v1 = module.artifact_registry.artifact_registry_image_path_frontend_v1

#   # Inject outputs from Database
#   db_instance_connection_v1 = module.database.db_instance_connection_name
#   app_db_name_v1            = module.database.app_database_name
#   db_user_name_v1           = module.database.db_user_name

#   ## Inject outputs from Cloud Run
#   # Backend
#   cloud_run_backend_service_name_v1 = module.cloud_run.cloud_run_backend_service_name_v1
#   cloud_run_backend_service_url_v1  = module.cloud_run.cloud_run_backend_service_url_v1
#   # Frontend
#   cloud_run_frontend_service_name_v1 = module.cloud_run.cloud_run_frontend_service_name_v1
# }

# Cloud Storage
# module "cloud_storage" {
#   source      = "../../modules/cloud_storage"
#   project_id  = var.project_id
#   environment = var.environment
# }

# Network
# module "network" {
#   source         = "../../modules/network"
#   project_id     = var.project_id
#   project_region = var.project_region
#   environment    = var.environment
# }

# DNS
# module "dns_record" {
#   source             = "../../modules/dns_record"
#   cloudflare_token   = var.cloudflare_token
#   cloudflare_zone_id = var.cloudflare_zone_id
#   environment        = var.environment
#   domain             = var.domain

#   # Inject outputs from Load Balancer
#   lb_static_ip               = module.load_balancer.lb_static_ip
#   lb_static_ip_resource_name = module.load_balancer.lb_static_ip_resource_name

#   # Inject outputs from Cloud Run
#   cloud_run_frontend_service_url_v1 = module.cloud_run.cloud_run_frontend_service_url_v1
# }

# Load Balancer
# module "load_balancer" {
#   source         = "../../modules/load_balancer"
#   project_region = var.project_region
#   environment    = var.environment
#   domain         = var.domain

#   # Inject outputs from Cloud Run
#   cloud_run_frontend_service_name_v1 = module.cloud_run.cloud_run_frontend_service_name_v1
# }




