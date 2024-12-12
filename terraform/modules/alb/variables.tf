variable "alb_name" {
  type        = string
}
variable "vpc_id" {
  type        = string
}
variable "subnets" {
  type        = list(string)
}
variable "security_groups" {
  type        = list(string)
}
variable "enable_deletion_protection" {
  type        = bool
  default     = false
}
variable "health_check_port" {
  default = "traffic-port"
}
variable "matcher_code" {
  default = "200-499"
}