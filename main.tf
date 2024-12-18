terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.0.0"
}

provider "azurerm" {
  features {}
}

# Resource Group
resource "azurerm_resource_group" "document_processing" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

# Storage Account
resource "azurerm_storage_account" "ocr_storage" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.document_processing.name
  location                 = azurerm_resource_group.document_processing.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Cosmos DB
resource "azurerm_cosmosdb_account" "cosmosdb_account" {
  name                = var.cosmosdb_name
  resource_group_name = azurerm_resource_group.document_processing.name
  location            = "West US"
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    location          = "West US"
    failover_priority = 0
  }
}

# Cognitive Services
resource "azurerm_cognitive_account" "cognitive_services" {
  name                = var.cognitive_services_name
  resource_group_name = azurerm_resource_group.document_processing.name
  location            = azurerm_resource_group.document_processing.location
  sku_name            = "S0"
  kind                = "CognitiveServices"
}

resource "azurerm_cognitive_account" "computer_vision" {
  name                = var.computer_vision_name
  resource_group_name = azurerm_resource_group.document_processing.name
  location            = azurerm_resource_group.document_processing.location
  sku_name            = "S1"
  kind                = "ComputerVision"
}

# App Service Plan
resource "azurerm_service_plan" "function_plan" {
  name                = var.function_plan_name
  resource_group_name = azurerm_resource_group.document_processing.name
  location            = azurerm_resource_group.document_processing.location
  os_type             = "Windows"
  sku_name            = "Y1"
}

# Function App
resource "azurerm_windows_function_app" "ocr_function" {
  name                       = var.function_app_name
  resource_group_name        = azurerm_resource_group.document_processing.name
  location                   = azurerm_resource_group.document_processing.location
  storage_account_name       = azurerm_storage_account.ocr_storage.name
  storage_account_access_key = azurerm_storage_account.ocr_storage.primary_access_key
  service_plan_id            = azurerm_service_plan.function_plan.id
  https_only                 = true

  site_config {
    ftps_state = "Disabled"
  }
}

# Static Web App
resource "azurerm_static_web_app" "frontend" {
  name                = var.static_web_app_name
  resource_group_name = azurerm_resource_group.document_processing.name
  location            = "East US 2"
  sku_tier            = "Free"
  sku_size            = "Free"

  # Optional: Tags
  tags = {
    Environment = "Production"
  }
}


# Application Insights
resource "azurerm_application_insights" "app_insights" {
  name                = var.function_app_name
  resource_group_name = azurerm_resource_group.document_processing.name
  location            = azurerm_resource_group.document_processing.location
  application_type    = "web"
}
