# Load-Balancer




# VPC Network
resource "google_compute_network" "web_app_vpc" {
  name                    = "${var.environment}-web-app-vpc"
  project                 = var.project_id
  auto_create_subnetworks = false

}

# Subnet
resource "google_compute_subnetwork" "web_app_subnet" {
  name          = "${var.environment}-web-app-subnet"
  region        = var.project_region
  network       = google_compute_network.web_app_vpc.name
  ip_cidr_range = "10.2.0.0/16"
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

