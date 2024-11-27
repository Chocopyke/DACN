resource "aws_ecr_repository" "dacn_repo" {
  name = var.repo_name
}