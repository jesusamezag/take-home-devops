output "vpc_name" {
  value = module.base_env.vpc_name
}

output "vpc_id" {
  value = module.base_env.vpc_id
}

output "vpc_self_link" {
  value = module.base_env.vpc_self_link
}

output "subnets" {
  value = module.base_env.subnets
}

output "primary_sn_serverless_conn_name" {
  value = module.base_env.subnets["${var.primary_region}/primary-sn-serverless-conn"].name
}
