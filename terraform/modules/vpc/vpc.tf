#Create VPC
resource "aws_vpc" "dacn_vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.name}-vpc"
  }
}


#Get availability zone data
data "aws_availability_zones" "available_zones" {}


#Create public subnets
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.dacn_vpc.id
  cidr_block              = var.public_subnet_1_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name}-public-subnet-1"
  }
}
resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.dacn_vpc.id
  cidr_block              = var.public_subnet_2_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name}-public-subnet-2"
  }
}


#Create internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.dacn_vpc.id

  tags = {
    Name = "${var.name}-igw"
  }
}


#Create public route table for public subnets
resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.dacn_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.name}-public-rtb"
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


#Create private subnets
resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = aws_vpc.dacn_vpc.id
  cidr_block              = var.private_subnet_1_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.name}-private-subnet-1"
  }
}
resource "aws_subnet" "private_subnet_2" {
  vpc_id                  = aws_vpc.dacn_vpc.id
  cidr_block              = var.private_subnet_2_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.name}-private-subnet-2"
  }
}


#Create public eip for NAT Gateway
resource "aws_eip" "nat_eip_1" {
  tags = {
    Name = "${var.name}-eip-1"
  }
}
resource "aws_eip" "nat_eip_2" {
  tags = {
    Name = "${var.name}-eip-2"
  }
}


#Create NAT Gateways for each private subnet
resource "aws_nat_gateway" "ngw_1" {
  allocation_id = aws_eip.nat_eip_1.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = "${var.name}-ngw-1"
  }
}
resource "aws_nat_gateway" "ngw_2" {
  allocation_id = aws_eip.nat_eip_2.id
  subnet_id     = aws_subnet.public_subnet_2.id

  tags = {
    Name = "${var.name}-ngw-2"
  }
}


#Create private route table for private subnets
resource "aws_route_table" "private_rtb" {
  vpc_id = aws_vpc.dacn_vpc.id

  route {
    cidr_block     = var.public_subnet_1_cidr
    nat_gateway_id = aws_nat_gateway.ngw_1.id
  }
  route {
    cidr_block     = var.public_subnet_2_cidr
    nat_gateway_id = aws_nat_gateway.ngw_2.id
  }

  tags = {
    Name = "${var.name}-private-rtb"
  }
}
resource "aws_route_table_association" "private_subnet_1_association" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_rtb.id
}
resource "aws_route_table_association" "private_subnet_2_association" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_rtb.id
}


#Create default security group
resource "aws_security_group" "dacn_default_sg" {
  name        = "dacn security group"
  description = "enable access on all port"
  vpc_id      = aws_vpc.dacn_vpc.id

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
    Name = "${var.name}-default-sg"
  }
}