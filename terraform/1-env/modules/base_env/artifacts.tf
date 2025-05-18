resource "google_storage_bucket" "artifacts" {
  name                        = "${google_project.main.project_id}-artifacts"
  project                     = google_project.main.project_id
  location                    = "US"
  storage_class               = "STANDARD"
  force_destroy               = var.environment == "prd" ? false : true
  uniform_bucket_level_access = true

  labels = local.labels

  versioning {
    enabled = true
  }

  depends_on = [
    google_project_service.enabled["storage-api.googleapis.com"]
  ]
}
