terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "s3" { key = "service-product.prod.tfstate" }
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
  source        = "../../modules/ecs-service"
  name          = "product-app"
  env_id        = "prod"
  app_id        = "demo"
  containerPort = 3000
  alb_paths     = ["/products"]
  secret = {
    DATABASE_URL = "/prod/demo/postgres/product-db"
  }
}
