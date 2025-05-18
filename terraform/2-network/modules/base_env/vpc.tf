locals {
  subnets = {
    for s in var.subnets : "${s.region}/${s.name}" => s
  }
}

resource "google_compute_network" "main" {
  name                    = "${var.project_id}-main"
  project                 = var.project_id
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "main" {
  for_each = local.subnets

  name          = each.value.name
  network       = google_compute_network.main.id
  ip_cidr_range = each.value.ip_cidr_range
  region        = each.value.region
  project       = var.project_id

  dynamic "secondary_ip_range" {
    for_each = each.value.secondary_ip_range

    content {
      ip_cidr_range = secondary_ip_range.value.ip_cidr_range
      range_name    = secondary_ip_range.value.range_name
    }
  }
}
