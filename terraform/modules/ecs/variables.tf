variable "cluster_name" {
}

variable "images" {
  type = list(object({
    name             = string
    image            = string
    cpu              = string
    memory           = string
    container_cpu    = number
    container_memory = number
    port_mappings    = list(object({
      containerPort = number
      hostPort      = number
      protocol      = string
    }))
    desired_count = number
  }))
}

variable "subnet_ids" {}
variable "security_group_ids" {}
variable "assign_public_ip" {}