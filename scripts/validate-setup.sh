#!/bin/bash
# Basic connectivity test for ALB and RDS from EC2 instance

ALB_URL="$1"
DB_HOST="$2"
DB_USER="$3"
DB_PASS="$4"

if [ -z "$ALB_URL" ] || [ -z "$DB_HOST" ]; then
  echo "Usage: $0 <alb_dns_name> <rds_endpoint> [db_user] [db_pass]"
  exit 1
fi

echo "--- Testing ALB connectivity ---"
curl -s "http://$ALB_URL" || echo "Failed to reach ALB"

echo "--- Testing MySQL connectivity ---"
yum install -y mysql -q >/dev/null 2>&1
mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" -e "SHOW DATABASES;" || echo "Failed to connect to RDS"