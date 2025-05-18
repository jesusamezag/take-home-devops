module "ingress" {
  source = "../modules/base_ingress"

  name        = "ingress"
  project_id  = data.terraform_remote_state.env.outputs.project_id
  environment = "dev"

  functions = [
    {
      name   = data.terraform_remote_state.hello_world.outputs.function_name
      region = data.terraform_remote_state.hello_world.outputs.function_region
    }
  ]
}
