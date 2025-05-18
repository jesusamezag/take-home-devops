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
