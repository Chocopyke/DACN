output "vpc_id" {
  value = aws_vpc.dacn_vpc.id
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
output "igw" {
  value = aws_internet_gateway.igw
}
output "ngw_1" {
  value = aws_nat_gateway.ngw_1
}
output "dacn_sg_id" {
  value = aws_security_group.dacn_sg.id
}