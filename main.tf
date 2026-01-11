resource "azurerm_vpn_gateway_connection" "vpn_gateway_connections" {
  for_each = var.vpn_gateway_connections

  name                      = each.value.name
  remote_vpn_site_id        = each.value.remote_vpn_site_id
  vpn_gateway_id            = each.value.vpn_gateway_id
  internet_security_enabled = each.value.internet_security_enabled

  vpn_link {
    bandwidth_mbps  = each.value.vpn_link.bandwidth_mbps
    bgp_enabled     = each.value.vpn_link.bgp_enabled
    connection_mode = each.value.vpn_link.connection_mode
    dynamic "custom_bgp_address" {
      for_each = each.value.vpn_link.custom_bgp_address != null ? [each.value.vpn_link.custom_bgp_address] : []
      content {
        ip_address          = custom_bgp_address.value.ip_address
        ip_configuration_id = custom_bgp_address.value.ip_configuration_id
      }
    }
    dpd_timeout_seconds  = each.value.vpn_link.dpd_timeout_seconds
    egress_nat_rule_ids  = each.value.vpn_link.egress_nat_rule_ids
    ingress_nat_rule_ids = each.value.vpn_link.ingress_nat_rule_ids
    dynamic "ipsec_policy" {
      for_each = each.value.vpn_link.ipsec_policy != null ? [each.value.vpn_link.ipsec_policy] : []
      content {
        dh_group                 = ipsec_policy.value.dh_group
        encryption_algorithm     = ipsec_policy.value.encryption_algorithm
        ike_encryption_algorithm = ipsec_policy.value.ike_encryption_algorithm
        ike_integrity_algorithm  = ipsec_policy.value.ike_integrity_algorithm
        integrity_algorithm      = ipsec_policy.value.integrity_algorithm
        pfs_group                = ipsec_policy.value.pfs_group
        sa_data_size_kb          = ipsec_policy.value.sa_data_size_kb
        sa_lifetime_sec          = ipsec_policy.value.sa_lifetime_sec
      }
    }
    local_azure_ip_address_enabled        = each.value.vpn_link.local_azure_ip_address_enabled
    name                                  = each.value.vpn_link.name
    policy_based_traffic_selector_enabled = each.value.vpn_link.policy_based_traffic_selector_enabled
    protocol                              = each.value.vpn_link.protocol
    ratelimit_enabled                     = each.value.vpn_link.ratelimit_enabled
    route_weight                          = each.value.vpn_link.route_weight
    shared_key                            = each.value.vpn_link.shared_key
    vpn_site_link_id                      = each.value.vpn_link.vpn_site_link_id
  }

  dynamic "routing" {
    for_each = each.value.routing != null ? [each.value.routing] : []
    content {
      associated_route_table = routing.value.associated_route_table
      inbound_route_map_id   = routing.value.inbound_route_map_id
      outbound_route_map_id  = routing.value.outbound_route_map_id
      dynamic "propagated_route_table" {
        for_each = routing.value.propagated_route_table != null ? [routing.value.propagated_route_table] : []
        content {
          labels          = propagated_route_table.value.labels
          route_table_ids = propagated_route_table.value.route_table_ids
        }
      }
    }
  }

  dynamic "traffic_selector_policy" {
    for_each = each.value.traffic_selector_policy != null ? [each.value.traffic_selector_policy] : []
    content {
      local_address_ranges  = traffic_selector_policy.value.local_address_ranges
      remote_address_ranges = traffic_selector_policy.value.remote_address_ranges
    }
  }
}

