module "vpc" {
  source      = "./modules/vpc"
  proj_name   = "dacn-testing"
  environment = "terraform"
  region      = var.region

  vpc_cidr            = "192.168.0.0/16"
  public_subnet_1_cidr  = "192.168.1.0/24"
  public_subnet_2_cidr = "192.168.3.0/24"
  private_subnet_cidr = "192.168.2.0/24"
}

# module "ecr" {
#   source          = "./modules/ecr"
#   repository_name = "lamlt-sonvt"
# }

# module "ecs_frontend" {
#   source             = "./modules/ecs"
#   region             = "us-east-1"
#   cluster_name       = "dacn-cluster"
#   task_family        = "dacn-frontend"
#   cpu                = "512"
#   memory             = "1024"
#   container_name     = "front-end"
#   image              = "329599660036.dkr.ecr.us-east-1.amazonaws.com/lamlt-sonvt:front-end"
#   container_port     = 5173
#   host_port          = 5173
#   protocol           = "tcp"
#   service_name       = "front-end"
#   desired_count      = 1
#   subnet_ids         = [module.vpc.private_subnet_id]
#   security_group_ids = [module.vpc.ecs_sg_id]
#   assign_public_ip   = true
# }

# # module "ecs_backend_cart" {
# #   source             = "./modules/ecs"
# #   region             = "us-east-1"
# #   cluster_name       = "dacn-cluster"
# #   task_family        = "dacn-backend-cart"
# #   cpu                = "512"
# #   memory             = "1024"
# #   container_name     = "cart"
# #   image              = "329599660036.dkr.ecr.us-east-1.amazonaws.com/lamlt-sonvt:cart"
# #   container_port     = 3003
# #   host_port          = 3003
# #   protocol           = "http"
# #   service_name       = "cart"
# #   desired_count      = 1
# #   subnet_ids         = [module.vpc.private_subnet_id]
# #   security_group_ids = [module.vpc.ecs_sg_id]
# #   assign_public_ip   = false
# # }

# # module "ecs_backend_product" {
# #   source             = "./modules/ecs"
# #   region             = "us-east-1"
# #   cluster_name       = "dacn-cluster"
# #   task_family        = "dacn-backend-product"
# #   cpu                = "512"
# #   memory             = "1024"
# #   container_name     = "product"
# #   image              = "329599660036.dkr.ecr.us-east-1.amazonaws.com/lamlt-sonvt:product"
# #   container_port     = 3002
# #   host_port          = 3002
# #   protocol           = "http"
# #   service_name       = "product"
# #   desired_count      = 1
# #   subnet_ids         = [module.vpc.private_subnet_id]
# #   security_group_ids = [module.vpc.ecs_sg_id]
# #   assign_public_ip   = false
# # }

# # module "ecs_backend_user" {
# #   source             = "./modules/ecs"
# #   region             = "us-east-1"
# #   cluster_name       = "dacn-cluster"
# #   task_family        = "dacn-backend-user"
# #   cpu                = "512"
# #   memory             = "1024"
# #   container_name     = "user"
# #   image              = "329599660036.dkr.ecr.us-east-1.amazonaws.com/lamlt-sonvt:user"
# #   container_port     = 3001
# #   host_port          = 3001
# #   protocol           = "http"
# #   service_name       = "user"
# #   desired_count      = 1
# #   subnet_ids         = [module.vpc.private_subnet_id]
# #   security_group_ids = [module.vpc.ecs_sg_id]
# #   assign_public_ip   = false
# # }

# # module "ecs_sonarqube" {
# #   source             = "./modules/ecs"
# #   region             = "us-east-1"
# #   cluster_name       = "dacn-cluster"
# #   task_family        = "dacn-sonarqube"
# #   cpu                = "1024"
# #   memory             = "3072"
# #   container_name     = "dacn-sonarqube"
# #   image              = "sonarqube"
# #   container_port     = 9000
# #   host_port          = 9000
# #   protocol           = "http"
# #   service_name       = "my-sonarqube-service"
# #   desired_count      = 1
# #   subnet_ids         = [module.vpc.public_subnet_id]
# #   security_group_ids = [module.vpc.ecs_sg_id]
# #   assign_public_ip   = true
# # }