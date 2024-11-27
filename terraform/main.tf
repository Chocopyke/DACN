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