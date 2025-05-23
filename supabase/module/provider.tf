terraform {
  required_providers {
    supabase = {
      source  = "supabase/supabase"
      version = "~> 1.0"
    }
  }
}

provider "supabase" {
  access_token = var.supabase_access_token
}

# Define a linked project variable as user input
variable "linked_project" {
  type = string
  description = "The project ID of the linked supabase project"
}

variable "supabase_access_token" {
  type        = string
  description = "Supabase access token (store securely!)"
  sensitive   = true
}

variable "supabase_database_password" {
  type        = string
  description = "Supabase database password"
  sensitive   = true
}

# Create a project resource
resource "supabase_project" "staging" {
  organization_id   = var.linked_project
  name              = "solarteam-stg"
  database_password = var.supabase_database_password
  region            = "eu-central-1"

  lifecycle {
    ignore_changes = [database_password]
  }
}