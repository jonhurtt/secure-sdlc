terraform {
  cloud {
    organization = "terraform-cloud-jhurtt"
    
    workspaces {
      name = "secure-sdlc-workspace"
    }
  }
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.7.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.5.1"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.4"
    }

    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~> 2.3.2"
    }
  }
  
  required_version = "~> 1.6"
}

provider "aws" {
  region = var.region
   
   default_tags {
    tags = {
      project = var.project_name
      environment = var.environment_name
    }
  }
}