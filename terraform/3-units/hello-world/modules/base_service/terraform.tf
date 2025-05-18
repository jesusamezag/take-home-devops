terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }

    google-beta = {
      source = "hashicorp/google-beta"
    }

    archive = {
      source  = "hashicorp/archive"
      version = ">= 2.0"
    }
  }
}
