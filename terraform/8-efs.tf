# efs.tf

# EFS File System
resource "aws_efs_file_system" "efs" {
  creation_token = "my-efs"
  tags = {
    Name = "my-efs"
  }
}

# Security Group for EFS
resource "aws_security_group" "efs_sg" {
  name        = "efs-sg"
  description = "Security group for EFS access"
  vpc_id      = aws_vpc.main.id

  # Allow NFS (port 2049) from within the VPC
  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  # Outbound rule
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EFS Mount Targets - one for each subnet
resource "aws_efs_mount_target" "efs_mount_target_a" {
  file_system_id = aws_efs_file_system.efs.id
  subnet_id      = aws_subnet.private_us_east_1a.id
  security_groups = [
    aws_security_group.efs_sg.id
  ]
}

resource "aws_efs_mount_target" "efs_mount_target_b" {
  file_system_id = aws_efs_file_system.efs.id
  subnet_id      = aws_subnet.private_us_east_1b.id
  security_groups = [
    aws_security_group.efs_sg.id
  ]
}
