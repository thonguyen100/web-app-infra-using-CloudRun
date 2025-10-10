# Secret as ILB IP for frontend to call
resource "google_secret_manager_secret" "internal_lb_static_ip" {
  secret_id = "${var.environment}-internal-lb-static-ip"
  replication {
    user_managed {
      replicas {
        location = var.project_region
      }
    }
  }
}
resource "google_secret_manager_secret_version" "internal_lb_static_ip_v1" {
  secret      = google_secret_manager_secret.internal_lb_static_ip.id
  secret_data = var.internal_lb_static_ip
}