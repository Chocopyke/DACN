resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.cluster_name
}

resource "aws_ecs_task_definition" "ecs_task" {
  family                   = var.task_family
  network_mode             = var.network_mode
  requires_compatibilities = var.requires_compatibilities
  execution_role_arn       = var.execution_role_arn
  container_definitions    = jsonencode(var.container_definitions)
}

resource "aws_ecs_service" "ecs_service" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.ecs_task.arn
  desired_count   = var.desired_count
  launch_type     = var.launch_type

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

  depends_on = [aws_ecs_task_definition.ecs_task]
}
