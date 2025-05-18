module "env" {
  source = "../modules/base_env"

  name = var.name

  environment        = "dev"
  project_id_prefix  = var.project_id_prefix
  project_name       = var.project_name
  billing_account_id = var.billing_account_id

  enabled_services = var.activate_apis
}
