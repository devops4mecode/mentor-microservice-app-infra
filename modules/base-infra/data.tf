data "aws_subnet" "this" {
  id = var.subnet_ids[0]
}

data "aws_vpc" "this" {
  id = data.aws_subnet.this.vpc_id
}
