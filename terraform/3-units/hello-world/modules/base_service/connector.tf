resource "google_vpc_access_connector" "main" {
  name    = "${var.name}-${var.environment}"
  project = var.project_id
  region  = var.region

  machine_type  = "e2-micro"
  min_instances = 2
  max_instances = 3

  subnet {
    name = var.vpc_access_subnet
  }
}
