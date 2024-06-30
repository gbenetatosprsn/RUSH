locals {
  coid           = "cnry"
  environment    = "prod"
  location       = "eastus"
  location_short = "e"
  function       = "hub"

  hub_address_space         = ["100.71.64.0/24"]
  virtual_wan_address_space = ["100.71.65.0/24"]
}
