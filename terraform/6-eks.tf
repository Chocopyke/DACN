resource "aws_eks_cluster" "demo" {
  name     = "demo"
  role_arn = "arn:aws:iam::026922087570:role/LabRole"

  vpc_config {
    subnet_ids = [
      aws_subnet.private_us_east_1a.id,
      aws_subnet.private_us_east_1b.id,
      aws_subnet.public_us_east_1a.id,
      aws_subnet.public_us_east_1b.id
    ]
  }
}
