locals {
  state_bucket_name = get_env("STATE_BUCKET_NAME", "")

  primary_region   = get_env("PRIMARY_REGION", "us-central1")
  secondary_region = get_env("SECONDARY_REGION", "us-west1")
}

inputs = {
  state_bucket_name  = local.state_bucket_name
  disable_state_init = local.state_bucket_name == "" ? true : false

  src_path = "${get_repo_root()}/src"

  name = get_env("NAME")

  primary_region      = get_env("PRIMARY_REGION", "us-central1")
  primary_region_zone = "${local.primary_region}-f"

  secondary_region      = get_env("SECONDARY_REGION", "us-west1")
  secondary_region_zone = "${local.secondary_region}-b"

  project_id_prefix = get_env("PROJECT_ID_PREFIX", "smt-the")
  project_name      = get_env("PROJECT_NAME", "SMT Take Home Exercise")

  activate_apis = [
    "cloudresourcemanager.googleapis.com",
    "iam.googleapis.com",
    "compute.googleapis.com",
    "cloudfunctions.googleapis.com",
    "run.googleapis.com",
    "storage-api.googleapis.com",
    "cloudbuild.googleapis.com",
    "vpcaccess.googleapis.com",
  ]
}
