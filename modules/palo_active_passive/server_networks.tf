#----------------------------------------------------------------------------------------------------------------------
# VM-Series - MGMT
#----------------------------------------------------------------------------------------------------------------------

# Public IP Address:
#Internal Firewalls
resource "azurerm_public_ip" "int_p_management00" {
  name                = "rush-pip-intmanagement-p-${var.location_short}-00"
  location            = var.resource_group_compute.location
  resource_group_name = var.resource_group_compute.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_public_ip" "int_p_management01" {
  name                = "rush-pip-intmanagement-p-${var.location_short}-01"
  location            = var.resource_group_compute.location
  resource_group_name = var.resource_group_compute.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_public_ip" "int_q_management00" {
  name                = "rush-pip-intmanagement-q-${var.location_short}-00"
  location            = var.resource_group_compute.location
  resource_group_name = var.resource_group_compute.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_public_ip" "int_q_management01" {
  name                = "rush-pip-intmanagement-q-${var.location_short}-01"
  location            = var.resource_group_compute.location
  resource_group_name = var.resource_group_compute.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

#External Firewalls
resource "azurerm_public_ip" "ext_p_management00" {
  name                = "rush-pip-extmanagement-p-${var.location_short}-00"
  location            = var.resource_group_compute.location
  resource_group_name = var.resource_group_compute.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_public_ip" "ext_p_management01" {
  name                = "rush-pip-extmanagement-p-${var.location_short}-01"
  location            = var.resource_group_compute.location
  resource_group_name = var.resource_group_compute.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_public_ip" "ext_q_management00" {
  name                = "rush-pip-extmanagement-q-${var.location_short}-00"
  location            = var.resource_group_compute.location
  resource_group_name = var.resource_group_compute.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_public_ip" "ext_q_management01" {
  name                = "rush-pip-extmanagement-q-${var.location_short}-01"
  location            = var.resource_group_compute.location
  resource_group_name = var.resource_group_compute.name
  allocation_method   = "Static"
  sku                 = "Standard"
}


# Network Interface:
##Internal Firewalls
resource "azurerm_network_interface" "int_p_management00" {
  name                 = "rush-nic-intmanagement-p-${var.location_short}-00"
  location             = var.resource_group_compute.location
  resource_group_name  = var.resource_group_compute.name
  enable_ip_forwarding = false

  ip_configuration {
    name                          = "ipconfig00"
    subnet_id                     = azurerm_subnet.management00.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.hub_address_space[0], 4)
    public_ip_address_id          = azurerm_public_ip.int_p_management00.id
  }
}

resource "azurerm_network_interface" "int_p_management01" {
  name                 = "rush-nic-intmanagement-p-${var.location_short}-01"
  location             = var.resource_group_compute.location
  resource_group_name  = var.resource_group_compute.name
  enable_ip_forwarding = false

  ip_configuration {
    name                          = "ipconfig00"
    subnet_id                     = azurerm_subnet.management00.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.hub_address_space[0], 5)
    public_ip_address_id          = azurerm_public_ip.int_p_management01.id
  }
}

resource "azurerm_network_interface" "int_q_management00" {
  name                 = "rush-nic-intmanagement-q-${var.location_short}-00"
  location             = var.resource_group_compute.location
  resource_group_name  = var.resource_group_compute.name
  enable_ip_forwarding = false

  ip_configuration {
    name                          = "ipconfig00"
    subnet_id                     = azurerm_subnet.management00.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.hub_address_space[0], 6)
    public_ip_address_id          = azurerm_public_ip.int_q_management00.id
  }
}

resource "azurerm_network_interface" "int_q_management01" {
  name                 = "rush-nic-intmanagement-q-${var.location_short}-01"
  location             = var.resource_group_compute.location
  resource_group_name  = var.resource_group_compute.name
  enable_ip_forwarding = false

  ip_configuration {
    name                          = "ipconfig00"
    subnet_id                     = azurerm_subnet.management00.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.hub_address_space[0], 7)
    public_ip_address_id          = azurerm_public_ip.int_q_management01.id
  }
}

##External Firewalls

resource "azurerm_network_interface" "ext_p_management00" {
  name                 = "rush-nic-extmanagement-p-${var.location_short}-00"
  location             = var.resource_group_compute.location
  resource_group_name  = var.resource_group_compute.name
  enable_ip_forwarding = false

  ip_configuration {
    name                          = "ipconfig00"
    subnet_id                     = azurerm_subnet.management00.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.hub_address_space[0], 8)
    public_ip_address_id          = azurerm_public_ip.ext_p_management00.id
  }
}

resource "azurerm_network_interface" "ext_p_management01" {
  name                 = "rush-nic-extmanagement-p-${var.location_short}-01"
  location             = var.resource_group_compute.location
  resource_group_name  = var.resource_group_compute.name
  enable_ip_forwarding = false

  ip_configuration {
    name                          = "ipconfig00"
    subnet_id                     = azurerm_subnet.management00.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.hub_address_space[0], 9)
    public_ip_address_id          = azurerm_public_ip.ext_p_management01.id
  }
}

resource "azurerm_network_interface" "ext_q_management00" {
  name                 = "rush-nic-extmanagement-q-${var.location_short}-00"
  location             = var.resource_group_compute.location
  resource_group_name  = var.resource_group_compute.name
  enable_ip_forwarding = false

  ip_configuration {
    name                          = "ipconfig00"
    subnet_id                     = azurerm_subnet.management00.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.hub_address_space[0], 10)
    public_ip_address_id          = azurerm_public_ip.ext_q_management00.id
  }
}

resource "azurerm_network_interface" "ext_q_management01" {
  name                 = "rush-nic-extmanagement-q-${var.location_short}-01"
  location             = var.resource_group_compute.location
  resource_group_name  = var.resource_group_compute.name
  enable_ip_forwarding = false

  ip_configuration {
    name                          = "ipconfig00"
    subnet_id                     = azurerm_subnet.management00.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.hub_address_space[0], 11)
    public_ip_address_id          = azurerm_public_ip.ext_q_management01.id
  }
}

# Network Security Group:
## Internal FW
resource "azurerm_network_security_group" "int_management00" {
  name                = "rush-nsg-intmanagement-${var.location_short}-00"
  location            = var.resource_group_compute.location
  resource_group_name = var.resource_group_compute.name

  security_rule {
    name                       = "Deny_ALL"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "default-access-inbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefixes    = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16", "52.147.201.44/32", "207.223.34.132"]
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "default-access-outbound"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}


## External FW
resource "azurerm_network_security_group" "ext_management00" {
  name                = "rush-nsg-extmanagement-${var.location_short}-00"
  location            = var.resource_group_compute.location
  resource_group_name = var.resource_group_compute.name

  security_rule {
    name                       = "Deny_ALL"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "default-access-inbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefixes    = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16", "52.147.201.44/32", "207.223.34.132"]
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "default-access-outbound"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

#Attach NSG to Interfaces
##Internal FW

resource "azurerm_network_interface_security_group_association" "int_p_management00" {
  network_interface_id      = azurerm_network_interface.int_p_management00.id
  network_security_group_id = azurerm_network_security_group.int_management00.id
}

resource "azurerm_network_interface_security_group_association" "int_p_management01" {
  network_interface_id      = azurerm_network_interface.int_p_management01.id
  network_security_group_id = azurerm_network_security_group.int_management00.id
}

resource "azurerm_network_interface_security_group_association" "int_q_management00" {
  network_interface_id      = azurerm_network_interface.int_q_management00.id
  network_security_group_id = azurerm_network_security_group.int_management00.id
}

resource "azurerm_network_interface_security_group_association" "int_q_management01" {
  network_interface_id      = azurerm_network_interface.int_q_management01.id
  network_security_group_id = azurerm_network_security_group.int_management00.id
}

##External FW

resource "azurerm_network_interface_security_group_association" "ext_p_mgmt00" {
  network_interface_id      = azurerm_network_interface.ext_p_management00.id
  network_security_group_id = azurerm_network_security_group.ext_management00.id
}

resource "azurerm_network_interface_security_group_association" "ext_p_mgmt01" {
  network_interface_id      = azurerm_network_interface.ext_p_management01.id
  network_security_group_id = azurerm_network_security_group.ext_management00.id
}

resource "azurerm_network_interface_security_group_association" "ext_q_mgmt00" {
  network_interface_id      = azurerm_network_interface.ext_q_management00.id
  network_security_group_id = azurerm_network_security_group.ext_management00.id
}

resource "azurerm_network_interface_security_group_association" "ext_q_mgmt01" {
  network_interface_id      = azurerm_network_interface.ext_q_management01.id
  network_security_group_id = azurerm_network_security_group.ext_management00.id
}

#----------------------------------------------------------------------------------------------------------------------
# VM-Series - Ethernet0/1 Interface (Untrust)
#----------------------------------------------------------------------------------------------------------------------

/*
# Public IP Address - NATGW - NO Need for PIP
resource "azurerm_public_ip" "ethernet00_0_1" {
  name                = "nic-ethernet00_0_1-pip"
  location            = var.resource_group_compute.location
  resource_group_name = var.resource_group_compute.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_public_ip" "ethernet01_0_1" {
  name                = "nic-ethernet01_0_1-pip"
  location            = var.resource_group_compute.location
  resource_group_name = var.resource_group_compute.name
  allocation_method   = "Static"
  sku                 = "Standard"
}
*/

# Network Interface
# Internal Firewalls
resource "azurerm_network_interface" "int_p_public00" {
  name                          = "rush-nic-intpublic-p-${var.location_short}-00"
  location                      = var.resource_group_compute.location
  resource_group_name           = var.resource_group_compute.name
  enable_ip_forwarding          = true
  enable_accelerated_networking = true

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.public00.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.hub_address_space[0], 132)
  }
}

resource "azurerm_network_interface" "int_p_public01" {
  name                          = "rush-nic-intpublic-p-${var.location_short}-01"
  location                      = var.resource_group_compute.location
  resource_group_name           = var.resource_group_compute.name
  enable_ip_forwarding          = true
  enable_accelerated_networking = true

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.public00.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.hub_address_space[0], 133)
  }
}

resource "azurerm_network_interface" "int_q_public00" {
  name                          = "rush-nic-intpublic-q-${var.location_short}-00"
  location                      = var.resource_group_compute.location
  resource_group_name           = var.resource_group_compute.name
  enable_ip_forwarding          = true
  enable_accelerated_networking = true

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.public00.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.hub_address_space[0], 134)
  }
}

resource "azurerm_network_interface" "int_q_public01" {
  name                          = "rush-nic-intpublic-q-${var.location_short}-01"
  location                      = var.resource_group_compute.location
  resource_group_name           = var.resource_group_compute.name
  enable_ip_forwarding          = true
  enable_accelerated_networking = true

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.public00.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.hub_address_space[0], 135)
  }
}


# External Firewalls
resource "azurerm_network_interface" "ext_p_public00" {
  name                          = "rush-nic-extpublic-p-${var.location_short}-00"
  location                      = var.resource_group_compute.location
  resource_group_name           = var.resource_group_compute.name
  enable_ip_forwarding          = true
  enable_accelerated_networking = true

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.public00.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.hub_address_space[0], 136)
  }
}

resource "azurerm_network_interface" "ext_p_public01" {
  name                          = "rush-nic-extpublic-p-${var.location_short}-01"
  location                      = var.resource_group_compute.location
  resource_group_name           = var.resource_group_compute.name
  enable_ip_forwarding          = true
  enable_accelerated_networking = true

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.public00.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.hub_address_space[0], 137)
  }
}

resource "azurerm_network_interface" "ext_q_public00" {
  name                          = "rush-nic-extpublic-q-${var.location_short}-00"
  location                      = var.resource_group_compute.location
  resource_group_name           = var.resource_group_compute.name
  enable_ip_forwarding          = true
  enable_accelerated_networking = true

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.public00.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.hub_address_space[0], 138)
  }
}

resource "azurerm_network_interface" "ext_q_public01" {
  name                          = "rush-nic-extpublic-q-${var.location_short}-01"
  location                      = var.resource_group_compute.location
  resource_group_name           = var.resource_group_compute.name
  enable_ip_forwarding          = true
  enable_accelerated_networking = true

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.public00.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.hub_address_space[0], 139)
  }
}


#Data NSG

resource "azurerm_network_security_group" "data" {
  name                = "rush-nsg-data-${var.location_short}-00"
  location            = var.resource_group_compute.location
  resource_group_name = var.resource_group_compute.name

  security_rule {
    name                       = "data-inbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "data-outbound"
    priority                   = 1000
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

#NSG Attachment
##Internal FW

resource "azurerm_network_interface_security_group_association" "int_p_public_00" {
  network_interface_id      = azurerm_network_interface.int_p_public00.id
  network_security_group_id = azurerm_network_security_group.data.id
}

resource "azurerm_network_interface_security_group_association" "int_p_public_01" {
  network_interface_id      = azurerm_network_interface.int_p_public01.id
  network_security_group_id = azurerm_network_security_group.data.id
}

resource "azurerm_network_interface_security_group_association" "int_q_public_00" {
  network_interface_id      = azurerm_network_interface.int_q_public00.id
  network_security_group_id = azurerm_network_security_group.data.id
}

resource "azurerm_network_interface_security_group_association" "int_q_public_01" {
  network_interface_id      = azurerm_network_interface.int_q_public01.id
  network_security_group_id = azurerm_network_security_group.data.id
}

##External Firewall

resource "azurerm_network_interface_security_group_association" "ext_p_public_00" {
  network_interface_id      = azurerm_network_interface.ext_p_public00.id
  network_security_group_id = azurerm_network_security_group.data.id
}

resource "azurerm_network_interface_security_group_association" "ext_p_public_01" {
  network_interface_id      = azurerm_network_interface.ext_p_public01.id
  network_security_group_id = azurerm_network_security_group.data.id
}

resource "azurerm_network_interface_security_group_association" "ext_q_public_00" {
  network_interface_id      = azurerm_network_interface.ext_q_public00.id
  network_security_group_id = azurerm_network_security_group.data.id
}

resource "azurerm_network_interface_security_group_association" "ext_q_public_01" {
  network_interface_id      = azurerm_network_interface.ext_q_public01.id
  network_security_group_id = azurerm_network_security_group.data.id
}

#----------------------------------------------------------------------------------------------------------------------
# VM-Series - Ethernet0/2 Interface (Trust)
#----------------------------------------------------------------------------------------------------------------------

# Network Interface
## Internal Firewalls
resource "azurerm_network_interface" "int_p_trust00" {
  name                          = "rush-nic-inttrust-p-${var.location_short}-00"
  location                      = var.resource_group_compute.location
  resource_group_name           = var.resource_group_compute.name
  enable_ip_forwarding          = true
  enable_accelerated_networking = true


  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.private00.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.hub_address_space[0], 36)
  }
}

resource "azurerm_network_interface" "int_p_trust01" {
  name                          = "rush-nic-inttrust-p-${var.location_short}-01"
  location                      = var.resource_group_compute.location
  resource_group_name           = var.resource_group_compute.name
  enable_ip_forwarding          = true
  enable_accelerated_networking = true


  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.private00.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.hub_address_space[0], 37)
  }
}

resource "azurerm_network_interface" "int_q_trust00" {
  name                          = "rush-nic-inttrust-q-${var.location_short}-00"
  location                      = var.resource_group_compute.location
  resource_group_name           = var.resource_group_compute.name
  enable_ip_forwarding          = true
  enable_accelerated_networking = true


  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.private00.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.hub_address_space[0], 38)
  }
}

resource "azurerm_network_interface" "int_q_trust01" {
  name                          = "rush-nic-inttrust-q-${var.location_short}-01"
  location                      = var.resource_group_compute.location
  resource_group_name           = var.resource_group_compute.name
  enable_ip_forwarding          = true
  enable_accelerated_networking = true


  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.private00.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.hub_address_space[0], 39)
  }
}

## External Firewalls
resource "azurerm_network_interface" "ext_p_trust00" {
  name                          = "rush-nic-exttrust-p-${var.location_short}-00"
  location                      = var.resource_group_compute.location
  resource_group_name           = var.resource_group_compute.name
  enable_ip_forwarding          = true
  enable_accelerated_networking = true


  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.private00.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.hub_address_space[0], 40)
  }
}

resource "azurerm_network_interface" "ext_p_trust01" {
  name                          = "rush-nic-exttrust-p-${var.location_short}-01"
  location                      = var.resource_group_compute.location
  resource_group_name           = var.resource_group_compute.name
  enable_ip_forwarding          = true
  enable_accelerated_networking = true


  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.private00.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.hub_address_space[0], 41)
  }
}

resource "azurerm_network_interface" "ext_q_trust00" {
  name                          = "rush-nic-exttrust-q-${var.location_short}-00"
  location                      = var.resource_group_compute.location
  resource_group_name           = var.resource_group_compute.name
  enable_ip_forwarding          = true
  enable_accelerated_networking = true


  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.private00.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.hub_address_space[0], 42)
  }
}

resource "azurerm_network_interface" "ext_q_trust01" {
  name                          = "rush-nic-exttrust-q-${var.location_short}-01"
  location                      = var.resource_group_compute.location
  resource_group_name           = var.resource_group_compute.name
  enable_ip_forwarding          = true
  enable_accelerated_networking = true


  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.private00.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.hub_address_space[0], 43)
  }
}

#NSG Attachment
##Internal FW

resource "azurerm_network_interface_security_group_association" "int_p_trust00" {
  network_interface_id      = azurerm_network_interface.int_p_trust00.id
  network_security_group_id = azurerm_network_security_group.data.id
}

resource "azurerm_network_interface_security_group_association" "int_p_trust_01" {
  network_interface_id      = azurerm_network_interface.int_p_trust01.id
  network_security_group_id = azurerm_network_security_group.data.id
}

resource "azurerm_network_interface_security_group_association" "int_q_trust_00" {
  network_interface_id      = azurerm_network_interface.int_q_trust00.id
  network_security_group_id = azurerm_network_security_group.data.id
}

resource "azurerm_network_interface_security_group_association" "int_q_trust_01" {
  network_interface_id      = azurerm_network_interface.int_q_trust01.id
  network_security_group_id = azurerm_network_security_group.data.id
}

##External Firewall

resource "azurerm_network_interface_security_group_association" "ext_p_trust_00" {
  network_interface_id      = azurerm_network_interface.ext_p_trust00.id
  network_security_group_id = azurerm_network_security_group.data.id
}

resource "azurerm_network_interface_security_group_association" "ext_p_trust_01" {
  network_interface_id      = azurerm_network_interface.ext_p_trust01.id
  network_security_group_id = azurerm_network_security_group.data.id
}

resource "azurerm_network_interface_security_group_association" "ext_q_trust_00" {
  network_interface_id      = azurerm_network_interface.ext_q_trust00.id
  network_security_group_id = azurerm_network_security_group.data.id
}

resource "azurerm_network_interface_security_group_association" "ext_q_trust_01" {
  network_interface_id      = azurerm_network_interface.ext_q_trust01.id
  network_security_group_id = azurerm_network_security_group.data.id
}
#----------------------------------------------------------------------------------------------------------------------
# VM-Series - Ethernet0/3 Interface (HA2)
#----------------------------------------------------------------------------------------------------------------------

# Network Interface
## Internal Firewalls
resource "azurerm_network_interface" "int_p_ha00" {
  name                          = "rush-nic-intha2-p-${var.location_short}-00"
  location                      = var.resource_group_compute.location
  resource_group_name           = var.resource_group_compute.name
  enable_ip_forwarding          = true
  enable_accelerated_networking = true

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.ha200.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.hub_address_space[0], 68)
  }
}

resource "azurerm_network_interface" "int_p_ha01" {
  name                          = "rush-nic-intha2-p-${var.location_short}-01"
  location                      = var.resource_group_compute.location
  resource_group_name           = var.resource_group_compute.name
  enable_ip_forwarding          = true
  enable_accelerated_networking = true

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.ha200.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.hub_address_space[0], 69)
  }
}
  
  resource "azurerm_network_interface" "int_q_ha00" {
  name                          = "rush-nic-intha2-q-${var.location_short}-00"
  location                      = var.resource_group_compute.location
  resource_group_name           = var.resource_group_compute.name
  enable_ip_forwarding          = true
  enable_accelerated_networking = true

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.ha200.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.hub_address_space[0], 70)
  }
}

resource "azurerm_network_interface" "int_q_ha01" {
  name                          = "rush-nic-intha2-q-${var.location_short}-01"
  location                      = var.resource_group_compute.location
  resource_group_name           = var.resource_group_compute.name
  enable_ip_forwarding          = true
  enable_accelerated_networking = true

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.ha200.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.hub_address_space[0], 71)
  }
}

##External Firewall

resource "azurerm_network_interface" "ext_p_ha00" {
  name                          = "rush-nic-extha2-p-${var.location_short}-00"
  location                      = var.resource_group_compute.location
  resource_group_name           = var.resource_group_compute.name
  enable_ip_forwarding          = true
  enable_accelerated_networking = true

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.ha200.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.hub_address_space[0], 72)
  }
}

resource "azurerm_network_interface" "ext_p_ha01" {
  name                          = "rush-nic-extha2-p-${var.location_short}-01"
  location                      = var.resource_group_compute.location
  resource_group_name           = var.resource_group_compute.name
  enable_ip_forwarding          = true
  enable_accelerated_networking = true

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.ha200.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.hub_address_space[0], 73)
  }
}
  resource "azurerm_network_interface" "ext_q_ha00" {
  name                          = "rush-nic-extha2-q-${var.location_short}-00"
  location                      = var.resource_group_compute.location
  resource_group_name           = var.resource_group_compute.name
  enable_ip_forwarding          = true
  enable_accelerated_networking = true

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.ha200.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.hub_address_space[0], 74)
  }
}

resource "azurerm_network_interface" "ext_q_ha01" {
  name                          = "rush-nic-extha2-q-${var.location_short}-01"
  location                      = var.resource_group_compute.location
  resource_group_name           = var.resource_group_compute.name
  enable_ip_forwarding          = true
  enable_accelerated_networking = true

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.ha200.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.hub_address_space[0], 75)
  }
}

#----------------------------------------------------------------------------------------------------------------------
# VM-Series - Virtual Machine
#----------------------------------------------------------------------------------------------------------------------

#Internal PRD - FW1

resource "azurerm_marketplace_agreement" "palo" {
  publisher = "paloaltonetworks"
  offer     = "vmseries-flex"
  plan      = "byol"
}

resource "azurerm_linux_virtual_machine" "int_p_vmseries00" {
  # Resource Group & Location:
  location            = var.resource_group_compute.location
  resource_group_name = var.resource_group_compute.name

  name = "rush-vm-intpa-p-${var.location_short}-00"

  # Availabilty Zone:
  zone = "1"

  # Instance
  size = "Standard_DS3_v2"

  # Username and Password Authentication:
  disable_password_authentication = false
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password

  # Network Interfaces:
  network_interface_ids = [
    azurerm_network_interface.int_p_management00.id,
    azurerm_network_interface.int_p_public00.id,
    azurerm_network_interface.int_p_trust00.id,
    azurerm_network_interface.int_p_ha00.id,
  ]

  plan {
    name      = "byol"
    publisher = "paloaltonetworks"
    product   = "vmseries-flex"
  }

  source_image_reference {
    publisher = "paloaltonetworks"
    offer     = "vmseries-flex"
    sku       = "byol"
    version   = "latest"
    #command = "az vm image terms accept --publisher paloaltonetworks --offer vmseries-flex --plan byol"
  }

  os_disk {
    name                 = "${var.coid}osdiskintpap${var.location_short}00"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  tags = {
    protera_type = "Network Device"
    protera_coid = var.coid
    protera_apid = "NTWK"
    protera_env  = var.environment
  }
}

#Internal PRD - FW2

resource "azurerm_linux_virtual_machine" "int_p_vmseries01" {
  # Resource Group & Location:
  location            = var.resource_group_compute.location
  resource_group_name = var.resource_group_compute.name

  name = "rush-vm-intpa-p-${var.location_short}-00"

  # Availabilty Zone:
  zone = "2"

  # Instance
  size = "Standard_DS3_v2"

  # Username and Password Authentication:
  disable_password_authentication = false
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password

  # Network Interfaces:
  network_interface_ids = [
    azurerm_network_interface.int_p_management01.id,
    azurerm_network_interface.int_p_public01.id,
    azurerm_network_interface.int_p_trust01.id,
    azurerm_network_interface.int_p_ha01.id,
  ]

  plan {
    name      = "byol"
    publisher = "paloaltonetworks"
    product   = "vmseries-flex"
  }

  source_image_reference {
    publisher = "paloaltonetworks"
    offer     = "vmseries-flex"
    sku       = "byol"
    version   = "latest"
    #command = "az vm image terms accept --publisher paloaltonetworks --offer vmseries-flex --plan byol"
  }

  os_disk {
    name                 = "${var.coid}osdiskintpap${var.location_short}01"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  tags = {
    protera_type = "Network Device"
    protera_coid = var.coid
    protera_apid = "NTWK"
    protera_env  = var.environment
  }
}


#Internal QAS - FW1

resource "azurerm_linux_virtual_machine" "int_q_vmseries00" {
  # Resource Group & Location:
  location            = var.resource_group_compute.location
  resource_group_name = var.resource_group_compute.name

  name = "rush-vm-intpa-q-${var.location_short}-00"

  # Availabilty Zone:
  zone = "1"

  # Instance
  size = "Standard_DS3_v2"

  # Username and Password Authentication:
  disable_password_authentication = false
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password

  # Network Interfaces:
  network_interface_ids = [
    azurerm_network_interface.int_q_management00.id,
    azurerm_network_interface.int_q_public00.id,
    azurerm_network_interface.int_q_trust00.id,
    azurerm_network_interface.int_q_ha00.id,
  ]

  plan {
    name      = "byol"
    publisher = "paloaltonetworks"
    product   = "vmseries-flex"
  }

  source_image_reference {
    publisher = "paloaltonetworks"
    offer     = "vmseries-flex"
    sku       = "byol"
    version   = "latest"
    #command = "az vm image terms accept --publisher paloaltonetworks --offer vmseries-flex --plan byol"
  }

  os_disk {
    name                 = "${var.coid}osdiskintpaq${var.location_short}00"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  tags = {
    protera_type = "Network Device"
    protera_coid = var.coid
    protera_apid = "NTWK"
    protera_env  = var.environment
  }
}

#Internal QAS - FW2

resource "azurerm_linux_virtual_machine" "int_q_vmseries01" {
  # Resource Group & Location:
  location            = var.resource_group_compute.location
  resource_group_name = var.resource_group_compute.name

  name = "rush-vm-intpa-q-${var.location_short}-01"

  # Availabilty Zone:
  zone = "2"

  # Instance
  size = "Standard_DS3_v2"

  # Username and Password Authentication:
  disable_password_authentication = false
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password

  # Network Interfaces:
  network_interface_ids = [
    azurerm_network_interface.int_q_management01.id,
    azurerm_network_interface.int_q_public01.id,
    azurerm_network_interface.int_q_trust01.id,
    azurerm_network_interface.int_q_ha01.id,
  ]

  plan {
    name      = "byol"
    publisher = "paloaltonetworks"
    product   = "vmseries-flex"
  }

  source_image_reference {
    publisher = "paloaltonetworks"
    offer     = "vmseries-flex"
    sku       = "byol"
    version   = "latest"
    #command = "az vm image terms accept --publisher paloaltonetworks --offer vmseries-flex --plan byol"
  }

  os_disk {
    name                 = "${var.coid}osdiskintpaq${var.location_short}01"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  tags = {
    protera_type = "Network Device"
    protera_coid = var.coid
    protera_apid = "NTWK"
    protera_env  = var.environment
  }
}


#External PRD - FW1


resource "azurerm_linux_virtual_machine" "ext_p_vmseries00" {
  # Resource Group & Location:
  location            = var.resource_group_compute.location
  resource_group_name = var.resource_group_compute.name

  name = "rush-vm-extpa-p-${var.location_short}-00"

  # Availabilty Zone:
  zone = "1"

  # Instance
  size = "Standard_DS3_v2"

  # Username and Password Authentication:
  disable_password_authentication = false
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password

  # Network Interfaces:
  network_interface_ids = [
    azurerm_network_interface.ext_p_management00.id,
    azurerm_network_interface.ext_p_public00.id,
    azurerm_network_interface.ext_p_trust00.id,
    azurerm_network_interface.ext_p_ha00.id,
  ]

  plan {
    name      = "byol"
    publisher = "paloaltonetworks"
    product   = "vmseries-flex"
  }

  source_image_reference {
    publisher = "paloaltonetworks"
    offer     = "vmseries-flex"
    sku       = "byol"
    version   = "latest"
    #command = "az vm image terms accept --publisher paloaltonetworks --offer vmseries-flex --plan byol"
  }

  os_disk {
    name                 = "${var.coid}osdiskextpap${var.location_short}00"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  tags = {
    protera_type = "Network Device"
    protera_coid = var.coid
    protera_apid = "NTWK"
    protera_env  = var.environment
  }
}

#External PRD - FW2

resource "azurerm_linux_virtual_machine" "ext_p_vmseries01" {
  # Resource Group & Location:
  location            = var.resource_group_compute.location
  resource_group_name = var.resource_group_compute.name

  name = "rush-vm-extpa-p-${var.location_short}-00"

  # Availabilty Zone:
  zone = "2"

  # Instance
  size = "Standard_DS3_v2"

  # Username and Password Authentication:
  disable_password_authentication = false
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password

  # Network Interfaces:
  network_interface_ids = [
    azurerm_network_interface.ext_p_management01.id,
    azurerm_network_interface.ext_p_public01.id,
    azurerm_network_interface.ext_p_trust01.id,
    azurerm_network_interface.ext_p_ha01.id,
  ]

  plan {
    name      = "byol"
    publisher = "paloaltonetworks"
    product   = "vmseries-flex"
  }

  source_image_reference {
    publisher = "paloaltonetworks"
    offer     = "vmseries-flex"
    sku       = "byol"
    version   = "latest"
    #command = "az vm image terms accept --publisher paloaltonetworks --offer vmseries-flex --plan byol"
  }

  os_disk {
    name                 = "${var.coid}osdiskextpap${var.location_short}01"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  tags = {
    protera_type = "Network Device"
    protera_coid = var.coid
    protera_apid = "NTWK"
    protera_env  = var.environment
  }
}


#External QAS - FW1

resource "azurerm_linux_virtual_machine" "ext_q_vmseries00" {
  # Resource Group & Location:
  location            = var.resource_group_compute.location
  resource_group_name = var.resource_group_compute.name

  name = "rush-vm-extpa-q-${var.location_short}-00"

  # Availabilty Zone:
  zone = "1"

  # Instance
  size = "Standard_DS3_v2"

  # Username and Password Authentication:
  disable_password_authentication = false
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password

  # Network Interfaces:
  network_interface_ids = [
    azurerm_network_interface.ext_q_management00.id,
    azurerm_network_interface.ext_q_public00.id,
    azurerm_network_interface.ext_q_trust00.id,
    azurerm_network_interface.ext_q_ha00.id,
  ]

  plan {
    name      = "byol"
    publisher = "paloaltonetworks"
    product   = "vmseries-flex"
  }

  source_image_reference {
    publisher = "paloaltonetworks"
    offer     = "vmseries-flex"
    sku       = "byol"
    version   = "latest"
    #command = "az vm image terms accept --publisher paloaltonetworks --offer vmseries-flex --plan byol"
  }

  os_disk {
    name                 = "${var.coid}osdiskextpaq${var.location_short}00"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  tags = {
    protera_type = "Network Device"
    protera_coid = var.coid
    protera_apid = "NTWK"
    protera_env  = var.environment
  }
}

#Internal QAS - FW2

resource "azurerm_linux_virtual_machine" "ext_q_vmseries01" {
  # Resource Group & Location:
  location            = var.resource_group_compute.location
  resource_group_name = var.resource_group_compute.name

  name = "rush-vm-extpa-q-${var.location_short}-01"

  # Availabilty Zone:
  zone = "2"

  # Instance
  size = "Standard_DS3_v2"

  # Username and Password Authentication:
  disable_password_authentication = false
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password

  # Network Interfaces:
  network_interface_ids = [
    azurerm_network_interface.ext_q_management01.id,
    azurerm_network_interface.ext_q_public01.id,
    azurerm_network_interface.ext_q_trust01.id,
    azurerm_network_interface.ext_q_ha01.id,
  ]

  plan {
    name      = "byol"
    publisher = "paloaltonetworks"
    product   = "vmseries-flex"
  }

  source_image_reference {
    publisher = "paloaltonetworks"
    offer     = "vmseries-flex"
    sku       = "byol"
    version   = "latest"
    #command = "az vm image terms accept --publisher paloaltonetworks --offer vmseries-flex --plan byol"
  }

  os_disk {
    name                 = "${var.coid}osdiskextpaq${var.location_short}01"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  tags = {
    protera_type = "Network Device"
    protera_coid = var.coid
    protera_apid = "NTWK"
    protera_env  = var.environment
  }
}