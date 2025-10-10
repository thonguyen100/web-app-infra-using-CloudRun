# VPC Connector for Cloud Run Backend
# Subnet for Connector-BE
resource "google_compute_subnetwork" "subnet_be" {
  name          = "${var.environment}-subnet-be"
  region        = var.project_region
  network       = google_compute_network.web_app_vpc.name
  ip_cidr_range = "10.2.0.0/28"
  purpose       = "PRIVATE"
}
# VPC connector for Cloud Run Backend
resource "google_vpc_access_connector" "vpc_connector_be" {
  name = "${var.environment}-vpc-connector-be"
  subnet {
    name = google_compute_subnetwork.subnet_be.name
  }
}

# VPC Connector for Cloud Run Frontend
# Subnet for Connector-FE
resource "google_compute_subnetwork" "subnet_fe" {
  name          = "${var.environment}-subnet-fe"
  region        = var.project_region
  network       = google_compute_network.web_app_vpc.name
  ip_cidr_range = "10.7.0.0/28"
  purpose       = "PRIVATE"
}
# VPC connector for Cloud Run Frontend
resource "google_vpc_access_connector" "vpc_connector_fe" {
  name = "${var.environment}-vpc-connector-fe"
  subnet {
    name = google_compute_subnetwork.subnet_fe.name
  }
}