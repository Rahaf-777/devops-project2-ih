# =========================================
# Virtual Machines (Frontend + Backend)
# =========================================

# Network Interface - Frontend
resource "azurerm_network_interface" "frontend_nic" {
  name                = "nic-frontend"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.frontend.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    environment = "dev"
  }
}

# Network Interface - Backend
resource "azurerm_network_interface" "backend_nic" {
  name                = "nic-backend"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.backend.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    environment = "dev"
  }
}

# =========================
# Frontend VM
# =========================
resource "azurerm_linux_virtual_machine" "frontend_vm" {
  name                  = "vm-frontend"
  location              = azurerm_resource_group.main.location
  resource_group_name   = azurerm_resource_group.main.name
  network_interface_ids = [azurerm_network_interface.frontend_nic.id]
  size                  = "Standard_B1s"
  admin_username        = "azureuser"

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  disable_password_authentication = true

  tags = {
    role        = "frontend"
    environment = "dev"
  }
}

# =========================
# Backend VM
# =========================
resource "azurerm_linux_virtual_machine" "backend_vm" {
  name                  = "vm-backend"
  location              = azurerm_resource_group.main.location
  resource_group_name   = azurerm_resource_group.main.name
  network_interface_ids = [azurerm_network_interface.backend_nic.id]
  size                  = "Standard_B1s"
  admin_username        = "azureuser"

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  disable_password_authentication = true

  tags = {
    role        = "backend"
    environment = "dev"
  }
}

