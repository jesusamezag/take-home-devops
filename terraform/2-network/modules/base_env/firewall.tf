locals {
  ingress_rules = {
    for r in var.ingress_rules : r.name => merge(r, { direction = "INGRESS" })
  }

  egress_rules = {
    for r in var.egress_rules : r.name => merge(r, { direction = "EGRESS" })
  }
}

resource "google_compute_firewall" "ingress" {
  for_each = local.ingress_rules

  name                    = each.value.name
  network                 = google_compute_network.main.id
  description             = each.value.description
  direction               = each.value.direction
  source_ranges           = each.value.source_ranges
  destination_ranges      = each.value.destination_ranges
  source_tags             = each.value.source_tags
  target_tags             = each.value.target_tags
  target_service_accounts = each.value.target_service_accounts

  dynamic "allow" {
    for_each = lookup(each.value, "allow", [])

    content {
      protocol = allow.value.protocol
      ports    = lookup(allow.value, "ports", null)
    }
  }

  dynamic "deny" {
    for_each = lookup(each.value, "deny", [])

    content {
      protocol = deny.value.protocol
      ports    = lookup(deny.value, "ports", null)
    }
  }
}

resource "google_compute_firewall" "egress" {
  for_each = local.egress_rules

  name                    = each.value.name
  network                 = google_compute_network.main.self_link
  description             = each.value.description
  direction               = each.value.direction
  source_ranges           = each.value.source_ranges
  destination_ranges      = each.value.destination_ranges
  source_tags             = each.value.source_tags
  target_tags             = each.value.target_tags
  target_service_accounts = each.value.target_service_accounts
  priority                = each.value.priority

  dynamic "allow" {
    for_each = lookup(each.value, "allow", [])

    content {
      protocol = allow.value.protocol
      ports    = lookup(allow.value, "ports", null)
    }
  }

  dynamic "deny" {
    for_each = lookup(each.value, "deny", [])

    content {
      protocol = deny.value.protocol
      ports    = lookup(deny.value, "ports", null)
    }
  }
}
