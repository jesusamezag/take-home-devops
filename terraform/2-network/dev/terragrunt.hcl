include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

dependency "env" {
  config_path = "../../1-env/dev"
}

inputs = {
  billing_project_id = include.root.inputs.billing_project_id
  state_bucket_name  = include.root.inputs.state_bucket_name

  primary_region   = include.root.inputs.primary_region
  secondary_region = include.root.inputs.secondary_region
}