include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

dependency "network" {
  config_path = "../../../2-network/dev"
}

inputs = {
  billing_project_id = include.root.inputs.billing_project_id

  src_path = include.root.inputs.src_path

  primary_region = include.root.inputs.primary_region
}