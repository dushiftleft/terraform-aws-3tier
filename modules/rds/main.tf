# Subnet Group for RDS (only private subnets)
resource "aws_db_subnet_group" "this" {
  name       = "${var.project}-db-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "${var.project}-db-subnet-group"
  }
}

# RDS MySQL Instance
resource "aws_db_instance" "this" {
  identifier             = "${var.project}-rds"
  allocated_storage      = var.allocated_storage
  engine                 = "mysql"
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [var.security_group_id]
  skip_final_snapshot    = true
  deletion_protection    = false
  publicly_accessible    = false
  multi_az               = false
  storage_encrypted      = true

  tags = {
    Name = "${var.project}-rds"
  }
}
