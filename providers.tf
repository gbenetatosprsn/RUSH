terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "Protera"

    workspaces {
      name = "rush-Connectivity-e445f27b-cdde-47cd-bb0a-4c1cd8009d06"
    }
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.60.0"
    }
  }
}
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}
