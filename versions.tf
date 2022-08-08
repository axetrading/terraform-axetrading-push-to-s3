terraform {
  required_version = ">= 1.2.5"

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = ">= 2.2.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.25.0"
    }
  }
}