locals {
  variables = read_terragrunt_config(find_in_parent_folders("variables.hcl"))
  secrets   = read_terragrunt_config(find_in_parent_folders("secrets.hcl"))
}

generate "backend" {
  path              = "backend.tf"
  if_exists         = "skip"
  disable_signature = true
  disable           = local.variables.inputs.disable_state_init

  contents = <<-EOF
    terraform {
      backend "gcs" {
        bucket = "${local.variables.inputs.state_bucket_name}"
        prefix = "${path_relative_to_include()}"
      }
    }
  EOF
}

generate "terraform" {
  path              = "terraform.tf"
  if_exists         = "skip"
  disable_signature = true

  contents = <<-EOF
    terraform {
      required_providers {
        google = {
          source  = "hashicorp/google"
          version = ">= 6.0"
        }

        google-beta = {
          source  = "hashicorp/google-beta"
          version = ">= 6.0"
        }

        random = {
          source  = "hashicorp/random"
          version = ">= 3.6"
        }

        external = {
          source  = "hashicorp/external"
          version = ">= 2.3"
        }
      }
    }
  EOF
}

generate "providers" {
  path              = "providers.tf"
  if_exists         = "skip"
  disable_signature = true

  contents = <<-EOF
    provider "google" {
      user_project_override = true
      billing_project       = var.billing_project_id
    }

    provider "google-beta" {
      user_project_override = true
      billing_project       = var.billing_project_id
    }
  EOF
}

inputs = merge(local.variables.inputs, local.secrets.inputs)