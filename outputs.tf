output "vpn_gateway_connections_id" {
  description = "Map of id values across all vpn_gateway_connections, keyed the same as var.vpn_gateway_connections"
  value       = { for k, v in azurerm_vpn_gateway_connection.vpn_gateway_connections : k => v.id }
}
output "vpn_gateway_connections_internet_security_enabled" {
  description = "Map of internet_security_enabled values across all vpn_gateway_connections, keyed the same as var.vpn_gateway_connections"
  value       = { for k, v in azurerm_vpn_gateway_connection.vpn_gateway_connections : k => v.internet_security_enabled }
}
output "vpn_gateway_connections_name" {
  description = "Map of name values across all vpn_gateway_connections, keyed the same as var.vpn_gateway_connections"
  value       = { for k, v in azurerm_vpn_gateway_connection.vpn_gateway_connections : k => v.name }
}
output "vpn_gateway_connections_remote_vpn_site_id" {
  description = "Map of remote_vpn_site_id values across all vpn_gateway_connections, keyed the same as var.vpn_gateway_connections"
  value       = { for k, v in azurerm_vpn_gateway_connection.vpn_gateway_connections : k => v.remote_vpn_site_id }
}
output "vpn_gateway_connections_routing" {
  description = "Map of routing values across all vpn_gateway_connections, keyed the same as var.vpn_gateway_connections"
  value       = { for k, v in azurerm_vpn_gateway_connection.vpn_gateway_connections : k => v.routing }
}
output "vpn_gateway_connections_traffic_selector_policy" {
  description = "Map of traffic_selector_policy values across all vpn_gateway_connections, keyed the same as var.vpn_gateway_connections"
  value       = { for k, v in azurerm_vpn_gateway_connection.vpn_gateway_connections : k => v.traffic_selector_policy }
}
output "vpn_gateway_connections_vpn_gateway_id" {
  description = "Map of vpn_gateway_id values across all vpn_gateway_connections, keyed the same as var.vpn_gateway_connections"
  value       = { for k, v in azurerm_vpn_gateway_connection.vpn_gateway_connections : k => v.vpn_gateway_id }
}
output "vpn_gateway_connections_vpn_link" {
  description = "Map of vpn_link values across all vpn_gateway_connections, keyed the same as var.vpn_gateway_connections"
  value       = { for k, v in azurerm_vpn_gateway_connection.vpn_gateway_connections : k => v.vpn_link }
}

