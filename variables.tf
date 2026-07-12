variable "vpn_gateway_connections" {
  description = <<EOT
Map of vpn_gateway_connections, attributes below
Required:
    - name
    - remote_vpn_site_id
    - vpn_gateway_id
    - vpn_link (block):
        - bandwidth_mbps (optional)
        - bgp_enabled (optional)
        - connection_mode (optional)
        - custom_bgp_address (optional, block):
            - ip_address (required)
            - ip_configuration_id (required)
        - dpd_timeout_seconds (optional)
        - egress_nat_rule_ids (optional)
        - ingress_nat_rule_ids (optional)
        - ipsec_policy (optional, block):
            - dh_group (required)
            - encryption_algorithm (required)
            - ike_encryption_algorithm (required)
            - ike_integrity_algorithm (required)
            - integrity_algorithm (required)
            - pfs_group (required)
            - sa_data_size_kb (required)
            - sa_lifetime_sec (required)
        - local_azure_ip_address_enabled (optional)
        - name (required)
        - policy_based_traffic_selector_enabled (optional)
        - protocol (optional)
        - ratelimit_enabled (optional)
        - route_weight (optional)
        - shared_key (optional)
        - vpn_site_link_id (required)
Optional:
    - internet_security_enabled
    - routing (block):
        - associated_route_table (required)
        - inbound_route_map_id (optional)
        - outbound_route_map_id (optional)
        - propagated_route_table (optional, block):
            - labels (optional)
            - route_table_ids (required)
    - traffic_selector_policy (block):
        - local_address_ranges (required)
        - remote_address_ranges (required)
EOT

  type = map(object({
    name                      = string
    remote_vpn_site_id        = string
    vpn_gateway_id            = string
    internet_security_enabled = optional(bool) # Default: false
    vpn_link = list(object({
      bandwidth_mbps  = optional(number) # Default: 10
      bgp_enabled     = optional(bool)   # Default: false
      connection_mode = optional(string) # Default: "Default"
      custom_bgp_address = optional(list(object({
        ip_address          = string
        ip_configuration_id = string
      })))
      dpd_timeout_seconds  = optional(number)
      egress_nat_rule_ids  = optional(set(string))
      ingress_nat_rule_ids = optional(set(string))
      ipsec_policy = optional(list(object({
        dh_group                 = string
        encryption_algorithm     = string
        ike_encryption_algorithm = string
        ike_integrity_algorithm  = string
        integrity_algorithm      = string
        pfs_group                = string
        sa_data_size_kb          = number
        sa_lifetime_sec          = number
      })))
      local_azure_ip_address_enabled        = optional(bool) # Default: false
      name                                  = string
      policy_based_traffic_selector_enabled = optional(bool)   # Default: false
      protocol                              = optional(string) # Default: "IKEv2"
      ratelimit_enabled                     = optional(bool)   # Default: false
      route_weight                          = optional(number) # Default: 0
      shared_key                            = optional(string)
      vpn_site_link_id                      = string
    }))
    routing = optional(object({
      associated_route_table = string
      inbound_route_map_id   = optional(string)
      outbound_route_map_id  = optional(string)
      propagated_route_table = optional(object({
        labels          = optional(set(string))
        route_table_ids = list(string)
      }))
    }))
    traffic_selector_policy = optional(list(object({
      local_address_ranges  = set(string)
      remote_address_ranges = set(string)
    })))
  }))
  validation {
    condition = alltrue([
      for k, v in var.vpn_gateway_connections : (
        length(v.vpn_link) >= 1
      )
    ])
    error_message = "Each vpn_link list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.vpn_gateway_connections : (
        alltrue([for item in v.vpn_link : (item.ipsec_policy == null || (length(item.ipsec_policy) >= 1))])
      )
    ])
    error_message = "Each ipsec_policy list must contain at least 1 items"
  }
  # --- Unconfirmed validation candidates, derived from azurerm_vpn_gateway_connection's provider source ---
  # Not auto-enabled: either a bespoke provider validator we can't safely translate,
  # or a path that crosses a list-typed block (needs its own for_each wrapping).
  # Review, translate into a real validation{} block above, and delete once confirmed.
  # path: name
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: vpn_gateway_id
  #   source:    [from virtualwans.ValidateVpnGatewayID] !ok
  # path: vpn_gateway_id
  #   source:    [from virtualwans.ValidateVpnGatewayID] err != nil
  # path: remote_vpn_site_id
  #   source:    [from virtualwans.ValidateVpnSiteID] !ok
  # path: remote_vpn_site_id
  #   source:    [from virtualwans.ValidateVpnSiteID] err != nil
  # path: routing.associated_route_table
  #   source:    [from virtualwans.ValidateHubRouteTableID] !ok
  # path: routing.associated_route_table
  #   source:    [from virtualwans.ValidateHubRouteTableID] err != nil
  # path: routing.inbound_route_map_id
  #   source:    [from virtualwans.ValidateRouteMapID] !ok
  # path: routing.inbound_route_map_id
  #   source:    [from virtualwans.ValidateRouteMapID] err != nil
  # path: routing.outbound_route_map_id
  #   source:    [from virtualwans.ValidateRouteMapID] !ok
  # path: routing.outbound_route_map_id
  #   source:    [from virtualwans.ValidateRouteMapID] err != nil
  # path: routing.propagated_route_table.route_table_ids[*]
  #   source:    [from virtualwans.ValidateHubRouteTableID] !ok
  # path: routing.propagated_route_table.route_table_ids[*]
  #   source:    [from virtualwans.ValidateHubRouteTableID] err != nil
  # path: routing.propagated_route_table.labels[*]
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: vpn_link.name
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: vpn_link.vpn_site_link_id
  #   source:    [from virtualwans.ValidateVpnSiteLinkID] !ok
  # path: vpn_link.vpn_site_link_id
  #   source:    [from virtualwans.ValidateVpnSiteLinkID] err != nil
  # path: vpn_link.dpd_timeout_seconds
  #   condition: value >= 9 && value <= 3600
  #   message:   must be between 9 and 3600
  # path: vpn_link.egress_nat_rule_ids[*]
  #   source:    [from virtualwans.ValidateNatRuleID] !ok
  # path: vpn_link.egress_nat_rule_ids[*]
  #   source:    [from virtualwans.ValidateNatRuleID] err != nil
  # path: vpn_link.ingress_nat_rule_ids[*]
  #   source:    [from virtualwans.ValidateNatRuleID] !ok
  # path: vpn_link.ingress_nat_rule_ids[*]
  #   source:    [from virtualwans.ValidateNatRuleID] err != nil
  # path: vpn_link.connection_mode
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: vpn_link.route_weight
  #   condition: value >= 0
  #   message:   must be at least 0
  # path: vpn_link.protocol
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: vpn_link.bandwidth_mbps
  #   condition: value >= 1
  #   message:   must be at least 1
  # path: vpn_link.shared_key
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: vpn_link.ipsec_policy.sa_lifetime_sec
  #   condition: value >= 300 && value <= 172799
  #   message:   must be between 300 and 172799
  # path: vpn_link.ipsec_policy.sa_data_size_kb
  #   source:    validation.IntBetween(0, math.MaxInt32) - bound(s) not a literal int (e.g. a named constant like math.MaxInt32) - resolve manually
  # path: vpn_link.ipsec_policy.encryption_algorithm
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: vpn_link.ipsec_policy.integrity_algorithm
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: vpn_link.ipsec_policy.ike_encryption_algorithm
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: vpn_link.ipsec_policy.ike_integrity_algorithm
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: vpn_link.ipsec_policy.dh_group
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: vpn_link.ipsec_policy.pfs_group
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: vpn_link.custom_bgp_address.ip_address
  #   source:    validation.IsIPv4Address(...) - no translation rule yet, add one
  # path: vpn_link.custom_bgp_address.ip_configuration_id
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: traffic_selector_policy.local_address_ranges[*]
  #   source:    validation.IsCIDR(...) - no translation rule yet, add one
  # path: traffic_selector_policy.remote_address_ranges[*]
  #   source:    validation.IsCIDR(...) - no translation rule yet, add one
}

