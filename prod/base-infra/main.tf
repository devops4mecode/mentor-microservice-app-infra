terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "s3" { key = "base-infra.prod.tfstate" }
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
  source     = "../../modules/base-infra"
  app_id     = "demo"
  env_id     = "prod"
  subnet_ids = data.aws_subnet_ids.this.ids
}

output "address" {
  value = module.main.export
}
