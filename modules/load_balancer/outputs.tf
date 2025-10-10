output "lb_static_ip" {
  description = "ip address of lb"
  value       = google_compute_global_address.lb_static_ip.address
}

output "lb_static_ip_resource_name" {
  description = "name of lb static ip resource"
  value       = google_compute_global_address.lb_static_ip.name
}

# Outputs from internal_lb.tf
output "internal_lb_static_ip" {
  description = "internal lb static ip"
  value       = google_compute_address.internal_lb_static_ip.address
}