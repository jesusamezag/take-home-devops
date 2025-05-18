module "base_env" {
  source = "../modules/base_env"

  project_id = data.terraform_remote_state.env.outputs.project_id

  subnets = [
    {
      name          = "primary-sn"
      ip_cidr_range = "10.0.0.0/24"
      region        = var.primary_region
    },
    {
      name          = "secondary-sn"
      ip_cidr_range = "10.0.1.0/24"
      region        = var.secondary_region
    },
    {
      name          = "primary-sn-serverless-conn"
      ip_cidr_range = "172.16.0.0/28"
      region        = var.primary_region
    }
  ]
}
