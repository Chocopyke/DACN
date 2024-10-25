output "ecs_cluster_id" {
  value = aws_ecs_cluster.my_cluster.id
}

output "ecs_service_arn" {
  value = aws_ecs_service.ecs_service.arn
}
