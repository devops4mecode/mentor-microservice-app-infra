module "ecs_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 3.0"

  name        = "${local.uid}-ecs-sg"
  description = "Security group for all ECS Task"
  vpc_id      = data.aws_vpc.this.id

  ingress_with_self = [{ rule = "all-all" }]

  ingress_with_source_security_group_id = [
    {
      rule                     = "all-all"
      source_security_group_id = module.alb_security_group.this_security_group_id
      description              = "Allow all from ALB SG"
    }
  ]

  egress_rules = ["all-all"]
}
