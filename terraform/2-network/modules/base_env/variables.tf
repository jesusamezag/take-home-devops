variable "project_id" {
  type = string
}

variable "subnets" {
  type = list(object({
    name          = string
    ip_cidr_range = string
    region        = string

    secondary_ip_range = optional(list(object({
      ip_cidr_range = string
      range_name    = string
    })), [])
  }))
}

variable "ingress_rules" {
  type = list(object({
    name                    = string
    description             = optional(string)
    source_ranges           = optional(list(string))
    destination_ranges      = optional(list(string))
    source_tags             = optional(list(string))
    target_tags             = optional(list(string))
    target_service_accounts = optional(list(string))
    priority                = number

    allow = optional(list(object({
      protocol = string
      ports    = list(string)
    })))

    deny = optional(list(object({
      protocol = string
      ports    = list(string)
    })))
  }))

  default = []
}

variable "egress_rules" {
  type = list(object({
    name                    = string
    description             = optional(string)
    source_ranges           = optional(list(string))
    destination_ranges      = optional(list(string))
    source_tags             = optional(list(string))
    target_tags             = optional(list(string))
    target_service_accounts = optional(list(string))
    priority                = number

    allow = optional(list(object({
      protocol = string
      ports    = list(string)
    })))

    deny = optional(list(object({
      protocol = string
      ports    = list(string)
    })))
  }))

  default = []
}
