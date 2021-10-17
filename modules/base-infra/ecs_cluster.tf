resource "aws_ecs_cluster" "this" {
  name = "${local.uid}-ecs-cluster"
}
