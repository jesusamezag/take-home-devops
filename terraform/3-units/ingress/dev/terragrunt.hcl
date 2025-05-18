include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

dependencies {
  paths = ["../../hello-world/dev"]
}

inputs = {
  billing_project_id = include.root.inputs.billing_project_id
}