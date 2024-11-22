#Create VPC
resource "aws_vpc" "my_vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.proj_name}-${var.environment}-vpc"
  }
}

#Get all availability zones
data "aws_availability_zones" "available_zones" {}

#Create Public Subnet for VPC
resource "aws_subnet" "public_subnet_1" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.public_subnet_1_cidr
  # availability_zone       = data.aws_availability_zones.available_zones.names[0]
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.proj_name}-${var.environment}-public-subnet-1"
  }
}
resource "aws_subnet" "public_subnet_2" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.public_subnet_2_cidr
  # availability_zone       = data.aws_availability_zones.available_zones.names[0]
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.proj_name}-${var.environment}-public-subnet-2"
  }
}
#Create Private Subnet for VPC
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.private_subnet_cidr
  # availability_zone       = data.aws_availability_zones.available_zones.names[0]
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.proj_name}-${var.environment}-private-subnet"
  }
}

#Create Internet Gateway for VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "${var.proj_name}-${var.environment}-igw"
  }
}

#Create Public Route Table and routing rules, then connect it to Public Subnet
resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.proj_name}-${var.environment}-public-rtb"
  }
}

resource "aws_route_table_association" "public_subnet_1_association" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_rtb.id
}

resource "aws_route_table_association" "public_subnet_2_association" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_rtb.id
}

#Create NAT Gateway for VPC
resource "aws_eip" "nat_eip" {
  tags = {
    Name = "${var.proj_name}-${var.environment}-eip"
  }
}
resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = "${var.proj_name}-${var.environment}-ngw"
  }
}

#Create Private Route Table and routing rules, then connect it to Private Subnet
resource "aws_route_table" "private_rtb" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw.id
  }

  tags = {
    Name = "${var.proj_name}-${var.environment}-private-rtb"
  }
}
resource "aws_route_table_association" "private_subnet_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rtb.id
}

#Create Security Group for container
resource "aws_security_group" "ecs_sg" {
  name        = "ecs security group"
  description = "enable access on all port"
  vpc_id      = aws_vpc.my_vpc.id
  
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.proj_name}-${var.environment}-ecs-sg"
  }
}