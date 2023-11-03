#Source: https://www.architect.io/blog/2021-03-30/create-and-manage-an-aws-ecs-cluster-with-terraform/

terraform {
  /*required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=4.52.0"
    }
    
    random = {
      source  = "hashicorp/random"
      version = ">=3.4.3"
    }
  }
  */

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
  #required_version = ">= 1.1.0"
  required_version = "~> 1.3"
}

/*
provider "aws" {
  region = "us-east-1"
}
*/

provider "aws" {
  region = var.region
}