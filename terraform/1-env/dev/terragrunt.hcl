include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

inputs = include.root.inputs
