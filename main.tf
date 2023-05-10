provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "rg1" {
   name = "ankushrg"
}

data "azurerm_public_ip" "pip" {
    name = "pip1"
    resource_group_name = data.azurerm_resource_group.rg1.name
}

data "azurerm_resource_group" "rg2" {
   name = "chhavirg"
}


data "azurerm_public_ip" "pip2" {
    name = "pip2"
    resource_group_name = data.azurerm_resource_group.rg2.name
}

data "azurerm_traffic_manager_profile" "trm" {
  name                = "myfirsttm"
  resource_group_name = data.azurerm_resource_group.rg1.name
}

resource "azurerm_traffic_manager_endpoint" "endpoint1" {
  name                = "endpoint1"
  resource_group_name = data.azurerm_resource_group.rg1.name
  profile_name        = data.azurerm_traffic_manager_profile.trm.name
  type                = "azureEndpoints"
  target_resource_id   = data.azurerm_public_ip.pip.name
  endpoint_location   = data.azurerm_resource_group.rg1.location
}


terraform {
  backend "azurerm" {
    resource_group_name  = "Storagerg"
    storage_account_name = "storageaccount5591"
    container_name       = "tfstate"
    key                  = "endpoint.terraform.tfstate"
    access_key = "9DcT8nW/iKr0v2t8bfFIfM24sfJRGva1oD4macMbw6UkSwUXYHJr0ErQzgv15oErzQebT6lpi4zl+ASt2Lfeeg=="
  }
}