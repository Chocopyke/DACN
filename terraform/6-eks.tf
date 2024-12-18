resource "aws_eks_cluster" "demo" {
  name     = "demo"
  role_arn = "arn:aws:iam::329599660036:role/EKS-test"

  vpc_config {
    subnet_ids = [
      aws_subnet.private_us_east_1a.id,
      aws_subnet.private_us_east_1b.id,
      aws_subnet.public_us_east_1a.id,
      aws_subnet.public_us_east_1b.id
    ]
  }
}
