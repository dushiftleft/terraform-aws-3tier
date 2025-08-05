# VPC
module "vpc" {
  source               = "../../modules/vpc"
  project              = var.project
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  azs                  = var.azs
}

# Security Group for EC2 (private)
resource "aws_security_group" "ec2" {
  name        = "${var.project}-ec2-sg"
  description = "Allow HTTP outbound and access to RDS"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-ec2-sg"
  }
}

# Security Group for RDS (private access only from EC2 SG)
resource "aws_security_group" "rds" {
  name        = "${var.project}-rds-sg"
  description = "Allow MySQL access from EC2"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-rds-sg"
  }
}

# Security Group for ALB (public)
resource "aws_security_group" "alb" {
  name        = "${var.project}-alb-sg"
  description = "Allow HTTP traffic to ALB"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-alb-sg"
  }
}

# EC2 instance (no public IP, launched in private subnet)
module "ec2" {
  source             = "../../modules/ec2"
  project            = var.project
  ami_id             = var.ami_id
  instance_type      = var.instance_type
  subnet_id          = module.vpc.private_subnets[0]
  security_group_ids = [aws_security_group.ec2.id]
  key_name           = var.key_name
}

# ALB (public subnet)
module "alb" {
  source             = "../../modules/alb"
  project            = var.project
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.public_subnets
  security_group_ids = [aws_security_group.alb.id]
  target_port        = 80
}

# RDS MySQL (private subnet)
module "rds" {
  source           = "../../modules/rds"
  project          = var.project
  subnet_ids       = module.vpc.private_subnets
  security_group_id = aws_security_group.rds.id
  instance_class   = var.rds_instance_class
  allocated_storage = var.rds_allocated_storage
  engine_version   = var.rds_engine_version
  db_username      = var.rds_username
  db_password      = var.rds_password
}
