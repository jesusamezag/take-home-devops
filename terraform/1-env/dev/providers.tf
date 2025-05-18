provider "google" {
  user_project_override = true
  billing_project       = var.billing_project_id
}

provider "google-beta" {
  user_project_override = true
  billing_project       = var.billing_project_id
}
