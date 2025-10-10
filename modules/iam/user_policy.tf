data "google_iam_policy" "user" {
  binding {
    role = "roles/iap.httpsResourceAccessor"
    members = [
      "user:haithonguyen0305@gmail.com",
    ]
  }
}

resource "google_iap_web_iam_policy" "policy" {
  project = var.project_id
  policy_data = data.google_iam_policy.user.policy_data
}