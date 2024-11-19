output "region" {
  value = var.region
}
output "proj_name" {
  value = var.proj_name
}
output "environment" {
  value = var.environment
}

output "vpc_id" {
  value = aws_vpc.my_vpc.id
}
output "public_subnet_1_id" {
  value = aws_subnet.public_subnet_1.id
}
output "public_subnet_2_id" {
  value = aws_subnet.public_subnet_2.id
}
output "private_subnet_id" {
  value = aws_subnet.private_subnet.id
}
output "igw" {
  value = aws_internet_gateway.igw
}
output "ngw" {
  value = aws_nat_gateway.ngw
}
output "availability_zone" {
  value = data.aws_availability_zones.available_zones.names[0]
}
output "ecs_sg_id" {
  value = aws_security_group.ecs_sg.id
}