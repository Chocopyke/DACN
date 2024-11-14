module "vpc" {
  source      = "./modules/vpc"
  proj_name   = "dacn-testing"
  environment = "terraform"
  region      = var.region

  vpc_cidr            = "192.168.0.0/16"
  public_subnet_cidr  = "192.168.1.0/24"
  private_subnet_cidr = "192.168.2.0/24"
}

module "ecr" {
  source          = "./modules/ecr"
  repository_name = "lamlt-sonvt"
}

module "ecs" {
  source                = "./modules/ecs"
  region                = "us-east-1"
  cluster_name          = "dacn-ecs-cluster"
  family                = "sonarqube-task"
  container_name        = "sonarqube"
  image                 = "sonarqube:latest"
  cpu                   = "512"
  memory                = "1024"
  container_cpu         = 512
  container_memory      = 1024
  container_port        = 9000
  desired_count         = 1
  subnets               = [module.vpc.public_subnet_id]
  security_group_id     = [module.vpc.ecs_sg_id]
  assign_public_ip      = true
  service_name          = "sonarqube-service"
  environment_variables = []
}
