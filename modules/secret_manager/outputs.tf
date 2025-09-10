output "db_user_password" {
  description = "The ID of the Secret Manager secret for the database user password."
  value       = google_secret_manager_secret.db_user_password.id

}

output "db_user_password_v1" {
  description = "The version of the Secret Manager secret for the database user password."
  value       = google_secret_manager_secret_version.db_user_password_v1.secret_data
}