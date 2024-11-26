resource "aws_lb" "dacn_alb" {
  name               = "dacn-alb"
  internal           = false
  load_balancer_type = "applicaton"
  security_groups    = [for sg in var.security_group_ids : sg.id]
  subnets            = [for subnet in var.subnet_ids : subnet.id]
}