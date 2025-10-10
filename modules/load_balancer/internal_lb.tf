# LB between frontend Cloud Run and backend Cloud Run
## Reserve an internal static IP for LB (IP)
resource "google_compute_address" "internal_lb_static_ip" {
  name         = "${var.environment}-internal-lb-static-ip"
  address_type = "INTERNAL"
  region       = var.project_region
  subnetwork   = var.subnet_be_name
}

## This is the active proxy-only subnet which is in the same region and VPC as the fowarding rule
resource "google_compute_subnetwork" "proxy_only_subnet" {
  name          = "${var.environment}-proxy-subnet"
  ip_cidr_range = "10.129.0.0/23"
  region        = var.project_region
  network       = var.web_app_vpc_name
  purpose       = "REGIONAL_MANAGED_PROXY"
  role          = "ACTIVE"
  stack_type    = "IPV4_ONLY"
}

## This the the listener of the LB that listens to traffic from the frontend Cloud Run (port 80)
resource "google_compute_forwarding_rule" "internal_lb_entry_point" {
  name                  = "${var.environment}-internal-lb-entry-point"
  region                = var.project_region
  load_balancing_scheme = "INTERNAL_MANAGED"
  port_range            = "80"
  ip_address            = google_compute_address.internal_lb_static_ip.address
  target                = google_compute_region_target_http_proxy.internal_lb_http_proxy.id
  network               = var.web_app_vpc_name
  subnetwork            = var.subnet_be_name

  depends_on = [google_compute_subnetwork.proxy_only_subnet]
}

## HTTP target proxy
resource "google_compute_region_target_http_proxy" "internal_lb_http_proxy" {
  name    = "${var.environment}-internal-lb-http-proxy"
  region  = var.project_region
  url_map = google_compute_region_url_map.internal_lb_url_map.id
}
## HTTPS target proxy cannot be created without SSL cert
# resource "google_compute_region_target_https_proxy" "internal_lb_https_proxy" {
#   name             = "${var.environment}-internal-lb-https-proxy"
#   region           = var.project_region
#   url_map          = google_compute_region_url_map.internal_lb_url_map.id
# }

## URL map
resource "google_compute_region_url_map" "internal_lb_url_map" {
  name            = "${var.environment}-internal-lb-url-map"
  region          = var.project_region
  default_service = google_compute_region_backend_service.internal_lb_traffic_config.id
}

## This is the config of LB that receives requests from frontend Cloud Run and defines where and how to send traffic
resource "google_compute_region_backend_service" "internal_lb_traffic_config" {
  name                  = "${var.environment}-internal-lb-traffic-config"
  region                = var.project_region
  protocol              = "HTTP"
  timeout_sec           = 30
  load_balancing_scheme = "INTERNAL_MANAGED"
  backend {
    group          = google_compute_region_network_endpoint_group.connection_of_lb_to_backend.id
    balancing_mode = "UTILIZATION"
  }
}
## This is the connection between LB and the backend Cloud Run
resource "google_compute_region_network_endpoint_group" "connection_of_lb_to_backend" {
  name                  = "${var.environment}-connection-of-lb-to-backend"
  network_endpoint_type = "SERVERLESS"
  region                = var.project_region

  cloud_run {
    service = var.cloud_run_backend_service_name_v1
  }
}

## This is the config of LB that receives requests from external url_map
resource "google_compute_backend_service" "lb_api_backend_service" {
  name                  = "${var.environment}-lb-api-backend-service"
  protocol              = "HTTP"
  timeout_sec           = 30
  load_balancing_scheme = "EXTERNAL"

  backend {
    group = google_compute_region_network_endpoint_group.connection_of_external_lb_to_backend.id
  }
}
## This is the connection between external LB and the backend Cloud Run
resource "google_compute_region_network_endpoint_group" "connection_of_external_lb_to_backend" {
  name                  = "${var.environment}-connection-of-lb-to-backend-external"
  network_endpoint_type = "SERVERLESS"
  region                = var.project_region

  cloud_run {
    service = var.cloud_run_backend_service_name_v1
  }
}
