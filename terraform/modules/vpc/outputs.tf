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
output "private_subnet_1_id" {
  value = aws_subnet.private_subnet_1.id
}
output "private_subnet_2_id" {
  value = aws_subnet.private_subnet_2.id
}
output "igw" {
  value = aws_internet_gateway.igw
}
output "ngw" {
  value = aws_nat_gateway.ngw
}
output "availability_zone_1" {
  value = data.aws_availability_zones.available.names[0]
}
output "availability_zone_2" {
  value = data.aws_availability_zones.available.names[1]
}