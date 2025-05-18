locals {
  function_name = "${var.name}-${var.region}-${var.environment}"
}

resource "google_service_account" "main" {
  account_id   = local.function_name
  display_name = local.function_name
  project      = var.project_id
}

resource "google_cloudfunctions2_function" "main" {
  name     = local.function_name
  project  = var.project_id
  location = var.region

  build_config {
    runtime     = "nodejs22"
    entry_point = "helloWorld"

    source {
      storage_source {
        bucket = var.artifacts_bucket_name
        object = google_storage_bucket_object.main.name
      }
    }
  }

  service_config {
    timeout_seconds                  = 60
    available_memory                 = var.function_ram
    available_cpu                    = var.function_cpu
    max_instance_count               = 1
    max_instance_request_concurrency = 30
    service_account_email            = google_service_account.main.email
    vpc_connector                    = google_vpc_access_connector.main.name
    vpc_connector_egress_settings    = "PRIVATE_RANGES_ONLY"
    ingress_settings                 = "ALLOW_INTERNAL_AND_GCLB"
  }
}

resource "google_cloud_run_service_iam_member" "allow_unauthenticated" {
  count = var.allow_unauthenticated ? 1 : 0

  service  = google_cloudfunctions2_function.main.name
  location = var.region
  project  = var.project_id
  role     = "roles/run.invoker"
  member   = "allUsers"
}
