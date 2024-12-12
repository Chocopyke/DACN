output "internet_alb_arn" {
  value = aws_lb.internet_alb.arn
}
output "internal_alb_arn" {
  value = aws_lb.internal_alb.arn
}
output "alb_dns_name" {
  value = aws_lb.internet_alb.name
}
output "alb_zone_id" {
  value = aws_lb.internet_alb.zone_id
}
output "front_end_target_group_arn" {
  value = aws_lb_target_group.front_end_target_group.arn
}
output "cart_service_target_group_arn" {
  value = aws_lb_target_group.cart_service_target_group.arn
}
output "product_service_target_group_arn" {
  value = aws_lb_target_group.product_service_target_group.arn
}
output "user_service_target_group_arn" {
  value = aws_lb_target_group.user_service_target_group.arn
}