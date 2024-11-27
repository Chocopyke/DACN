output "lb_arn" {
  value = aws_lb.dacn_alb.arn
}

output "lb_dns_name" {
  value = aws_lb.dacn_alb.dns_name
}

output "target_group_arn" {
  value = aws_lb_target_group.target_alb.arn
}