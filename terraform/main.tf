module "vpc" {
  source      = "./modules/vpc"
  proj_name   = "dacn-testing"
  environment = "terraform"
  region      = var.region

  vpc_cidr              = "192.168.0.0/16"
  public_subnet_1_cidr  = "192.168.1.0/24"
  public_subnet_2_cidr  = "192.168.2.0/24"
  private_subnet_1_cidr = "192.168.3.0/24"
  private_subnet_2_cidr = "192.168.4.0/24"
}

module "ecr" {
  source = "./modules/ecr"
  repository_name = "test-dacn"
}