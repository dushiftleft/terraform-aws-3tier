# ALB Module (Public-Facing Application Load Balancer)

This module creates an **internet-facing Application Load Balancer (ALB)**, with a listener on port 80 and a connected target group.

---

## ✅ What It Does

- Provisions an ALB in public subnets
- Configures security group access
- Creates a default HTTP listener
- Configures a health-checked target group

---

## 🔐 Security Considerations

- Public ALB with listener on port 80 only (HTTPS can be added via ACM/443)
- Target group expects HTTP (can be secured via internal SG rules)
- Accepts externally managed security groups for flexibility

---

## 📥 Input Variables

| Name | Description | Type | Required |
|------|-------------|------|----------|
| `project` | Project name used in tags | `string` | ✅ |
| `subnet_ids` | List of public subnet IDs | `list(string)` | ✅ |
| `security_group_ids` | List of SGs to attach to ALB | `list(string)` | ✅ |
| `vpc_id` | VPC where ALB and TG are created | `string` | ✅ |
| `target_port` | Port used by targets (e.g., 80 for EC2) | `number` | ✅ |

---

## 📤 Outputs

| Name | Description |
|------|-------------|
| `alb_dns_name` | Public DNS of the ALB |
| `target_group_arn` | ARN of the target group created |

---

## 🧪 Example Use

```hcl
module "alb" {
  source             = "../../modules/alb"
  project            = "demo"
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.public_subnets
  security_group_ids = [aws_security_group.alb.id]
  target_port        = 80
}
