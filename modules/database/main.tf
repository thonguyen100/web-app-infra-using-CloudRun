resource "google_sql_database_instance" "app_db_instance" {
  name                 = "${var.environment}-app-db-instance"
  project              = var.project_id
  region               = var.project_region
  database_version     = "MYSQL_8_0_41"
  deletion_protection  = true
  encryption_key_name  = null
  instance_type        = "CLOUD_SQL_INSTANCE"
  master_instance_name = null
  root_password        = var.db_user_password
  timeouts {
    create = "60m"
    delete = "60m"
  }
  settings {
    activation_policy            = "ALWAYS"
    availability_type            = "ZONAL"
    collation                    = null
    connector_enforcement        = "NOT_REQUIRED"
    deletion_protection_enabled  = true
    disk_autoresize              = false
    disk_autoresize_limit        = 0
    disk_size                    = 10
    disk_type                    = "PD_SSD"
    edition                      = "ENTERPRISE"
    enable_dataplex_integration  = false
    enable_google_ml_integration = false
    pricing_plan                 = "PER_USE"
    tier                         = "db-f1-micro"
    time_zone                    = null
    user_labels                  = {}
    backup_configuration {
      binary_log_enabled             = true
      enabled                        = true
      location                       = var.project_region
      point_in_time_recovery_enabled = false
      start_time                     = "05:00"
      transaction_log_retention_days = 7
      backup_retention_settings {
        retained_backups = 7
        retention_unit   = "COUNT"
      }
    }
    insights_config {
      query_insights_enabled  = true
      query_plans_per_minute  = 5
      query_string_length     = 1024
      record_application_tags = false
      record_client_address   = false
    }
    ip_configuration {
      allocated_ip_range                            = null
      enable_private_path_for_google_cloud_services = true
      ipv4_enabled                                  = false
      private_network                               = "projects/${var.project_id}/global/networks/${var.web_app_vpc_name}"
      server_ca_mode                                = "GOOGLE_MANAGED_INTERNAL_CA"
      ssl_mode                                      = null
    }
    location_preference {
      follow_gae_application = null
      secondary_zone         = null
      zone                   = var.project_zone
    }
    maintenance_window {
      day          = 6
      hour         = 17
      update_track = "canary"
    }
    password_validation_policy {
      complexity                  = "COMPLEXITY_DEFAULT"
      disallow_username_substring = true
      enable_password_policy      = true
      min_length                  = 8
      password_change_interval    = null
      reuse_interval              = 0
    }
  }
  depends_on = [var.private_vpc_connection]
}

resource "google_sql_database" "app_db" {
  name     = "${var.environment}-app-db"
  instance = google_sql_database_instance.app_db_instance.name
  project  = var.project_id
}

resource "google_sql_user" "db_user" {
  name     = "${var.environment}-db-user"
  instance = google_sql_database_instance.app_db_instance.name
  project  = var.project_id
  host     = "%"
  password = var.db_user_password
}
