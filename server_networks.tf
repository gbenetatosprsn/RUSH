#----------------------------------------------------------------------------------------------------------------------
# VM-Series - MGMT
#----------------------------------------------------------------------------------------------------------------------

# Public IP Address:
resource "azurerm_public_ip" "management00" {
  name                = "nic-management00-pip"
  location            = var.resource_group_compute.location
  resource_group_name = var.resource_group_compute.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_public_ip" "management01" {
  name                = "nic-management01-pip"
  location            = var.resource_group_compute.location
  resource_group_name = var.resource_group_compute.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Network Interface:
resource "azurerm_network_interface" "management00" {
  name                 = "nic-management00"
  location             = var.resource_group_compute.location
  resource_group_name  = var.resource_group_compute.name
  enable_ip_forwarding = false

  ip_configuration {
    name                          = "ipconfig00"
    subnet_id                     = azurerm_subnet.management00.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.hub_address_space[0], 4)
    public_ip_address_id          = azurerm_public_ip.management00.id
  }
}

resource "azurerm_network_interface" "management01" {
  name                 = "nic-management01"
  location             = var.resource_group_compute.location
  resource_group_name  = var.resource_group_compute.name
  enable_ip_forwarding = false

  ip_configuration {
    name                          = "ipconfig00"
    subnet_id                     = azurerm_subnet.management00.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.hub_address_space[0], 5)
    public_ip_address_id          = azurerm_public_ip.management01.id
  }
}

# Network Security Group:
resource "azurerm_network_security_group" "management00" {
  name                = "nsg-management00"
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

resource "azurerm_network_interface_security_group_association" "management00" {
  network_interface_id      = azurerm_network_interface.management00.id
  network_security_group_id = azurerm_network_security_group.management00.id
}

resource "azurerm_network_interface_security_group_association" "management01" {
  network_interface_id      = azurerm_network_interface.management01.id
  network_security_group_id = azurerm_network_security_group.management00.id
}

#----------------------------------------------------------------------------------------------------------------------
# VM-Series - Ethernet0/1 Interface (Untrust)
#----------------------------------------------------------------------------------------------------------------------

# Public IP Address
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

# Network Interface
resource "azurerm_network_interface" "ethernet00_0_1" {
  name                          = "nic-ethernet00_0_1"
  location                      = var.resource_group_compute.location
  resource_group_name           = var.resource_group_compute.name
  enable_ip_forwarding          = true
  enable_accelerated_networking = true

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.public00.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.hub_address_space[0], 52)
    public_ip_address_id          = azurerm_public_ip.ethernet00_0_1.id
  }
}

resource "azurerm_network_interface" "ethernet01_0_1" {
  name                          = "nic-ethernet01_0_1"
  location                      = var.resource_group_compute.location
  resource_group_name           = var.resource_group_compute.name
  enable_ip_forwarding          = true
  enable_accelerated_networking = true

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.public00.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.hub_address_space[0], 53)
    public_ip_address_id          = azurerm_public_ip.ethernet01_0_1.id
  }
}

resource "azurerm_network_security_group" "data" {
  name                = "data-nsg-allow-all"
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

resource "azurerm_network_interface_security_group_association" "ethernet00_0_1" {
  network_interface_id      = azurerm_network_interface.ethernet00_0_1.id
  network_security_group_id = azurerm_network_security_group.data.id
}

resource "azurerm_network_interface_security_group_association" "ethernet01_0_1" {
  network_interface_id      = azurerm_network_interface.ethernet01_0_1.id
  network_security_group_id = azurerm_network_security_group.data.id
}

#----------------------------------------------------------------------------------------------------------------------
# VM-Series - Ethernet0/2 Interface (Trust)
#----------------------------------------------------------------------------------------------------------------------

# Network Interface
resource "azurerm_network_interface" "ethernet00_0_2" {
  name                          = "nic-ethernet00_0_2"
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

resource "azurerm_network_interface" "ethernet01_0_2" {
  name                          = "nic-ethernet01_0_2"
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

#----------------------------------------------------------------------------------------------------------------------
# VM-Series - Ethernet0/3 Interface (Trust)
#----------------------------------------------------------------------------------------------------------------------

# Network Interface
resource "azurerm_network_interface" "ethernet00_0_3" {
  name                          = "nic-ethernet00_0_3"
  location                      = var.resource_group_compute.location
  resource_group_name           = var.resource_group_compute.name
  enable_ip_forwarding          = true
  enable_accelerated_networking = true

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.ha200.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.hub_address_space[0], 20)
  }
}

resource "azurerm_network_interface" "ethernet01_0_3" {
  name                          = "nic-ethernet03"
  location                      = var.resource_group_compute.location
  resource_group_name           = var.resource_group_compute.name
  enable_ip_forwarding          = true
  enable_accelerated_networking = true

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.ha200.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.hub_address_space[0], 21)
  }
}

#----------------------------------------------------------------------------------------------------------------------
# VM-Series - Virtual Machine
#----------------------------------------------------------------------------------------------------------------------

resource "azurerm_marketplace_agreement" "palo" {
  publisher = "paloaltonetworks"
  offer     = "vmseries-flex"
  plan      = "byol"
}

resource "azurerm_linux_virtual_machine" "vmseries00" {
  # Resource Group & Location:
  location            = var.resource_group_compute.location
  resource_group_name = var.resource_group_compute.name

  name = "${var.coid}az${var.location_short}pa00"

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
    azurerm_network_interface.management00.id,
    azurerm_network_interface.ethernet00_0_1.id,
    azurerm_network_interface.ethernet00_0_2.id,
    azurerm_network_interface.ethernet00_0_3.id,
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
    name                 = "${var.coid}az${var.location_short}pa00-osdisk"
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

resource "azurerm_linux_virtual_machine" "vmseries01" {
  # Resource Group & Location:
  location            = var.resource_group_compute.location
  resource_group_name = var.resource_group_compute.name

  name = "${var.coid}az${var.location_short}pa01"

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
    azurerm_network_interface.management01.id,
    azurerm_network_interface.ethernet01_0_1.id,
    azurerm_network_interface.ethernet01_0_2.id,
    azurerm_network_interface.ethernet01_0_3.id,
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
    name                 = "${var.coid}az${var.location_short}pa01-osdisk"
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
