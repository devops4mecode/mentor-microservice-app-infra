module "alb_security_group" {
  source      = "terraform-aws-modules/security-group/aws"
  version     = "~> 3.0"
  name        = "${local.uid}-alb-sg"
  description = "Security group for ALB"
  vpc_id      = data.aws_vpc.this.id

  ingress_with_cidr_blocks = [
    { rule = "http-80-tcp", cidr_blocks = "0.0.0.0/0" },
    { rule = "https-443-tcp", cidr_blocks = "0.0.0.0/0" },
  ]

  egress_rules = ["all-all"]
}
