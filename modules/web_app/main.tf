module "resource_group" {
   source = "../resource_group"
   name   = var.resource_group_name
 }

resource "azurerm_service_plan" "web-plan" {
  name                = var.web_plan_name
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
  os_type             = "Linux"
  sku_name            = "P1v2"
}

resource "azurerm_app_service" "web-app" {
  name                = var.web_app_name
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
  app_service_plan_id = azurerm_service_plan.web-plan.id

  site_config {}

#   app_settings = {
#     "SOME_KEY" = "some-value"
#   }

  # connection_string {
  #   name = "DB-connection"

  # }
}