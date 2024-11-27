variable "cluster_name" {}
variable "task_family" {}
variable "network_mode" {
  default     = "awsvpc"
}
variable "requires_compatibilities" {
  type        = list(string)
  default     = ["FARGATE"]
}
variable "execution_role_arn" {
  default = "arn:aws:iam::329599660036:role/ecsTaskExecutionRole"
}
variable "container_definitions" {}
variable "service_name" {}
variable "desired_count" {
  default     = 1
}
variable "launch_type" {
  default     = "FARGATE"
}
variable "target_group_arn" {}
variable "container_name" {}
variable "container_port" {}