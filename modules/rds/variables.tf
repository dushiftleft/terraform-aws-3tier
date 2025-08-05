variable "project" {
  description = "Project name for tagging"
  type        = string
}

variable "subnet_ids" {
  description = "List of private subnet IDs for DB subnet group"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID to allow access to RDS"
  type        = string
}

variable "instance_class" {
  description = "RDS instance type"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "Storage allocated (in GB)"
  type        = number
  default     = 20
}

variable "engine_version" {
  description = "MySQL engine version"
  type        = string
  default     = "8.0"
}

variable "db_username" {
  description = "Master username for DB"
  type        = string
}

variable "db_password" {
  description = "Master password for DB"
  type        = string
  sensitive   = true
}
