locals {
  coid           = "rush"
  environment    = "prod"
  location       = "eastus2"
  location_short = "eus2"
  function       = "hub"

  hub_address_space         = ["10.41.1.0/24"]
  virtual_wan_address_space = ["10.41.0.0/24"]
}
