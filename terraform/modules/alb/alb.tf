#Create internet-facing alb and internal alb
resource "aws_lb" "internet_alb" {
  name               = "${var.alb_name}-internet-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = var.subnets

  enable_deletion_protection = var.enable_deletion_protection

  tags = {
    Name = "${var.alb_name}-internet-alb"
  }
}
resource "aws_lb" "internal_alb" {
  name               = "${var.alb_name}-internal-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = var.subnets

  enable_deletion_protection = var.enable_deletion_protection

  tags = {
    Name = "${var.alb_name}-internal-alb"
  }
}



#Create target group for each service
resource "aws_lb_target_group" "front_end_target_group" {
  name        = "${var.alb_name}-front-end-target-group"
  port        = 5173
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    path     = "/"
    port     = var.health_check_port
    protocol = "HTTP"
    matcher = var.matcher_code
  }
}
resource "aws_lb_target_group" "cart_service_target_group" {
  name        = "${var.alb_name}-cart-service-target-group"
  port        = 3003
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    path     = "/"
    port     = var.health_check_port
    protocol = "HTTP"
    matcher = var.matcher_code
  }
}
resource "aws_lb_target_group" "product_service_target_group" {
  name        = "${var.alb_name}-product-service-target-group"
  port        = 3002
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    path     = "/"
    port     = var.health_check_port
    protocol = "HTTP"
    matcher = var.matcher_code
  }
}
resource "aws_lb_target_group" "user_service_target_group" {
  name        = "${var.alb_name}-user-service-target-group"
  port        = 3001
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    path     = "/"
    port     = var.health_check_port
    protocol = "HTTP"
    matcher = var.matcher_code
  }
}



#Create listener for each service
resource "aws_lb_listener" "front_end_listener" {
  load_balancer_arn = aws_lb.internet_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.front_end_target_group.arn
  }
}
resource "aws_lb_listener" "cart_service_listener" {
  load_balancer_arn = aws_lb.internal_alb.arn
  port              = 3003
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cart_service_target_group.arn
  }
}
resource "aws_lb_listener" "product_service_listener" {
  load_balancer_arn = aws_lb.internal_alb.arn
  port              = 3002
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.product_service_target_group.arn
  }
}
resource "aws_lb_listener" "cart_service_listener" {
  load_balancer_arn = aws_lb.internal_alb.arn
  port              = 3001
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cart_service_target_group.arn
  }
}