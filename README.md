# 📘 Terraform AWS 3-Tier Architecture (Well-Architected + DevSecOps)

This repository contains modular Terraform code to provision a **secure, well-architected 3-tier infrastructure on AWS**, designed with **DevSecOps principles** in mind.

---

## 🏗️ Architecture Overview

```
Client → ALB (Public Subnet)
            ↓
        EC2 (Private Subnet, via NAT)
            ↓
       RDS MySQL (Private Subnet)
```

### ✅ Key Features
- VPC with public & private subnets across 2 AZs
- EC2 instance in private subnet with no public IP
- ALB in public subnet for frontend access
- NAT Gateway for internet access from private subnet
- RDS MySQL with subnet group and security isolation
- All modules tagged and reusable

---

## 📦 Requirements

- Terraform v1.5+
- AWS CLI configured with credentials (`aws configure`)
- An existing EC2 Key Pair in your AWS region
- IAM permissions to create VPC, EC2, RDS, ALB, and networking components

---

## 📁 Project Structure

```
.
├── modules/
│   ├── alb/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── README.md
│   ├── ec2/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── README.md
│   ├── rds/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── README.md
│   └── vpc/
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       └── README.md
│
├── envs/
│   └── dev/
│       ├── main.tf
│       ├── provider.tf
│       ├── outputs.tf
│       ├── variables.tf
│       ├── terraform.tfvars
│       └── README.md
│
├── scripts/
│   └── validate-setup.sh
│
├── cloudwatch.tf
└── README.md
```

---

## 🔐 DevSecOps Considerations

- 🔒 No public IP for EC2 or RDS
- 🔐 Least privilege SGs (e.g., only EC2 → RDS allowed)
- 🔐 RDS encryption enabled
- 📜 Modular and auditable Terraform code
- 📊 Placeholder for CloudWatch monitoring and alerts
- 🧩 Secrets managed via `terraform.tfvars` (move to SSM or Secrets Manager for prod)

---

## 📂 Modules
| Module | Purpose |
|--------|---------|
| `vpc/` | Creates VPC, subnets, IGW, NAT, and routes |
| `ec2/` | Provisions EC2 in private subnet with secure defaults |
| `alb/` | Deploys internet-facing ALB across AZs |
| `rds/` | Creates RDS MySQL instance in private subnet group |

---

## 🚀 How to Use

```bash
cd envs/dev
terraform init
terraform plan
terraform apply
```

**Variables:**
- Declared in `variables.tf`
- Populated in `terraform.tfvars`

**IMPORTANT:** Replace `ami_id`, `key_name`, and other values as needed.

---

## 🧪 Validating Setup (From EC2)

Check ALB connectivity from EC2:
```bash
curl http://<ALB_DNS_NAME>
```

Check DB connectivity (install MySQL client):
```bash
sudo yum install -y mysql
mysql -h <RDS_ENDPOINT> -u admin -p
```

> You can use the following script:
> `scripts/validate-setup.sh`

---

## 📊 Monitoring (Placeholder)

```hcl
# cloudwatch.tf

resource "aws_cloudwatch_log_group" "ec2" {
  name              = "/aws/ec2/${var.project}"
  retention_in_days = 14
  tags = {
    Project = var.project
  }
}

resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "HighCPU-${var.project}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 70
  alarm_description   = "This alarm triggers when EC2 CPU > 70%"
  dimensions = {
    InstanceId = aws_instance.app.id
  }
  alarm_actions = []
}
```

> Extend `cloudwatch.tf` further to include alarms for RDS, ALB, etc.

---

## 🧠 Author
**Elouise** — Senior DevOps Engineer 🇵🇭 → 🇺🇸
> Architected this stack to reflect real-world AWS deployment experience while adhering to security and operational excellence best practices.

---

## 📁 See Also
- `envs/dev/README.md` — for environment-specific setup & validation
- `scripts/validate-setup.sh` — basic curl + DB connectivity tests
