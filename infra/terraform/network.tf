# 🌐 NETWORK SETUP (VNet, Subnets, NSGs)

resource "azurerm_virtual_network" "main_vnet" {
  name                = "vnet-3tier-dev"
  address_space       = ["10.10.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  tags = {
    environment = "dev"
    owner       = "rahaf"
  }
}

# ─────────────── Subnets ───────────────

resource "azurerm_subnet" "frontend" {
  name                 = "snet-frontend"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main_vnet.name
  address_prefixes     = ["10.10.1.0/24"]
}

resource "azurerm_subnet" "backend" {
  name                 = "snet-backend"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main_vnet.name
  address_prefixes     = ["10.10.2.0/24"]
}

resource "azurerm_subnet" "data" {
  name                 = "snet-data"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main_vnet.name
  address_prefixes     = ["10.10.3.0/24"]
}


# 🔹 Subnet for Ops (optional management subnet)
resource "azurerm_subnet" "ops" {
  name                 = "snet-ops"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main_vnet.name
  address_prefixes     = ["10.10.5.0/24"]
}

# ─────────────── NSGs ───────────────

resource "azurerm_network_security_group" "frontend_nsg" {
  name                = "nsg-frontend"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  security_rule {
    name                       = "Allow-AppGW-to-FE"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "10.10.6.0/24"
    destination_address_prefix = "*"
  }

  tags = { environment = "dev" }
}

resource "azurerm_network_security_group" "backend_nsg" {
  name                = "nsg-backend"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  security_rule {
    name                       = "Allow-AppGW-to-BE"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "10.10.6.0/24"
    destination_address_prefix = "*"
  }

  tags = { environment = "dev" }
}

# ─────────────── NSG Associations ───────────────

resource "azurerm_subnet_network_security_group_association" "frontend_assoc" {
  subnet_id                 = azurerm_subnet.frontend.id
  network_security_group_id = azurerm_network_security_group.frontend_nsg.id
}

resource "azurerm_subnet_network_security_group_association" "backend_assoc" {
  subnet_id                 = azurerm_subnet.backend.id
  network_security_group_id = azurerm_network_security_group.backend_nsg.id
}

# 🔹 Subnet for Application Gateway
resource "azurerm_subnet" "appgw" {
  name                 = "snet-appgw"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main_vnet.name
  address_prefixes     = ["10.10.6.0/24"]
}

# 🌍 Public IP for Application Gateway
resource "azurerm_public_ip" "appgw_public_ip" {
  name                = "appgw-public-ip"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = {
    owner       = "rahaf"
    environment = "dev"
  }
}

