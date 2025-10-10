## Secrets that backend needs
# Secret for artifact registry image path backend
resource "google_secret_manager_secret" "artifact_registry_image_path_backend" {
  secret_id = "${var.environment}-artifact-registry-backend-image-path"
  replication {
    user_managed {
      replicas {
        location = var.project_region
      }
    }
  }
}
resource "google_secret_manager_secret_version" "artifact_registry_image_path_backend_v1" {
  secret      = google_secret_manager_secret.artifact_registry_image_path_backend.id
  secret_data = var.artifact_registry_image_path_backend_v1
}

# Secret for cloud run backend service name
resource "google_secret_manager_secret" "cloud_run_backend_service_name" {
  secret_id = "${var.environment}-cloud-run-backend-service-name"
  replication {
    user_managed {
      replicas {
        location = var.project_region
      }
    }
  }
}
resource "google_secret_manager_secret_version" "cloud_run_backend_service_name_v1" {
  secret      = google_secret_manager_secret.cloud_run_backend_service_name.id
  secret_data = var.cloud_run_backend_service_name_v1

}

# Secret for db instance connection
resource "google_secret_manager_secret" "db_instance_connection" {
  secret_id = "${var.environment}-db-instance-connection"
  replication {
    user_managed {
      replicas {
        location = var.project_region
      }
    }
  }
}
resource "google_secret_manager_secret_version" "db_instance_connection_v1" {
  secret      = google_secret_manager_secret.db_instance_connection.id
  secret_data = var.db_instance_connection_v1
}

# Secret for app db name
resource "google_secret_manager_secret" "app_db_name" {
  secret_id = "${var.environment}-app-db-name"
  replication {
    user_managed {
      replicas {
        location = var.project_region
      }
    }
  }
}
resource "google_secret_manager_secret_version" "app_db_name_v1" {
  secret      = google_secret_manager_secret.app_db_name.id
  secret_data = var.app_db_name_v1
}

# Secret for db user name
resource "google_secret_manager_secret" "db_user_name" {
  secret_id = "${var.environment}-db-user-name"
  replication {
    user_managed {
      replicas {
        location = var.project_region
      }
    }
  }
}
resource "google_secret_manager_secret_version" "db_user_name_v1" {
  secret      = google_secret_manager_secret.db_user_name.id
  secret_data = var.db_user_name_v1
}

# Secret for db user password
resource "google_secret_manager_secret" "db_user_password" {
  secret_id = "${var.environment}-db-user-password"


  replication {
    user_managed {
      replicas {
        location = var.project_region
      }
    }
  }
}
resource "google_secret_manager_secret_version" "db_user_password_v1" {
  secret      = google_secret_manager_secret.db_user_password.id
  secret_data = var.db_user_password_v1
}
