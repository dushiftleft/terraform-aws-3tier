# RDS Module (MySQL in Private Subnet)

This module provisions a **MySQL RDS instance** securely inside private subnets. It uses a subnet group, encryption, and dedicated security group.

---

## ✅ What It Provisions

- A DB subnet group using private subnets
- An RDS MySQL instance
- Security group-controlled access
- Storage encryption and multi-AZ-ready structure

---

## 🔐 Security Considerations

- DB is not publicly accessible
- Access is restricted to security groups (e.g., EC2 SG)
- Password stored via variable (move to Secrets Manager in prod)

---

## 📥 Input Variables

| Name | Description | Type | Required |
|------|-------------|------|----------|
| `project` | Project name for tagging | `string` | ✅ |
| `subnet_ids` | List of private subnet IDs for DB | `list(string)` | ✅ |
| `security_group_id` | Security group ID for inbound access | `string` | ✅ |
| `instance_class` | RDS instance type | `string` | ✅ |
| `allocated_storage` | Storage (in GB) | `number` | ✅ |
| `engine_version` | MySQL version (e.g., `8.0`) | `string` | ✅ |
| `db_username` | Master DB username | `string` | ✅ |
| `db_password` | Master DB password (sensitive) | `string` | ✅ |

---

## 📤 Outputs

| Name | Description |
|------|-------------|
| `rds_endpoint` | DNS endpoint for DB connection |
| `rds_instance_id` | Identifier of the RDS instance |

---

## 🧪 Example Use

```hcl
module "rds" {
  source            = "../../modules/rds"
  project           = "demo"
  subnet_ids        = module.vpc.private_subnets
  security_group_id = aws_security_group.rds.id
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  engine_version    = "8.0"
  db_username       = "admin"
  db_password       = "SuperSecurePassword123!"
}
