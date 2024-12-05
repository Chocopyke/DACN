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
  source             = "./modules/ecs"
  cluster_name       = "dacn-cluster"
  family        = "dacn-task-family"
  cpu                = "1024"
  memory             = "2048"

  container_name     = "web-app"
  image              = "329599660036.dkr.ecr.us-east-1.amazonaws.com/lamlt-sonvt:web"
  container_port     = 5173
  host_port          = 5173
  service_name       = "web-service"
  desired_count      = 1
  subnets         = [module.vpc.private_subnet_1_id]
  security_group_id = [module.vpc.dacn_sg_id]
  assign_public_ip   = false

  target_group_arn = module.alb.target_group_arn
}