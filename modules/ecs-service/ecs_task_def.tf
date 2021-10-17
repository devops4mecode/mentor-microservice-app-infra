resource "aws_ecs_task_definition" "this" {
  count                    = local.create_service ? 1 : 0
  family                   = local.uid
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
  task_role_arn            = local.base_infra.ecs_task_exe_role_arn
  execution_role_arn       = local.base_infra.ecs_task_role_arn

  container_definitions = jsonencode(
    [{
      "name" : var.name
      "image" : local.image,
      "portMappings" : var.alb_paths == null ? [] : [
        { containerPort = var.containerPort }
      ],
      "environment" : var.environment == null ? null : [
        for key, value in var.environment : {
          value = value, name = key
        }
      ],
      "logConfiguration" : {
        "logDriver" : "awslogs",
        "options" : {
          "awslogs-create-group" : "true",
          "awslogs-group" : "/ecs/${var.env_id}/${var.name}",
          "awslogs-region" : data.aws_region.this.name,
          "awslogs-stream-prefix" : "ecs"
        }
      },
      "secrets" : var.secret == null ? null : [
        for key, value in var.secret : {
          valueFrom = value, name = key
        }
      ],
    }]
  )
}
