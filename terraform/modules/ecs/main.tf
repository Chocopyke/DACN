resource "aws_ecs_cluster" "this" {
  name = var.cluster_name
}


#Create ECS Task Definiton
resource "aws_ecs_task_definition" "front_end_task" {
  family = "front-end"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  task_role_arn = "arn:aws:iam::329599660036:role/ecsTaskRole"
  execution_role_arn = "arn:aws:iam::329599660036:role/ecsTaskExecutionRole"
  container_definitions = jsonencode([
    {
      name      = "front-end"
      image     = "329599660036.dkr.ecr.us-east-1.amazonaws.com/lamlt-sonvt:front-end"
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 5173
          hostPort      = 5173
        }
      ]
    }
  ])
}

resource "aws_ecs_task_definition" "product_service_task" {
  family = "product-service"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  task_role_arn = "arn:aws:iam::329599660036:role/ecsTaskRole"
  execution_role_arn = "arn:aws:iam::329599660036:role/ecsTaskExecutionRole"
  container_definitions = jsonencode([
    {
      name      = "product"
      image     = "329599660036.dkr.ecr.us-east-1.amazonaws.com/lamlt-sonvt:product"
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 3002
          hostPort      = 3002
        }
      ]
    }
  ])
}
resource "aws_ecs_task_definition" "cart_service_task" {
  family = "cart-service"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  task_role_arn = "arn:aws:iam::329599660036:role/ecsTaskRole"
  execution_role_arn = "arn:aws:iam::329599660036:role/ecsTaskExecutionRole"
  container_definitions = jsonencode([
    {
      name      = "cart"
      image     = "329599660036.dkr.ecr.us-east-1.amazonaws.com/lamlt-sonvt:cart"
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 3003  
          hostPort      = 3003
        }
      ]
    }
  ])
}
resource "aws_ecs_task_definition" "user_service_task" {
  family = "user-service"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  task_role_arn = "arn:aws:iam::329599660036:role/ecsTaskRole"
  execution_role_arn = "arn:aws:iam::329599660036:role/ecsTaskExecutionRole"
  container_definitions = jsonencode([
    {
      name      = "user"
      image     = "329599660036.dkr.ecr.us-east-1.amazonaws.com/lamlt-sonvt:user"
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 3001
          hostPort      = 3001
        }
      ]
    }
  ])
}