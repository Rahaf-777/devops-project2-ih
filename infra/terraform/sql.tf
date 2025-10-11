# 🗄️ Azure SQL Database (Private Access Only)

# Create SQL Server
resource "azurerm_mssql_server" "main_sql_server" {
  name                          = "sqlserver-rahaf-dev"
  resource_group_name           = azurerm_resource_group.main.name
  location                      = azurerm_resource_group.main.location
  version                       = "12.0"
  administrator_login           = "sqladminuser"
  administrator_login_password  = "StrongP@ssword123!"
  minimum_tls_version           = "1.2"
  public_network_access_enabled = false
  tags = {
    environment = "dev"
    owner       = "rahaf"
  }
}

# Create SQL Database
resource "azurerm_mssql_database" "main_sql_db" {
  name           = "sqldb-rahaf-dev"
  server_id      = azurerm_mssql_server.main_sql_server.id
  sku_name       = "Basic"
  max_size_gb    = 2
  zone_redundant = false
  tags = {
    environment = "dev"
    owner       = "rahaf"
  }
}

