resource "aws_ecs_service" "this" {
  count         = local.create_service ? 1 : 0
  name          = "${local.uid}-service"
  cluster       = local.base_infra.ecs_cluster_id
  launch_type   = "FARGATE"
  desired_count = var.desired_count

  dynamic "load_balancer" {
    for_each = var.alb_paths == null ? [] : [1]
    content {
      target_group_arn = join("", aws_lb_target_group.this.*.arn)
      container_name   = var.name
      container_port   = var.containerPort
    }
  }

  task_definition = join("", aws_ecs_task_definition.this.*.arn)

  network_configuration {
    subnets          = local.base_infra.app_subnet_ids
    security_groups  = local.base_infra.app_sg_ids
    assign_public_ip = var.assign_public_ip
  }
}

output "result" {
  value = local.image
}
