# Back-end 
resource "google_cloud_run_v2_service" "back_end" {
  name     = "${var.environment}-backend-by-terraform"
  location = var.project_region

  # deletion_protection = true
  ingress = "INGRESS_TRAFFIC_INTERNAL_LOAD_BALANCER"

  template {
    scaling {
      max_instance_count = 3
    }
    vpc_access {
      connector = var.vpc_connector_be
      egress    = "ALL_TRAFFIC"
    }
    service_account = var.backend_cloud_run_email

    volumes {
      name = "cloudsql"
      cloud_sql_instance {
        instances = [var.db_instance_connection_name]
      }
    }

    containers {
      image = "${var.artifact_registry_image_path_backend_v1}:latest"
      # image = "us-docker.pkg.dev/cloudrun/container/hello"

      env {
        name  = "INSTANCE_CONNECTION_NAME"
        value = var.db_instance_connection_name
      }
      env {
        name = "DB_HOST"
        # value = "/cloudsql/${var.db_instance_connection_name}"
        value = "10.135.0.3"
      }
      env {
        name  = "DB_NAME"
        value = var.app_database_name
      }
      env {
        name  = "DB_USER"
        value = var.db_user_name
      }
      env {
        name = "DB_PASS"
        value_source {
          secret_key_ref {
            secret  = var.db_user_password
            version = "latest"
          }
        }
      }
      volume_mounts {
        name       = "cloudsql"
        mount_path = "/cloudsql"
      }
    }
  }

  traffic {
    type    = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
    percent = 100
  }
  depends_on = [var.db_user_password_v1]
}

# # Front-end
# resource "google_cloud_run_v2_service" "front_end" {
#   name     = "${var.environment}-front-end-by-terraform"
#   location = var.project_region
#   # deletion_protection = true
#   ingress = "INGRESS_TRAFFIC_ALL"

#   template {
#     scaling {
#       max_instance_count = var.max_instance_count
#     }
#     vpc_access {
#       connector = var.vpc_connector_fe
#       egress = "ALL_TRAFFIC"
#     }
#     containers {
#       image = "${var.artifact_registry_image_path_frontend_v1}:latest"
#       # image = "us-docker.pkg.dev/cloudrun/container/hello"

#       resources {
#         limits = {
#           cpu    = "2"
#           memory = "1024Mi"
#         }
#       }
#     }
#   }
# }

# A Cloud Run for testing datadog automation
# resource "google_cloud_run_v2_service" "test_cr" {
#   name     = "${var.environment}-test-cr-by-terraform"
#   location = var.project_region
#   ingress  = "INGRESS_TRAFFIC_ALL"

#   template {
#     scaling {
#       max_instance_count = var.max_instance_count
#     }
#     containers {
#       image = "${var.artifact_registry_image_path_frontend_v1}:latest"
#       resources {
#         limits = {
#           cpu    = "2"
#           memory = "1024Mi"
#         }
#       }
#     }
#   }
#   labels = {
#     monitor_cpu   = "true" # tells Terraform to create a CPU monitor
#     resource_env  = "prod"
#     resource_type = "cloud_run" # tells the monitoring module what this is
#   }
# }
