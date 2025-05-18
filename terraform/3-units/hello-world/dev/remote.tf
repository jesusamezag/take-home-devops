data "terraform_remote_state" "env" {
  backend = "gcs"

  config = {
    bucket = var.state_bucket_name
    prefix = "1-env/dev"
  }
}

data "terraform_remote_state" "network" {
  backend = "gcs"

  config = {
    bucket = var.state_bucket_name
    prefix = "2-network/dev"
  }
}
