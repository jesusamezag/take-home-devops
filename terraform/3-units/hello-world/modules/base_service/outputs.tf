output "function_id" {
  value = google_cloudfunctions2_function.main.id
}

output "function_name" {
  value = google_cloudfunctions2_function.main.name
}

output "function_service_account_email" {
  value = google_service_account.main.email
}

output "function_url" {
  value = google_cloudfunctions2_function.main.url
}

output "function_region" {
  value = google_cloudfunctions2_function.main.location
}
