#----------------------------------------------------------------------------------------------------------------------
# Network
#----------------------------------------------------------------------------------------------------------------------

resource "azurerm_virtual_network" "vnet00" {
  name                = "${var.coid}-vnet-hubnetwork-p-${var.location_short}-00"
  location            = var.resource_group_networking.location
  resource_group_name = var.resource_group_networking.name
  address_space       = var.hub_address_space
}

# Create Subnets
resource "azurerm_subnet" "management00" {
  name                 = "${var.coid}-subnet-mgmt-p-${var.location_short}-00"
  virtual_network_name = azurerm_virtual_network.vnet00.name
  resource_group_name  = var.resource_group_networking.name
  address_prefixes     = var.mgmt_space_prefix
}

resource "azurerm_subnet" "ha200" {
  name                 = "${var.coid}-subnet-ha2-p-${var.location_short}-00"
  virtual_network_name = azurerm_virtual_network.vnet00.name
  resource_group_name  = var.resource_group_networking.name
  address_prefixes     = var.ha2_space_prefix
}

resource "azurerm_subnet" "private00" {
  name                 = "${var.coid}-subnet-private-p-${var.location_short}-00"
  virtual_network_name = azurerm_virtual_network.vnet00.name
  resource_group_name  = var.resource_group_networking.name
  address_prefixes     = var.private_space_prefix
}

resource "azurerm_subnet" "public00" {
  name                 = "${var.coid}-subnet-public00-p-${var.location_short}-00"
  virtual_network_name = azurerm_virtual_network.vnet00.name
  resource_group_name  = var.resource_group_networking.name
  address_prefixes     = var.public_space_prefix
}

resource "azurerm_subnet" "loadbalancer00" {
  name                 = "${var.coid}-subnet-loadbalancers-p-${var.location_short}-00"
  virtual_network_name = azurerm_virtual_network.vnet00.name
  resource_group_name  = var.resource_group_networking.name
  address_prefixes     = var.lb_space_prefix
}

#----------------------------------------------------------------------------------------------------------------------
# Network - Azure Virtual WAN
#----------------------------------------------------------------------------------------------------------------------

# Creation of vWAN managed service
resource "azurerm_virtual_wan" "vwan" {
  name                           = "${var.coid}-vwan-hubnetwork-p-${var.location_short}-00"
  resource_group_name            = var.resource_group_networking.name
  location                       = var.resource_group_networking.location
  type                           = "Standard"
  allow_branch_to_branch_traffic = true
}

# Creation of vHUB in default location - For DR we need to add second HUB
resource "azurerm_virtual_hub" "hub" {
  name                = "${var.coid}-vhub-hubnetwork-p-${var.location_short}-00"
  resource_group_name = var.resource_group_networking.name
  location            = var.resource_group_networking.location
  virtual_wan_id      = azurerm_virtual_wan.vwan.id
  address_prefix      = var.virtual_wan_address_space[0]
}

resource "azurerm_vpn_gateway" "hub_gateway" {
  name                = "${var.coid}-gateway-hubnetwork-p-${var.location_short}-00"
  location            = var.resource_group_networking.location
  resource_group_name = var.resource_group_networking.name
  virtual_hub_id      = azurerm_virtual_hub.hub.id
  scale_unit          = 4
}


# This is the vWAN peer to Firewall vnet - Required for traffic fitlering from External Connections. That ONLy works when we are within same Tenant.
resource "azurerm_virtual_hub_connection" "connection_hub" {
  name                      = "${var.coid}-peer-hubnetwork-p-${var.location_short}-00"
  virtual_hub_id            = azurerm_virtual_hub.hub.id
  remote_virtual_network_id = azurerm_virtual_network.vnet00.id
}

#----------------------------------------------------------------------------------------------------------------------
# NAT Gateway
#----------------------------------------------------------------------------------------------------------------------

# NAT GW Public IP

resource "azurerm_public_ip" "ext_natgw_pip" {
  name                = "rush-pip-natgw-p-${var.location_short}-00"
  location            = var.resource_group_compute.location
  resource_group_name = var.resource_group_compute.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Build NAT Gateway

resource "azurerm_nat_gateway" "ext_natgw" {
  name                    = "nat-Gateway"
  location                = var.resource_group_networking.location
  resource_group_name     = var.resource_group_networking.name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
}

# Associate Public IP

resource "azurerm_nat_gateway_public_ip_association" "ext_natgwpip_associate" {
  nat_gateway_id       = azurerm_nat_gateway.ext_natgw.id
  public_ip_address_id = azurerm_public_ip.ext_natgw_pip.id
}

# Associate puplic subnets

resource "azurerm_subnet_nat_gateway_association" "ext_natgw_subnet" {
  subnet_id      = azurerm_subnet.public00.id
  nat_gateway_id = azurerm_nat_gateway.ext_natgw.id
}