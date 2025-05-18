variable "name" {
  type = string
}

variable "project_id" {
  type = string
}

variable "environment" {
  type = string
}

variable "functions" {
  type = list(object({
    name   = string
    region = string
  }))

  default = []
}
