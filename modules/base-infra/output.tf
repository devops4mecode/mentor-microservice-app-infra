locals {
  export = {
    alb_name               = aws_lb.this.name
    alb_dns_name           = aws_lb.this.dns_name
    alb_listerner_http_arn = aws_lb_listener.http.arn
    ecs_cluster_id         = aws_ecs_cluster.this.id
    ecs_cluster_name       = aws_ecs_cluster.this.name
    ecs_task_exe_role_name = aws_iam_role.task_execute.name
    ecs_task_exe_role_arn  = aws_iam_role.task_execute.arn
    ecs_task_role_name     = aws_iam_role.task.name
    ecs_task_role_arn      = aws_iam_role.task.arn
    app_subnet_ids         = var.subnet_ids
    db_sg_ids              = [module.db_security_group.this_security_group_id]
    app_sg_ids             = [module.ecs_security_group.this_security_group_id]
  }
}
output "export" {
  description = "Export reference information"
  value       = local.export
}

resource "aws_ssm_parameter" "export" {
  name  = "/${var.env_id}/${var.app_id}/base-infra/tf-export"
  type  = "String"
  value = jsonencode(local.export)
}
