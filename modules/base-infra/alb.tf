resource "aws_lb" "this" {
  name               = "${local.uid}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.alb_security_group.this_security_group_id]
  subnets            = var.subnet_ids

  enable_deletion_protection = false
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn

  port     = 80
  protocol = "HTTP"

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "OK"
      status_code  = 200
    }
  }
}
