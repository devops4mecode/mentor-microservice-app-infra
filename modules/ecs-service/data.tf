data "aws_ssm_parameter" "import" {
  name = "/${var.env_id}/${var.app_id}/base-infra/tf-export"
}

data "aws_region" "this" {}

locals {
  base_infra = jsondecode(data.aws_ssm_parameter.import.value)
}

data "aws_subnet" "this" {
  id = local.base_infra.app_subnet_ids[0]
}

data "aws_vpc" "this" {
  id = data.aws_subnet.this.vpc_id
}
