variable "project" {
  description = "Project name for tagging and resource grouping"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of public subnet CIDRs"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of private subnet CIDRs"
  type        = list(string)
}

variable "key_name" {
  description = "EC2 Key Pair name for SSH access"
  type        = string
}

variable "ami_id" {
  description = "AMI ID to use for EC2 instance"
  type        = string
}

variable "db_username" {
  description = "RDS database master username"
  type        = string
}

variable "db_password" {
  description = "RDS database master password"
  type        = string
  sensitive   = true
}
