resource "aws_lb_target_group" "this" {
  count       = var.alb_paths != null && local.create_service ? 1 : 0
  name_prefix = substr(local.uid, 0, 6)
  port        = var.containerPort
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = data.aws_vpc.this.id

  health_check {
    enabled  = true
    path     = "/"
    port     = var.containerPort
    protocol = "HTTP"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_listener_rule" "this" {
  count        = var.alb_paths != null && local.create_service ? 1 : 0
  listener_arn = local.base_infra.alb_listerner_http_arn

  action {
    type             = "forward"
    target_group_arn = join("", aws_lb_target_group.this.*.arn)
  }

  condition {
    path_pattern {
      values = var.alb_paths
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}
