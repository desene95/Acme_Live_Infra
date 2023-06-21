remote_state {
  # Disabling since it's causing issues as per
  # https://github.com/gruntwork-io/terragrunt/pull/1317#issuecomment-682041007
  disable_dependency_optimization = true

  backend = "azurerm"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    tenant_id       = "a84fb88f-90b4-4467-a19a-4a3abd11369f"
    subscription_id = "e91cad16-aa0f-4cf4-ac49-ce7c7e3ed16e"

    resource_group_name  = "acme_rg"
    storage_account_name = "acmetfstatedame"
    container_name       = "tfstate"

    key = "${path_relative_to_include()}/terraform.tfstate"
  }
}