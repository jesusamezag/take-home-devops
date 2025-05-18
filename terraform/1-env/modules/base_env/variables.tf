variable "name" {
  type = string
}

variable "environment" {
  type = string

  validation {
    condition     = contains(["dev", "tst", "prd"], var.environment)
    error_message = "Environment must be one of: dev, tst, prd."
  }
}

variable "project_id" {
  type    = string
  default = null
}

variable "project_id_prefix" {
  type    = string
  default = null
}

variable "project_name" {
  type = string
}

variable "billing_account_id" {
  type = string
}

variable "enabled_services" {
  type = list(string)
}
