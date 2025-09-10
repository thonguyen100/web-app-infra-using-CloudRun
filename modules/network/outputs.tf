output "web_app_vpc_name" {
  value = google_compute_network.web_app_vpc.name

}

output "web_app_subnet_name" {
  value = google_compute_subnetwork.web_app_subnet.name

}

output "private_vpc_connection" {
  value = google_service_networking_connection.private_vpc_connection.id
}