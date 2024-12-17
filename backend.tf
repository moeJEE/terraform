terraform {
  backend "azurerm" {
    resource_group_name  = "DocumentProcessingRG"
    storage_account_name = "docprocessingocrstorage"
    container_name       = "terraformstate"
    key                  = "terraform.tfstate"
  }
}
