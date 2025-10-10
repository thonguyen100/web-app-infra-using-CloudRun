# Front-end
resource "google_cloud_run_v2_service" "front_end" {
  name     = "${var.environment}-front-end-by-terraform"
  location = var.project_region
  # deletion_protection = true
  ingress = "INGRESS_TRAFFIC_ALL"

  template {
    scaling {
      max_instance_count = var.max_instance_count
    }
    vpc_access {
      connector = var.vpc_connector_fe
      egress    = "ALL_TRAFFIC"
    }
    containers {
      image = "${var.artifact_registry_image_path_frontend_v1}:latest"
      # image = "us-docker.pkg.dev/cloudrun/container/hello"

      resources {
        limits = {
          cpu    = "2"
          memory = "1024Mi"
        }
      }
    }
  }
}
