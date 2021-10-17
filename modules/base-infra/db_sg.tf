module "db_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 3.0"

  name        = "${local.uid}-db-sg"
  description = "Security group for database"
  vpc_id      = data.aws_vpc.this.id

  ingress_with_self = [{ rule = "all-all" }]

  ingress_with_source_security_group_id = [
    {
      rule                     = "postgresql-tcp"
      source_security_group_id = module.ecs_security_group.this_security_group_id
      description              = "Allow db access from ECS SG"
    }
  ]

  egress_rules = ["all-all"]
}
