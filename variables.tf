# General Configuration
variable "resource_group_name" {
  type        = string
  description = "The name of the Azure resource group."
}

variable "resource_group_location" {
  type        = string
  description = "The Azure location where resources will be created."
}

# Storage Account
variable "storage_account_name" {
  type        = string
  description = "The name of the Azure Storage Account."
}

# Cosmos DB
variable "cosmosdb_name" {
  type        = string
  description = "The name of the Cosmos DB account."
}

# App Service Plan
variable "function_plan_name" {
  type        = string
  description = "The name of the App Service Plan."
}

# Function App
variable "function_app_name" {
  type        = string
  description = "The name of the Azure Function App."
}

# Cognitive Services
variable "cognitive_services_name" {
  type        = string
  description = "The name of the Azure Cognitive Services Account."
}

variable "computer_vision_name" {
  type        = string
  description = "The name of the Azure Computer Vision Account."
}

# Static Web App
variable "static_web_app_name" {
  type        = string
  description = "The name of the Azure Static Web App."
}

variable "github_repo_url" {
  type        = string
  description = "The URL of the GitHub repository for the Static Web App."
}

variable "github_branch" {
  type        = string
  description = "The branch of the GitHub repository for the Static Web App."
}

variable "github_pat" {
  type        = string
  description = "GitHub Personal Access Token for the Static Web App."
  sensitive   = true
}
