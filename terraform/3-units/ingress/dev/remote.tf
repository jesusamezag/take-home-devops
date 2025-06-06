data "terraform_remote_state" "env" {
  backend = "gcs"

  config = {
    bucket = var.state_bucket_name
    prefix = "1-env/dev"
  }
}

data "terraform_remote_state" "hello_world" {
  backend = "gcs"

  config = {
    bucket = var.state_bucket_name
    prefix = "3-units/hello-world/dev"
  }
}
