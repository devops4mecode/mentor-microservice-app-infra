terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "s3" { key = "database.prod.tfstate" }
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
  source = "../../modules/database"
  env_id = "prod"
  app_id = "demo"
}
