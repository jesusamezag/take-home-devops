variable "name" {
  type = string
}

variable "environment" {
  type = string
}

variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "artifacts_bucket_name" {
  type = string
}

variable "src_path" {
  type = string
}

variable "function_roles" {
  type    = list(string)
  default = []
}

variable "function_ram" {
  type    = string
  default = "256Mi"
}

variable "function_cpu" {
  type    = string
  default = "1"
}

variable "allow_unauthenticated" {
  type    = bool
  default = false
}

variable "vpc_access_subnet" {
  type = string
}
