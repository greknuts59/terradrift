/* provider "azurerm" {
  features {}
}

provider "azurerm" {
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
*/
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.0.0"
    }
  }
}

provider "azurerm" {
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  features {}
}

variable "env" {
  description = "Environment name"
  type    	= string
  default 	= "dev"
}


variable "name_prefix" {
  description = "Prefix for all resource names"
  type    	= string
  default 	= "infrasity"
}

resource "azurerm_resource_group" "rg" {
  name 	= "${var.name_prefix}-rg-${var.env}-${var.location}"
  location = var.location
}

resource "azurerm_storage_account" "storage" {
  name                 	= "${var.name_prefix}st${var.env}${replace(var.location, "-", "")}"
  resource_group_name  	= azurerm_resource_group.rg.name
  location             	= azurerm_resource_group.rg.location
  account_tier         	= "Standard"
  account_replication_type = "LRS"

  tags = {
	Environment = var.env
	Project 	= var.name_prefix
  }
}

resource "azurerm_storage_container" "container" {
  name             	= "container-${var.env}"
  storage_account_name = azurerm_storage_account.storage.name
  container_access_type = "private"
}

output "storage_account_name" {
  value = azurerm_storage_account.storage.name
}

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "storage_container_name" {
  value = azurerm_storage_container.container.name
}