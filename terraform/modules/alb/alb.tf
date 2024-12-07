resource "aws_lb" "dacn_alb" {
  name               = "${var.name}-lb"
  internal           = var.internal
  load_balancer_type = var.lb_type
  security_groups    = var.security_group_ids
  subnets            = var.subnet_ids
  drop_invalid_header_fields = true
  enable_deletion_protection = false
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.dacn_alb.arn
  port              = var.listener_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_alb.arn
  }
}

resource "aws_lb_target_group" "target_alb" {
  name     = "${var.name}-lb-target-group"
  port     = var.target_group_port
  protocol = var.target_group_protocol
  vpc_id   = var.vpc_id
  target_type = var.target_type
  health_check {
    path     = "/"
    port     = var.health_check_port
    protocol = var.target_group_protocol
    matcher = var.matcher_code
  }
}