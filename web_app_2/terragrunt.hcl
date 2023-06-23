include {
  path = find_in_parent_folders()
}


terraform {
  source = "..//modules/web_app"
  extra_arguments "force_subscription" {
    commands = [
      "init",
      "apply",
      "destroy",
      "refresh",
      "import",
      "plan",
      "taint",
      "untaint" 
    ]
    env_vars = {
       ARM_SUBSCRIPTION_ID = "e91cad16-aa0f-4cf4-ac49-ce7c7e3ed16e"
     }
}

}

inputs = {
    web_app_name = "Acme-lab-middleware"
    resource_group_name =   ["Acme_RG"]
    location    =   "West Europe"
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  required_version = ">= 0.14"
    experiments      = [module_variable_optional_attrs]
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "> 2.73"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = "true"
    features{}
}

EOF

}