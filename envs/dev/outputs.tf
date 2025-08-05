output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "ec2_instance_id" {
  value = module.ec2.instance_id
}

output "rds_endpoint" {
  value = module.rds.db_endpoint
}
