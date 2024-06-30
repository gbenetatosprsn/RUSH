locals {
  coid           = "rush"
  environment    = "prod"
  location       = "centralus"
  location_short = "cus"
  function       = "hub"

  hub_address_space         = ["10.41.1.0/24"]
  virtual_wan_address_space = ["10.41.2.0/24"]
}
