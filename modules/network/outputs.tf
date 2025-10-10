output "web_app_vpc_name" {
  value = google_compute_network.web_app_vpc.name

}
output "private_vpc_connection" {
  value = google_service_networking_connection.private_vpc_connection.id
}

# VPC Connector outputs for Cloud Run
output "subnet_be_name" {
  value = google_compute_subnetwork.subnet_be.name
}
output "subnet_fe_name" {
  value = google_compute_subnetwork.subnet_fe.name
}
output "vpc_connector_be" {
  value = google_vpc_access_connector.vpc_connector_be.id
}
output "vpc_connector_fe" {
  value = google_vpc_access_connector.vpc_connector_fe.id
}