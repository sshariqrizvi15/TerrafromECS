variable "ecs_cluster" {
      description = "ecs cluster"
}

variable "test_vpc" {
  description = "VPC name for Test environment"
}

variable "test_public_sn_01" {
  description = "Public Subnet 1"
}

variable "test_public_sn_02" {
  description = "Public Subnet 2"
}

variable "test_public_sg" {
  description = "Public Security Group"
}

variable "ecs-instance-profile" {
  description = "ECS Instance Profile"
}