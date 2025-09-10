output "db_instance_connection_name" {
  value = google_sql_database_instance.app_db_instance.connection_name
}
output "db_private_ip" {
  value = google_sql_database_instance.app_db_instance.private_ip_address
}
output "app_database_name" {
  value = google_sql_database.app_db.name
}
output "db_user_name" {
  value = google_sql_user.db_user.name
}
output "db_user_password" {
  value     = google_sql_user.db_user.password
  sensitive = true
}