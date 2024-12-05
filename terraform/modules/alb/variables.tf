variable "name" {}
variable "internal" {
  default = false
}
variable "lb_type" {
  default = "application"
}
variable "security_group_ids" {}
variable "subnet_ids" {}

variable "vpc_id" {}
variable "target_group_port" {
  default = 80
}
variable "target_group_protocol" {
  default = "HTTP"
}
variable "listener_port" {
  default = 80
}
variable "listener_protocol" {
  default = "HTTP"
}
variable "target_type" {
  default = "ip"
}
variable "health_check_port" {
  default = "traffic-port"
}
variable "matcher_code" {
  default = "200-499"
}