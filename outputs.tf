output "vpn_gateway_connections_id" {
  description = "Map of id values across all vpn_gateway_connections, keyed the same as var.vpn_gateway_connections"
  value       = { for k, v in azurerm_vpn_gateway_connection.vpn_gateway_connections : k => v.id if v.id != null && length(v.id) > 0 }
}
output "vpn_gateway_connections_internet_security_enabled" {
  description = "Map of internet_security_enabled values across all vpn_gateway_connections, keyed the same as var.vpn_gateway_connections"
  value       = { for k, v in azurerm_vpn_gateway_connection.vpn_gateway_connections : k => v.internet_security_enabled if v.internet_security_enabled != null }
}
output "vpn_gateway_connections_name" {
  description = "Map of name values across all vpn_gateway_connections, keyed the same as var.vpn_gateway_connections"
  value       = { for k, v in azurerm_vpn_gateway_connection.vpn_gateway_connections : k => v.name if v.name != null && length(v.name) > 0 }
}
output "vpn_gateway_connections_remote_vpn_site_id" {
  description = "Map of remote_vpn_site_id values across all vpn_gateway_connections, keyed the same as var.vpn_gateway_connections"
  value       = { for k, v in azurerm_vpn_gateway_connection.vpn_gateway_connections : k => v.remote_vpn_site_id if v.remote_vpn_site_id != null && length(v.remote_vpn_site_id) > 0 }
}
output "vpn_gateway_connections_routing" {
  description = "Map of routing values across all vpn_gateway_connections, keyed the same as var.vpn_gateway_connections"
  value       = { for k, v in azurerm_vpn_gateway_connection.vpn_gateway_connections : k => v.routing if v.routing != null && length(v.routing) > 0 }
}
output "vpn_gateway_connections_traffic_selector_policy" {
  description = "Map of traffic_selector_policy values across all vpn_gateway_connections, keyed the same as var.vpn_gateway_connections"
  value       = { for k, v in azurerm_vpn_gateway_connection.vpn_gateway_connections : k => v.traffic_selector_policy if v.traffic_selector_policy != null && length(v.traffic_selector_policy) > 0 }
}
output "vpn_gateway_connections_vpn_gateway_id" {
  description = "Map of vpn_gateway_id values across all vpn_gateway_connections, keyed the same as var.vpn_gateway_connections"
  value       = { for k, v in azurerm_vpn_gateway_connection.vpn_gateway_connections : k => v.vpn_gateway_id if v.vpn_gateway_id != null && length(v.vpn_gateway_id) > 0 }
}
output "vpn_gateway_connections_vpn_link" {
  description = "Map of vpn_link values across all vpn_gateway_connections, keyed the same as var.vpn_gateway_connections"
  value       = { for k, v in azurerm_vpn_gateway_connection.vpn_gateway_connections : k => v.vpn_link if v.vpn_link != null && length(v.vpn_link) > 0 }
}

