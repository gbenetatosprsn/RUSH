#----------------------------------------------------------------------------------------------------------------------
# Loadbalancer
#----------------------------------------------------------------------------------------------------------------------

#Ingress PRD LB

resource "azurerm_public_ip" "ext_p_lbingress_pip" {
  name                = "rush-pip-lbingress-p-${var.location_short}-00"
  location            = var.resource_group_networking.location
  resource_group_name = var.resource_group_networking.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb" "ext_p_lbingress" {
  location            = var.resource_group_networking.location
  resource_group_name = var.resource_group_networking.name
  name                = "rush-lbe-extingress-p-${var.location_short}-00"
  sku                 = "Standard"
  
  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.ext_p_lbingress_pip.id
  }
}

resource "azurerm_lb_backend_address_pool" "ext_p_lbingress_backend_address_pool" {
  name            = "vmseries_p_public"
  loadbalancer_id = azurerm_lb.ext_p_lbingress.id
}

resource "azurerm_lb_probe" "ext_p_lbingress_probe" {
  name                = "Tcp-443"
  loadbalancer_id     = azurerm_lb.ext_p_lbingress.id
  port                = 443
  protocol            = "Tcp"
  #request_path        = "/php/login.php"
  interval_in_seconds = 5
  #number_of_probes    = 2
}

resource "azurerm_lb_rule" "ext_p_Tcp" {
  count                          = length(var.inbound_Tcp_ports)
  name                           = "Tcp-${element(var.inbound_Tcp_ports, count.index)}"
  loadbalancer_id                = azurerm_lb.ext_p_lbingress.id
  protocol                       = "Tcp"
  frontend_port                  = element(var.inbound_Tcp_ports, count.index)
  backend_port                   = element(var.inbound_Tcp_ports, count.index)
  frontend_ip_configuration_name = "PublicIPAddress"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.ext_p_lbingress_backend_address_pool.id]
  probe_id                       = azurerm_lb_probe.ext_p_lbingress_probe.id
  enable_floating_ip             = false
  disable_outbound_snat          = true
  enable_Tcp_reset               = false
  load_distribution              = "SourceIPProtocol"
}

resource "azurerm_lb_rule" "ext_p_udp" {
  count                          = length(var.inbound_udp_ports)
  name                           = "udp-${element(var.inbound_udp_ports, count.index)}"
  loadbalancer_id                = azurerm_lb.ext_p_lbingress.id
  protocol                       = "Udp"
  frontend_port                  = element(var.inbound_udp_ports, count.index)
  backend_port                   = element(var.inbound_udp_ports, count.index)
  frontend_ip_configuration_name = "PublicIPAddress"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.ext_p_lbingress_backend_address_pool.id]
  probe_id                       = azurerm_lb_probe.ext_p_lbingress_probe.id
  enable_floating_ip             = false
  disable_outbound_snat          = true
  enable_Tcp_reset               = false
  load_distribution              = "SourceIPProtocol"
}

resource "azurerm_network_interface_backend_address_pool_association" "ext_p_backend00" {
  network_interface_id    = azurerm_network_interface.ext_p_public00.id
  ip_configuration_name   = "ipconfig1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.ext_p_lbingress_backend_address_pool.id
}

resource "azurerm_network_interface_backend_address_pool_association" "ext_p_backend01" {
  network_interface_id    = azurerm_network_interface.ext_p_public01.id
  ip_configuration_name   = "ipconfig1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.ext_p_lbingress_backend_address_pool.id
}



#Ingress QAS LB

resource "azurerm_public_ip" "ext_q_lbingress_pip" {
  name                = "rush-pip-lbingress-q-${var.location_short}-00"
  location            = var.resource_group_networking.location
  resource_group_name = var.resource_group_networking.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb" "ext_q_lbingress" {
  location            = var.resource_group_networking.location
  resource_group_name = var.resource_group_networking.name
  name                = "rush-lbe-extingress-q-${var.location_short}-00"
  sku                 = "Standard"
  
  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.ext_q_lbingress_pip.id
  }
}

resource "azurerm_lb_backend_address_pool" "ext_q_lbingress_backend_address_pool" {
  name            = "vmseries_q_public"
  loadbalancer_id = azurerm_lb.ext_q_lbingress.id
}


resource "azurerm_lb_probe" "ext_q_lbingress_probe" {
  name                = "Tcp-443"
  loadbalancer_id     = azurerm_lb.ext_q_lbingress.id
  port                = 443
  protocol            = "Tcp"
  #request_path        = "/php/login.php"
  interval_in_seconds = 5
  #number_of_probes    = 2
}

resource "azurerm_lb_rule" "ext_q_Tcp" {
  count                          = length(var.inbound_Tcp_ports)
  name                           = "Tcp-${element(var.inbound_Tcp_ports, count.index)}"
  loadbalancer_id                = azurerm_lb.ext_q_lbingress.id
  protocol                       = "Tcp"
  frontend_port                  = element(var.inbound_Tcp_ports, count.index)
  backend_port                   = element(var.inbound_Tcp_ports, count.index)
  frontend_ip_configuration_name = "PublicIPAddress"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.ext_q_lbingress_backend_address_pool.id]
  probe_id                       = azurerm_lb_probe.ext_q_lbingress_probe.id
  enable_floating_ip             = false
  disable_outbound_snat          = true
  enable_Tcp_reset               = false
  load_distribution              = "SourceIPProtocol"
}

resource "azurerm_lb_rule" "ext_q_udp" {
  count                          = length(var.inbound_udp_ports)
  name                           = "udp-${element(var.inbound_udp_ports, count.index)}"
  loadbalancer_id                = azurerm_lb.ext_q_lbingress.id
  protocol                       = "Udp"
  frontend_port                  = element(var.inbound_udp_ports, count.index)
  backend_port                   = element(var.inbound_udp_ports, count.index)
  frontend_ip_configuration_name = "PublicIPAddress"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.ext_q_lbingress_backend_address_pool.id]
  probe_id                       = azurerm_lb_probe.ext_q_lbingress_probe.id
  enable_floating_ip             = false
  disable_outbound_snat          = true
  enable_Tcp_reset               = false
  load_distribution              = "SourceIPProtocol"
}

resource "azurerm_network_interface_backend_address_pool_association" "ext_q_ingress_backend00" {
  network_interface_id    = azurerm_network_interface.ext_q_public00.id
  ip_configuration_name   = "ipconfig1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.ext_q_lbingress_backend_address_pool.id
}

resource "azurerm_network_interface_backend_address_pool_association" "ext_q_ingress_backend01" {
  network_interface_id    = azurerm_network_interface.ext_q_public01.id
  ip_configuration_name   = "ipconfig1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.ext_q_lbingress_backend_address_pool.id
}


#External Egress PRD LB


resource "azurerm_lb" "ext_p_lbegress" {
  location            = var.resource_group_networking.location
  resource_group_name = var.resource_group_networking.name
  name                = "rush-lbi-extegress-p-${var.location_short}-00"
  sku                 = "Standard"

  frontend_ip_configuration {
    name      = "LoadBalancerIP"
    subnet_id = azurerm_subnet.loadbalancer00.id
  }
}

resource "azurerm_lb_probe" "ext_p_lbegress_probe" {
  name                = "Tcp-443"
  loadbalancer_id     = azurerm_lb.ext_p_lbegress.id
  port                = 443
  protocol            = "Tcp"
  #request_path        = "/php/login.php"
  interval_in_seconds = 5
  #number_of_probes    = 2
}

resource "azurerm_lb_backend_address_pool" "ext_p_lbegress_backend_address_pool" {
  name            = "vmseries_p_trust"
  loadbalancer_id = azurerm_lb.ext_p_lbegress.id
}

resource "azurerm_lb_rule" "ext_p_allports" {
  name                           = "all-ports"
  loadbalancer_id                = azurerm_lb.ext_p_lbegress.id
  protocol                       = "All"
  frontend_port                  = 0
  backend_port                   = 0
  frontend_ip_configuration_name = "LoadBalancerIP"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.ext_p_lbegress_backend_address_pool.id]
  probe_id                       = azurerm_lb_probe.ext_p_lbegress_probe.id
  enable_floating_ip             = true
}

resource "azurerm_network_interface_backend_address_pool_association" "ext_p_egress_backend00" {
  network_interface_id    = azurerm_network_interface.ext_p_trust00.id
  ip_configuration_name   = "ipconfig1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.ext_p_lbegress_backend_address_pool.id
}

resource "azurerm_network_interface_backend_address_pool_association" "ext_p_egress_backend01" {
  network_interface_id    = azurerm_network_interface.ext_p_trust01.id
  ip_configuration_name   = "ipconfig1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.ext_p_lbegress_backend_address_pool.id
}


#External Egress QAS LB


resource "azurerm_lb" "ext_q_lbegress" {
  location            = var.resource_group_networking.location
  resource_group_name = var.resource_group_networking.name
  name                = "rush-lbi-extegress-q-${var.location_short}-00"
  sku                 = "Standard"

  frontend_ip_configuration {
    name      = "LoadBalancerIP"
    subnet_id = azurerm_subnet.loadbalancer00.id
  }
}

resource "azurerm_lb_probe" "ext_q_lbegress_probe" {
  name                = "Tcp-443"
  loadbalancer_id     = azurerm_lb.ext_q_lbegress.id
  port                = 443
  protocol            = "Tcp"
  #request_path        = "/php/login.php"
  interval_in_seconds = 5
  #number_of_probes    = 2
}

resource "azurerm_lb_backend_address_pool" "ext_q_lbegress_backend_address_pool" {
  name            = "vmseries_q_trust"
  loadbalancer_id = azurerm_lb.ext_q_lbegress.id
}

resource "azurerm_lb_rule" "ext_q_allports" {
  name                           = "all-ports"
  loadbalancer_id                = azurerm_lb.ext_q_lbegress.id
  protocol                       = "All"
  frontend_port                  = 0
  backend_port                   = 0
  frontend_ip_configuration_name = "LoadBalancerIP"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.ext_q_lbegress_backend_address_pool.id]
  probe_id                       = azurerm_lb_probe.ext_q_lbegress_probe.id
  enable_floating_ip             = true
}

resource "azurerm_network_interface_backend_address_pool_association" "ext_q_egress_backend00" {
  network_interface_id    = azurerm_network_interface.ext_q_trust00.id
  ip_configuration_name   = "ipconfig1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.ext_q_lbegress_backend_address_pool.id
}

resource "azurerm_network_interface_backend_address_pool_association" "ext_q_egress_backend01" {
  network_interface_id    = azurerm_network_interface.ext_q_trust01.id
  ip_configuration_name   = "ipconfig1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.ext_q_lbegress_backend_address_pool.id
}


# Internal FW

##External Egress PRD LB


resource "azurerm_lb" "int_p_lbegress" {
  location            = var.resource_group_networking.location
  resource_group_name = var.resource_group_networking.name
  name                = "rush-lbi-integress-p-${var.location_short}-00"
  sku                 = "Standard"

  frontend_ip_configuration {
    name      = "LoadBalancerIP"
    subnet_id = azurerm_subnet.loadbalancer00.id
  }
}

resource "azurerm_lb_probe" "int_p_lbegress_probe" {
  name                = "Tcp-443"
  loadbalancer_id     = azurerm_lb.int_p_lbegress.id
  port                = 443
  protocol            = "Tcp"
  #request_path        = "/php/login.php"
  interval_in_seconds = 5
  #number_of_probes    = 2
}

resource "azurerm_lb_backend_address_pool" "int_p_lbegress_backend_address_pool" {
  name            = "vmseries_p_trust"
  loadbalancer_id = azurerm_lb.int_p_lbegress.id
}

resource "azurerm_lb_rule" "int_p_allports" {
  name                           = "all-ports"
  loadbalancer_id                = azurerm_lb.int_p_lbegress.id
  protocol                       = "All"
  frontend_port                  = 0
  backend_port                   = 0
  frontend_ip_configuration_name = "LoadBalancerIP"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.int_p_lbegress_backend_address_pool.id]
  probe_id                       = azurerm_lb_probe.int_p_lbegress_probe.id
  enable_floating_ip             = true
}

resource "azurerm_network_interface_backend_address_pool_association" "int_p_egress_backend00" {
  network_interface_id    = azurerm_network_interface.int_p_trust00.id
  ip_configuration_name   = "ipconfig1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.int_p_lbegress_backend_address_pool.id
}

resource "azurerm_network_interface_backend_address_pool_association" "int_p_egress_backend01" {
  network_interface_id    = azurerm_network_interface.int_p_trust01.id
  ip_configuration_name   = "ipconfig1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.int_p_lbegress_backend_address_pool.id
}


#External Egress QAS LB


resource "azurerm_lb" "int_q_lbegress" {
  location            = var.resource_group_networking.location
  resource_group_name = var.resource_group_networking.name
  name                = "rush-lbi-integress-q-${var.location_short}-00"
  sku                 = "Standard"

  frontend_ip_configuration {
    name      = "LoadBalancerIP"
    subnet_id = azurerm_subnet.loadbalancer00.id
  }
}

resource "azurerm_lb_probe" "int_q_lbegress_probe" {
  name                = "Tcp-443"
  loadbalancer_id     = azurerm_lb.int_q_lbegress.id
  port                = 443
  protocol            = "Tcp"
  #request_path        = "/php/login.php"
  interval_in_seconds = 5
  #number_of_probes    = 2
}

resource "azurerm_lb_backend_address_pool" "int_q_lbegress_backend_address_pool" {
  name            = "vmseries_q_trust"
  loadbalancer_id = azurerm_lb.int_q_lbegress.id
}

resource "azurerm_lb_rule" "int_q_allports" {
  name                           = "all-ports"
  loadbalancer_id                = azurerm_lb.int_q_lbegress.id
  protocol                       = "All"
  frontend_port                  = 0
  backend_port                   = 0
  frontend_ip_configuration_name = "LoadBalancerIP"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.int_q_lbegress_backend_address_pool.id]
  probe_id                       = azurerm_lb_probe.int_q_lbegress_probe.id
  enable_floating_ip             = true
}

resource "azurerm_network_interface_backend_address_pool_association" "int_q_egress_backend00" {
  network_interface_id    = azurerm_network_interface.int_q_trust00.id
  ip_configuration_name   = "ipconfig1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.int_q_lbegress_backend_address_pool.id
}

resource "azurerm_network_interface_backend_address_pool_association" "int_q_egress_backend01" {
  network_interface_id    = azurerm_network_interface.int_q_trust01.id
  ip_configuration_name   = "ipconfig1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.int_q_lbegress_backend_address_pool.id
}
