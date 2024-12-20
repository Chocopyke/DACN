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
  alias_name = module.alb.internet_alb_dns_name
  alias_zone_id = module.alb.internet_alb_zone_id
  evaluate_target_health = false
}

# module "ecr" {
#   source          = "./modules/ecr"
#   repository_name = "lamlt-sonvt"
# }

module "ecs" {
  source = "./modules/ecs"
  cluster_name = "dacn-cluster"
}