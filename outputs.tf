output "vpn_gateway_connections" {
  description = "All vpn_gateway_connection resources"
  value       = azurerm_vpn_gateway_connection.vpn_gateway_connections
}
output "vpn_gateway_connections_internet_security_enabled" {
  description = "List of internet_security_enabled values across all vpn_gateway_connections"
  value       = [for k, v in azurerm_vpn_gateway_connection.vpn_gateway_connections : v.internet_security_enabled]
}
output "vpn_gateway_connections_name" {
  description = "List of name values across all vpn_gateway_connections"
  value       = [for k, v in azurerm_vpn_gateway_connection.vpn_gateway_connections : v.name]
}
output "vpn_gateway_connections_remote_vpn_site_id" {
  description = "List of remote_vpn_site_id values across all vpn_gateway_connections"
  value       = [for k, v in azurerm_vpn_gateway_connection.vpn_gateway_connections : v.remote_vpn_site_id]
}
output "vpn_gateway_connections_routing" {
  description = "List of routing values across all vpn_gateway_connections"
  value       = [for k, v in azurerm_vpn_gateway_connection.vpn_gateway_connections : v.routing]
}
output "vpn_gateway_connections_traffic_selector_policy" {
  description = "List of traffic_selector_policy values across all vpn_gateway_connections"
  value       = [for k, v in azurerm_vpn_gateway_connection.vpn_gateway_connections : v.traffic_selector_policy]
}
output "vpn_gateway_connections_vpn_gateway_id" {
  description = "List of vpn_gateway_id values across all vpn_gateway_connections"
  value       = [for k, v in azurerm_vpn_gateway_connection.vpn_gateway_connections : v.vpn_gateway_id]
}
output "vpn_gateway_connections_vpn_link" {
  description = "List of vpn_link values across all vpn_gateway_connections"
  value       = [for k, v in azurerm_vpn_gateway_connection.vpn_gateway_connections : v.vpn_link]
}

