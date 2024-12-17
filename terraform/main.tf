module "vpc" {
  source = "./modules/vpc"
  name   = var.proj_name
}

module "alb" {
  source               = "./modules/alb"
  alb_name             = "dacn_alb"
  vpc_id               = module.vpc.vpc_id
  security_groups      = [module.vpc.dacn_sg_id]
  internet_alb_subnets = [module.vpc.public_subnet_1_id, module.vpc.public_subnet_2_id]
  internal_alb_subnets = [module.vpc.private_subnet_1_id, module.vpc.private_subnet_2_id]
}

module "route53_private_hosted_zone" {
  source = "./modules/route53"
  dns_name = "backend.local"
  vpc_id = module.vpc.vpc_id
  alias_name = module.alb.internal_alb_dns_name
  alias_zone_id = module.alb.internal_alb_zone_id
  evaluate_target_health = false
}

# module "ecr" {
#   source          = "./modules/ecr"
#   repository_name = "lamlt-sonvt"
# }

# module "ecs-frontend" {
#   source       = "./modules/ecs"
#   cluster_name = "dacn-cluster"
#   family       = "dacn-task-family"
#   cpu          = "512"
#   memory       = "1024"

#   container_name    = "front-end"
#   image             = "329599660036.dkr.ecr.us-east-1.amazonaws.com/lamlt-sonvt:web"
#   container_port    = 5173
#   host_port         = 5173
#   service_name      = "front-end-service"
#   desired_count     = 1
#   subnets           = [module.vpc.private_subnet_1_id]
#   security_group_id = [module.vpc.dacn_sg_id]
#   assign_public_ip  = false

#   target_group_arn = module.alb.target_group_arn
# }

# module "ecs-product" {
#   source       = "./modules/ecs"
#   cluster_name = "dacn-cluster"
#   family       = "dacn-task-family"
#   cpu          = "512"
#   memory       = "1024"

#   container_name    = "product-service"
#   image             = "329599660036.dkr.ecr.us-east-1.amazonaws.com/lamlt-sonvt:product"
#   container_port    = 3002
#   host_port         = 3002
#   service_name      = "product-service"
#   desired_count     = 1
#   subnets           = [module.vpc.private_subnet_1_id]
#   security_group_id = [module.vpc.dacn_sg_id]
#   assign_public_ip  = false

#   target_group_arn = module.alb.target_group_arn
# }