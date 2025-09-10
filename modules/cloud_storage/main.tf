resource "google_storage_bucket" "web_app_bucket" {
  name          = "${var.environment}-web-app-bucket"
  location      = "US"
  force_destroy = true

  public_access_prevention = "enforced"
}