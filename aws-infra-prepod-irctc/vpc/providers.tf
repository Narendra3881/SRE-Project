terraform {
  required_providers {
    aws = {
       source  = "hashicorp/aws"
      version = "~> 5.40.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region  = var.region
  profile = "terraform-automation-user"
}