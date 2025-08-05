variable "project" {
  description = "Project name for tagging"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for ALB placement"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs for ALB"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID where resources will be created"
  type        = string
}

variable "target_port" {
  description = "Port of the target EC2 instances"
  type        = number
}
