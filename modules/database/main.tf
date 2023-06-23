data "azurerm_client_config" "current" {}

module "resource_group" {
   source = "../resource_group"
   name   = var.resource_group_name
 }

resource "random_password" "db_pwd" {
  count   = 2
  length  = 15
  special = false
  upper =  true
}

resource "random_string" "db_user" {
  count            = 2
  length           = 15
  special          = false
  upper = false
  #override_special = "/$@"
}



resource "azurerm_key_vault" "this"{
  name = var.kv_name  
  location                   = var.location
  resource_group_name        = module.resource_group.consumable
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Create",
      "Get",
      "List",
    ]
    secret_permissions = [
      "Set",
      "Get",
      "Delete",
      "Purge",
      "Recover",
      "List"
    ]
}
}

resource "azurerm_key_vault_secret" "db_user" {
  name         = "admin-user-${var.db_server}"
  value        = random_string.db_user[0].result
  key_vault_id = azurerm_key_vault.this.id
}

resource "azurerm_key_vault_secret" "db_pwd" {
  name         = "admin-pwd-${var.db_server}"
  value        = random_password.db_pwd[0].result
  key_vault_id = azurerm_key_vault.this.id
}


 resource "azurerm_mssql_server" "db_server" {
  name                         = var.db_server
  resource_group_name          = module.resource_group.consumable
  location                     = var.location
  version                      = "12.0"
  administrator_login          = random_string.db_user[0].result
  administrator_login_password = random_password.db_pwd[0].result
}

resource "azurerm_mssql_database" "db" {
  name           = var.db_name
  server_id      = azurerm_mssql_server.db_server.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 1
  read_scale     = false
  sku_name       = "S0"
  zone_redundant = false
}