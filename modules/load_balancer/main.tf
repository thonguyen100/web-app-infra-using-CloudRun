# LB between Cloudflare and frontend Cloud Run
## Reserve a global static IP for LB (IP)
resource "google_compute_global_address" "lb_static_ip" {
  name = "${var.environment}-lb-static-ip"
}

## This is the listener of the LB that listens to traffic from the internet (port 443)
resource "google_compute_global_forwarding_rule" "lb_entry_point" {
  name       = "${var.environment}-lb-entry-point"
  port_range = "443"
  ip_address = google_compute_global_address.lb_static_ip.address
  target     = google_compute_target_https_proxy.lb_https_proxy.id
}

## Get a Google-managed SSL cert for HTTPS proxy to handle HTTPS traffic securely
resource "google_compute_managed_ssl_certificate" "lb_ssl_cert" {
  name = "${var.environment}-lb-ssl-cert"
  managed {
    domains = [var.domain]
  }
}

## This is the HTTPS proxy of the LB that decrypt HTTPS requests for the url_map
resource "google_compute_target_https_proxy" "lb_https_proxy" {
  name             = "${var.environment}-lb-https-proxy"
  ssl_certificates = [google_compute_managed_ssl_certificate.lb_ssl_cert.id]
  url_map          = google_compute_url_map.lb_url_map.id

  depends_on = [
    google_compute_managed_ssl_certificate.lb_ssl_cert,
    google_compute_url_map.lb_url_map
  ]
}

## This is the url_map which is an internal router that HTTPS proxy uses to map traffic
resource "google_compute_url_map" "lb_url_map" {
  name            = "${var.environment}-lb-url-map"
  default_service = google_compute_backend_service.lb_traffic_config.id

  depends_on = [google_compute_backend_service.lb_traffic_config]

}
## This is the config of LB that receives requests from url_map and defines where and how to send traffic
resource "google_compute_backend_service" "lb_traffic_config" {
  name                  = "${var.environment}-lb-traffic-config"
  protocol              = "HTTP"
  timeout_sec           = 30
  load_balancing_scheme = "EXTERNAL"

  # health_checks = [google_compute_region_health_check.lb_health_check.id]

  backend {
    group = google_compute_region_network_endpoint_group.connection_of_lb_to_frontend.id
  }
}
## This is the connection between LB and the frontend Cloud Run
resource "google_compute_region_network_endpoint_group" "connection_of_lb_to_frontend" {
  name                  = "${var.environment}-connection-of-lb-to-frontend"
  network_endpoint_type = "SERVERLESS"
  region                = var.project_region

  cloud_run {
    service = var.cloud_run_frontend_service_name_v1
  }
}

## Add health check to LB
# resource "google_compute_region_health_check" "lb_health_check" {
#   region = var.project_region
#   name   = "${var.environment}-lb-health-check"

#   http_health_check {
#     port = 8080
#   }
# }