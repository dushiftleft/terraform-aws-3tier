project = "well-architected-demo"

# VPC
vpc_cidr             = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
azs                  = ["us-east-1a", "us-east-1b"]

# EC2
ami_id        = "ami-0c02fb55956c7d316"  # Amazon Linux 2 (update as needed)
instance_type = "t3.micro"
key_name      = "your-keypair-name"

# RDS
rds_username           = "admin"
rds_password           = "SuperSecurePassword123!"
rds_instance_class     = "db.t3.micro"
rds_allocated_storage  = 20
rds_engine_version     = "8.0"
