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
output "ngw_1" {
  value = aws_nat_gateway.ngw_1
}
output "ngw_2" {
  value = aws_nat_gateway.ngw_2
}
output "availability_zone_1" {
  value = data.aws_availability_zones.available_zones.names[0]
}
output "availability_zone_2" {
  value = data.aws_availability_zones.available_zones.names[1]
}