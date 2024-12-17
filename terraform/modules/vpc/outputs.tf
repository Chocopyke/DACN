output "vpc_id" {
  value = aws_vpc.dacn_vpc.id
}
output "public_subnet_1_id" {
  value = aws_subnet.public_subnet_1.id
}
output "private_subnet_1_id" {
  value = aws_subnet.private_subnet_1.id
}
output "public_subnet_2_id" {
  value = aws_subnet.public_subnet_2.id
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
output "dacn_sg_id" {
  value = aws_security_group.dacn_default_sg.id
}