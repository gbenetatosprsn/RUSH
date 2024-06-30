output "hub_vnet00" {
  value = azurerm_virtual_network.vnet00
}

output "lb_egress_private_ip" {
  value = azurerm_lb.egress.private_ip_address
}

output "vpn_gateway_ips" {
  value = try(azurerm_vpn_gateway.hub_gateway.bgp_settings[0].instance_0_bgp_peering_address[0].tunnel_ips, [])
}
