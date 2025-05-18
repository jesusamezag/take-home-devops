output "vpc_name" {
  value = google_compute_network.main.name
}

output "vpc_id" {
  value = google_compute_network.main.id
}

output "vpc_self_link" {
  value = google_compute_network.main.self_link
}

output "subnets" {
  value = google_compute_subnetwork.main
}
