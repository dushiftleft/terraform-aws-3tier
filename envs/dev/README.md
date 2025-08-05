# 📘 Dev Environment (`envs/dev`) Setup

This directory provisions the development environment for the Terraform AWS 3-Tier Architecture stack.

---

## 🔧 Files

| File                | Purpose |
|---------------------|---------|
| `main.tf`           | Composes VPC, EC2, ALB, and RDS modules |
| `provider.tf`       | AWS provider and Terraform settings |
| `outputs.tf`        | Outputs key values like ALB DNS, RDS endpoint |
| `variables.tf`      | Declares input variables required for this env |
| `terraform.tfvars`  | Actual values for the variables (e.g., CIDRs, AMI, DB creds) |
| `README.md`         | (This file) Describes setup instructions |

---

## 📦 Prerequisites

- Terraform >= v1.5.0
- AWS CLI configured
- An existing EC2 Key Pair

---

## 🚀 Usage

```bash
cd envs/dev
terraform init
terraform plan
terraform apply
```

---

## 📌 Sample `terraform.tfvars`

```hcl
project              = "myapp"
environment          = "dev"
aws_region           = "us-east-1"
vpc_cidr_block       = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
key_name             = "my-key"
ami_id               = "ami-0c55b159cbfafe1f0"
db_username          = "admin"
db_password          = "StrongPassword123!"
```

---

## 🧪 Validate Setup (From EC2)

```bash
curl http://<ALB_DNS_NAME>
sudo yum install -y mysql
mysql -h <RDS_ENDPOINT> -u admin -p
```

> Or use the helper script: `../../scripts/validate-setup.sh`

---

## 🔐 Notes

- EC2 and RDS reside in private subnets with no public IPs
- ALB is internet-facing in public subnets
- DB password is stored in plain text for simplicity — use SSM or Secrets Manager in production

---

## 📁 Related Modules

- `../../modules/vpc`
- `../../modules/alb`
- `../../modules/ec2`
- `../../modules/rds`
