include {
  path = find_in_parent_folders()
}


terraform {
  source = "..//modules/network"
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
    vnet_name   =   "acme-vnet"
    addr_space  =   ["10.0.0.0/16"]
    subnet_name =   "service"
    addr_pref   =   ["10.0.1.0/24"]
    resource_group_name =   ["Acme_RG"]
    location    =   "West Europe"
    pe_name     =   "middlewaretodb"
    pe_name_1   =   "bfftomiddleware"
    pe_conn     =   "middlewaretodbconn"
    pe_conn_1    =   "bfftomiddlewareconn"
    private_link_enabled_resource_id ="/subscriptions/e91cad16-aa0f-4cf4-ac49-ce7c7e3ed16e/resourceGroups/rg-Acme_RG/providers/Microsoft.Sql/servers/acme-db-server"
    private_link_enabled_resource_id_1="/subscriptions/e91cad16-aa0f-4cf4-ac49-ce7c7e3ed16e/resourceGroups/rg-Acme_RG/providers/Microsoft.Web/sites/Acme-lab-middleware"
    subresource_names   =   ["sqlServer"]
    subresource_names_1 = ["sites"]
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