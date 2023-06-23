data "azurerm_client_config" "current" {}

module "resource_group" {
   source = "../resource_group"
   name   = var.resource_group_name
 }


resource "azurerm_virtual_network" "acme-vnet" {
  name                = var.vnet_name
  address_space       = var.addr_space
  location            = var.location
  resource_group_name = module.resource_group.consumable
}

resource "azurerm_subnet" "service" {
  name                 = var.subnet_name
  resource_group_name  = module.resource_group.consumable
  virtual_network_name = azurerm_virtual_network.acme-vnet.name
  address_prefixes       = var.addr_pref

  #disable_private_link_service_network_policy_enforcement = true
}


# resource "azurerm_private_link_service" "example" {
#   name                = var.priv_link
#   location            = var.location
#   resource_group_name = module.resource_group.consumable

#    nat_ip_configuration {
#      name      = var.nat_ip
#      primary   = true
#      subnet_id = azurerm_subnet.service.id
#    }

#   #load_balancer_frontend_ip_configuration_ids = [
#     #azurerm_lb.example.frontend_ip_configuration.0.id,
#   #]
# }

resource "azurerm_private_endpoint" "middleware-db" {
  name                = var.pe_name
  location            = var.location
  resource_group_name = module.resource_group.consumable
  subnet_id           = azurerm_subnet.service.id

  private_service_connection {
    name                           = var.pe_conn
    private_connection_resource_id = var.private_link_enabled_resource_id
    is_manual_connection           = false
    subresource_names              = var.subresource_names
  }
}

resource "azurerm_private_endpoint" "bff-middleware" {
  name                = var.pe_name_1
  location            = var.location
  resource_group_name = module.resource_group.consumable
  subnet_id           = azurerm_subnet.service.id

  private_service_connection {
    name                           = var.pe_conn_1
    private_connection_resource_id = var.private_link_enabled_resource_id_1
    is_manual_connection           = false
    subresource_names              = var.subresource_names_1
  }
}