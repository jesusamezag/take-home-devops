variable "name" {
  type = string
}

variable "project_id_prefix" {
  type = string
}

variable "project_name" {
  type = string
}

variable "primary_region" {
  type = string
}

variable "billing_project_id" {
  type = string
}

variable "billing_account_id" {
  type = string
}

variable "activate_apis" {
  type = list(string)
}
