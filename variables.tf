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
      custom_bgp_address = optional(object({
        ip_address          = string
        ip_configuration_id = string
      }))
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
    traffic_selector_policy = optional(object({
      local_address_ranges  = set(string)
      remote_address_ranges = set(string)
    }))
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
}

