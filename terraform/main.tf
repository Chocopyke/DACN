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

module "ecs_sonarqube" {
  source             = "./modules/ecs"
  region             = "us-east-1"
  cluster_name       = "dacn-cluster"
  task_family        = "dacn-task-family"
  cpu                = "512"
  memory             = "1024"
  container_name     = "dacn-sonarqube"
  image              = "sonarqube"
  container_port     = 9000
  host_port          = 9000
  protocol           = "tcp"
  log_group_name     = "/ecs/my-logs"
  service_name       = "my-sonarqube-service"
  desired_count      = 2
  subnet_ids         = [module.vpc.public_subnet_id]
  security_group_ids = [module.vpc.ecs_sg_id]
  assign_public_ip   = true
}

