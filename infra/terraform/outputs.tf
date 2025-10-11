# 🌐 Outputs - Useful info after deployment

output "frontend_vm_public_ip" {
  description = "Public IP of the frontend VM"
  value       = azurerm_network_interface.frontend_nic.private_ip_address
}

output "backend_vm_private_ip" {
  description = "Private IP of the backend VM"
  value       = azurerm_network_interface.backend_nic.private_ip_address
}

output "sql_server_name" {
  description = "Azure SQL Server name"
  value       = azurerm_mssql_server.main_sql_server.name
}

output "app_gateway_public_ip" {
  description = "Public IP of the Application Gateway"
  value       = azurerm_public_ip.appgw_public_ip.ip_address
}

