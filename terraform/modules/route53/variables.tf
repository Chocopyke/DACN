variable "dns_name" {}
variable "vpc_id" {}
variable "sub_dns_name" {
    default = ""
}
variable "record_type" {
  default = "A"
}
variable "alias_name" {}
variable "alias_zone_id" {}
variable "evaluate_target_health" {}