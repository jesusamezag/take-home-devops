output "project_id" {
  value = google_project.main.project_id
}

output "project_name" {
  value = google_project.main.name
}

output "terraform_state_bucket_name" {
  value = google_storage_bucket.state.name
}

output "artifacts_bucket_name" {
  value = google_storage_bucket.artifacts.name
}
