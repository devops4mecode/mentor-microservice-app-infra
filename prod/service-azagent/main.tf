terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "s3" { key = "service-azagent.prod.tfstate" }
}

provider "aws" {
  default_tags {
    tags = {
      Environment = "Prod"
      Owner       = "DevOps Team"
      Project     = "Demo"
      Author      = "Terraform"
    }
  }
  region = "ap-southeast-1"
}

module "main" {
  source = "../../modules/ecs-service"
  name   = "az-agent"
  env_id = "prod"
  app_id = "demo"
  image  = "mcr.microsoft.com/azure-pipelines/vsts-agent:ubuntu-16.04"
  environment = {
    VSTS_ACCOUNT = var.VSTS_ACCOUNT
    VSTS_TOKEN   = var.VSTS_TOKEN
    VSTS_POOL    = "prod-demo-az-agent"
    VSTS_WORK    = "/var/vsts/$VSTS_AGENT"
  }
}

variable "VSTS_ACCOUNT" {}
variable "VSTS_TOKEN" {}
