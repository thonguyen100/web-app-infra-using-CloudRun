resource "google_compute_firewall" "allow-cloudrun-to-ilb" {
  name    = "${var.environment}-allow-cloudrun-to-ilb"
  network = google_compute_network.web_app_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  # source_ranges = ["10.7.0.0/28"]
  source_ranges = [google_compute_subnetwork.subnet_fe.ip_cidr_range]
  direction     = "INGRESS"
}
