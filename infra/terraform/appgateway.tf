# 🌐 Azure Application Gateway (WAF_v2)

resource "azurerm_application_gateway" "main_appgw" {
  name                = "appgateway-rahaf-dev"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "appgw-ip-config"
    subnet_id = azurerm_subnet.appgw.id
  }

  frontend_ip_configuration {
    name                 = "appgw-feip"
    public_ip_address_id = azurerm_public_ip.appgw_public_ip.id
  }

  frontend_port {
    name = "frontendPort"
    port = 80
  }

  backend_address_pool {
    name = "frontendPool"
  }

  backend_http_settings {
    name                  = "frontendSetting"
    port                  = 80
    protocol              = "Http"
    cookie_based_affinity = "Disabled"
    request_timeout       = 30
  }

  http_listener {
    name                           = "frontendListener"
    frontend_ip_configuration_name = "appgw-feip"
    frontend_port_name             = "frontendPort"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "frontendRule"
    rule_type                  = "Basic"
    http_listener_name         = "frontendListener"
    backend_address_pool_name  = "frontendPool"
    backend_http_settings_name = "frontendSetting"
    priority                   = 100
  }

  waf_configuration {
    enabled          = true
    firewall_mode    = "Detection"
    rule_set_type    = "OWASP"
    rule_set_version = "3.2"
  }

  tags = {
    owner       = "rahaf"
    environment = "dev"
  }
}

