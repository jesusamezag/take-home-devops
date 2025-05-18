locals {
  src_path = "${var.src_path}/hello-world"
}

module "function" {
  source = "../modules/base_service"

  name        = "hello-world"
  environment = "dev"

  project_id = data.terraform_remote_state.env.outputs.project_id
  region     = var.primary_region

  artifacts_bucket_name = data.terraform_remote_state.env.outputs.artifacts_bucket_name
  src_path              = local.src_path
  allow_unauthenticated = true

  vpc_access_subnet = data.terraform_remote_state.network.outputs.primary_sn_serverless_conn_name
}
