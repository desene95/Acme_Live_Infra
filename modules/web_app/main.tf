# module "naming"{
#   source = "../naming"
#   suffix = var.name
# }
# resource "azurerm_resource_group" "rg" {
#   name     = module.naming.resource_group.name 
#   location = var.location
# }
# module "web_app_plan" {
#   source = "../web_app_plan"
#   resource_group_name = local.rg.name
  
# }

data "azurerm_client_config" "current" {}

module "resource_group" {
   source = "../resource_group"
   name   = var.resource_group_name
 }

resource "azurerm_service_plan" "web-plan" {
  name                = var.web_plan_name
  location            = var.location
  resource_group_name = module.resource_group.consumable
  os_type             = "Linux"
  sku_name            = "S1"
}

resource "azurerm_app_service" "web-app" {
  name                = var.web_app_name
  location            = var.location
  resource_group_name = module.resource_group.consumable
  app_service_plan_id = azurerm_service_plan.web-plan.id

  site_config {}

#   app_settings = {
#     "SOME_KEY" = "some-value"
#   }

  # connection_string {
  #   name = "DB-connection"

  # }
}