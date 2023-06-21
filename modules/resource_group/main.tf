# Create Resource Group
module "naming"{
  source = "../naming"
  suffix = var.name
}
resource "azurerm_resource_group" "rg" {
  name     = module.naming.resource_group.name 
  location = var.location
}

output "resource_group_name"{
value = azurerm_resource_group.rg.name
}