locals {
  base_name = "${var.name}-${var.environment}"

  functions = {
    for f in var.functions : f.name => f
  }
}

resource "google_compute_region_network_endpoint_group" "main" {
  for_each = local.functions

  name                  = "${local.base_name}-cr-${each.value.name}"
  project               = var.project_id
  network_endpoint_type = "SERVERLESS"
  region                = each.value.region

  cloud_run {
    service = each.value.name
  }
}

resource "google_compute_backend_service" "main" {
  name    = local.base_name
  project = var.project_id
  # security_policy = google_compute_security_policy.main.name

  dynamic "backend" {
    for_each = local.functions

    content {
      group = google_compute_region_network_endpoint_group.main[backend.value.name].id
    }
  }
}

resource "google_compute_url_map" "main" {
  name            = local.base_name
  project         = var.project_id
  default_service = google_compute_backend_service.main.id

  host_rule {
    hosts        = ["*"]
    path_matcher = "hello-world"
  }

  path_matcher {
    name            = "hello-world"
    default_service = google_compute_backend_service.main.id

    path_rule {
      paths   = ["/helloWorld", "/helloWorld/*"]
      service = google_compute_backend_service.main.id

      route_action {
        url_rewrite {
          path_prefix_rewrite = "/"
        }
      }
    }
  }
}

resource "google_compute_target_http_proxy" "main" {
  name    = local.base_name
  project = var.project_id

  url_map = google_compute_url_map.main.id
}

resource "google_compute_global_address" "main" {
  name         = local.base_name
  project      = var.project_id
  ip_version   = "IPV4"
  address_type = "EXTERNAL"
}

resource "google_compute_global_forwarding_rule" "main" {
  name                  = local.base_name
  project               = var.project_id
  target                = google_compute_target_http_proxy.main.id
  ip_address            = google_compute_global_address.main.address
  load_balancing_scheme = "EXTERNAL"
  ip_protocol           = "TCP"
  port_range            = "80"
}
