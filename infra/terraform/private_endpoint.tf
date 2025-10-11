# 🔒 Private Endpoint + Private DNS Zone for Azure SQL

resource "azurerm_private_dns_zone" "sql_private_dns" {
  name                = "privatelink.database.windows.net"
  resource_group_name = "rg-3tier-dev"
  tags = {
    environment = "dev"
    owner       = "rahaf"
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "sql_dns_link" {
  name                  = "sql-dns-link"
  resource_group_name   = "rg-3tier-dev"
  private_dns_zone_name = azurerm_private_dns_zone.sql_private_dns.name
  virtual_network_id    = azurerm_virtual_network.main_vnet.id
}

resource "azurerm_private_endpoint" "sql_private_endpoint" {
  name                = "pe-sql"
  location            = "westeurope"
  resource_group_name = "rg-3tier-dev"
  subnet_id           = azurerm_subnet.data.id

  private_service_connection {
    name                           = "sql-priv-conn"
    private_connection_resource_id = azurerm_mssql_server.main_sql_server.id
    subresource_names              = ["sqlServer"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "sql-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.sql_private_dns.id]
  }

  tags = {
    environment = "dev"
    owner       = "rahaf"
  }
}

