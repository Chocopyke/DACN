module "vpc" {
  source = "./modules/vpc"
  name   = var.proj_name
}

module "alb" {
  source             = "./modules/alb"
  name               = var.proj_name
  vpc_id             = module.vpc.vpc_id
  security_group_ids = [module.vpc.dacn_sg_id]
  subnet_ids         = [module.vpc.public_subnet_1_id, module.vpc.public_subnet_2_id]
  target_group_port  = 5173
  target_type = "ip"
}

# module "ecr" {
#   source          = "./modules/ecr"
#   repository_name = "lamlt-sonvt"
# }

module "ecs" {
  source = "./modules/ecs"
  cluster_name = "dacn"
  task_family = "web-application"
  container_definitions = [
    {
      name      = "front-end"
      image     = "329599660036.dkr.ecr.us-east-1.amazonaws.com/lamlt-sonvt:front-end"
      cpu       = 512
      memory    = 1024
      essential = true
      portMappings = [
        {
          containerPort = 5173
          hostPort      = 5173
        }
      ]
    }
  ]

  service_name           = "test"
  launch_type            = "FARGATE"
  target_group_arn       = module.alb.target_group_arn
  container_name         = "front-end"
  container_port         = 5173
}