# VPC Network
resource "google_compute_network" "web_app_vpc" {
  name                    = "${var.environment}-web-app-vpc"
  project                 = var.project_id
  auto_create_subnetworks = false

}

# Network dependencies for private database connection
resource "google_compute_global_address" "private_ip_range_alloc" {
  name          = "${var.environment}-private-ip-range-alloc"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = "projects/${var.project_id}/global/networks/${google_compute_network.web_app_vpc.name}"
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = "projects/${var.project_id}/global/networks/${google_compute_network.web_app_vpc.name}"
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_range_alloc.name]
}

# # VPC Connector for Cloud Run Backend
# # Subnet for Connector-BE
# resource "google_compute_subnetwork" "subnet_be" {
#   name          = "${var.environment}-subnet-be"
#   region        = var.project_region
#   network       = google_compute_network.web_app_vpc.name
#   ip_cidr_range = "10.2.0.0/28"
#   purpose       = "PRIVATE"
# }
# # VPC connector for Cloud Run Backend
# resource "google_vpc_access_connector" "vpc_connector_be" {
#   name         = "${var.environment}-vpc-connector-be"
#   subnet {
#     name       = google_compute_subnetwork.subnet_be.name
#   }
# }

# # VPC Connector for Cloud Run Frontend
# # Subnet for Connector-FE
# resource "google_compute_subnetwork" "subnet_fe" {
#   name          = "${var.environment}-subnet-fe"
#   region        = var.project_region
#   network       = google_compute_network.web_app_vpc.name
#   ip_cidr_range = "10.7.0.0/28"
#   purpose       = "PRIVATE"
# }
# # VPC connector for Cloud Run Frontend
# resource "google_vpc_access_connector" "vpc_connector_fe" {
#   name         = "${var.environment}-vpc-connector-fe"
#   subnet {
#     name       = google_compute_subnetwork.subnet_fe.name
#   }
# }
