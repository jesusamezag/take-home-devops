locals {
  project_id_default = "${var.project_id_prefix}-${var.environment}-${var.name}-${random_string.suffix.result}"
  project_id         = var.project_id == null ? local.project_id_default : var.project_id

  labels = {
    environment = var.environment
    terraform   = true
  }
}

resource "random_string" "suffix" {
  length  = 4
  numeric = false
  special = false
  upper   = false
}

resource "google_project" "main" {
  name                = var.project_name
  project_id          = local.project_id
  billing_account     = var.billing_account_id
  auto_create_network = false
  deletion_policy     = var.environment == "prd" ? "PREVENT" : "DELETE"

  labels = local.labels
}

resource "google_project_service" "resourcemanager" {
  project = google_project.main.project_id
  service = "cloudresourcemanager.googleapis.com"
}

resource "google_project_service" "enabled" {
  for_each = setsubtract(
    toset(var.enabled_services),
    toset(["cloudresourcemanager.googleapis.com"])
  )

  project            = google_project.main.project_id
  service            = each.value
  disable_on_destroy = false

  depends_on = [
    google_project_service.resourcemanager
  ]
}

resource "google_storage_bucket" "state" {
  name                        = "${google_project.main.project_id}-state"
  project                     = google_project.main.project_id
  location                    = "US"
  storage_class               = "STANDARD"
  force_destroy               = var.environment == "prd" ? false : true
  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }

  depends_on = [
    google_project_service.enabled["storage-api.googleapis.com"]
  ]
}
