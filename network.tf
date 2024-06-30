#----------------------------------------------------------------------------------------------------------------------
# Network
#----------------------------------------------------------------------------------------------------------------------

resource "azurerm_virtual_network" "vnet00" {
  name                = "${var.coid}-${var.location}-hubnetwork-vnet-${var.environment}"
  location            = var.resource_group_networking.location
  resource_group_name = var.resource_group_networking.name
  address_space       = var.hub_address_space
}

# Create Subnets
resource "azurerm_subnet" "management00" {
  name                 = "${var.coid}-${var.location}-mgmt-subnet-${var.environment}"
  virtual_network_name = azurerm_virtual_network.vnet00.name
  resource_group_name  = var.resource_group_networking.name
  address_prefixes     = var.mgmt_space_prefix
}

resource "azurerm_subnet" "ha200" {
  name                 = "${var.coid}-${var.location}-ha2-subnet-${var.environment}"
  virtual_network_name = azurerm_virtual_network.vnet00.name
  resource_group_name  = var.resource_group_networking.name
  address_prefixes     = var.ha2_space_prefix
}

resource "azurerm_subnet" "private00" {
  name                 = "${var.coid}-${var.location}-private-subnet-${var.environment}"
  virtual_network_name = azurerm_virtual_network.vnet00.name
  resource_group_name  = var.resource_group_networking.name
  address_prefixes     = var.private_space_prefix
}

resource "azurerm_subnet" "public00" {
  name                 = "${var.coid}-${var.location}-public-subnet-${var.environment}"
  virtual_network_name = azurerm_virtual_network.vnet00.name
  resource_group_name  = var.resource_group_networking.name
  address_prefixes     = var.public_space_prefix
}

resource "azurerm_subnet" "loadbalancer00" {
  name                 = "${var.coid}-${var.location}-loadbalancer-subnet-${var.environment}"
  virtual_network_name = azurerm_virtual_network.vnet00.name
  resource_group_name  = var.resource_group_networking.name
  address_prefixes     = var.lb_space_prefix
}

#----------------------------------------------------------------------------------------------------------------------
# Network - Azure Virtual WAN
#----------------------------------------------------------------------------------------------------------------------

# Creation of vWAN managed service
resource "azurerm_virtual_wan" "vwan" {
  name                           = "${var.coid}-${var.location}-hubnetwork-vwan-${var.environment}"
  resource_group_name            = var.resource_group_networking.name
  location                       = var.resource_group_networking.location
  type                           = "Standard"
  allow_branch_to_branch_traffic = true
}

# Creation of vHUB in default location - For DR we need to add second HUB
resource "azurerm_virtual_hub" "hub" {
  name                = "${var.coid}-${var.location}-hubnetwork-hub-${var.environment}"
  resource_group_name = var.resource_group_networking.name
  location            = var.resource_group_networking.location
  virtual_wan_id      = azurerm_virtual_wan.vwan.id
  address_prefix      = var.virtual_wan_address_space[0]
}

resource "azurerm_vpn_gateway" "hub_gateway" {
  name                = "${var.coid}-${var.location}-hubnetwork-gateway-${var.environment}"
  location            = var.resource_group_networking.location
  resource_group_name = var.resource_group_networking.name
  virtual_hub_id      = azurerm_virtual_hub.hub.id
}

# That creates a VPN site, including the VPN gateway. We can output the PSK/Peer IP in the future. 
resource "azurerm_vpn_site" "vwan_vpn" {
  name                = "Oakbrook_Protera"
  resource_group_name = var.resource_group_networking.name
  location            = var.resource_group_networking.location
  virtual_wan_id      = azurerm_virtual_wan.vwan.id

  # Networks on the peer side

  address_cidrs = ["10.159.94.0/23","100.70.0.0/15"]

  # This link is for Oakbrook
  link {
    name          = "link1"
    ip_address    = "207.223.34.132"
    provider_name = "Verizon"
    speed_in_mbps = "100"
  }
  # TODO
  # Here we will add Customer's connection as separate link Block
  # link {
  #   name          = "customer-link1"
  #   ip_address    = "8.8.8.8"
  #   provider_name = "Verizon"
  #   speed_in_mbps = "100"
  # }
}

# This is the vWAN peer to Firewall vnet - Required for traffic fitlering from External Connections. That ONLy works when we are within same Tenant.
resource "azurerm_virtual_hub_connection" "connection_hub" {
  name                      = "${var.coid}-${var.location}-hubnetwork-peer-${var.environment}"
  virtual_hub_id            = azurerm_virtual_hub.hub.id
  remote_virtual_network_id = azurerm_virtual_network.vnet00.id
}
