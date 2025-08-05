# VPC Module (Public & Private Subnets with NAT)

This module provisions a full VPC layout with both **public and private subnets**, **NAT Gateways**, and route tables — designed to support a secure, production-style 3-tier architecture.

---

## ✅ What It Provisions

- A VPC with DNS support enabled
- Public subnets (for ALB, NAT gateways)
- Private subnets (for EC2, RDS)
- Internet Gateway
- NAT Gateways (1 per AZ for high availability)
- Route tables for public/private subnet traffic

---

## 🌐 Network Design

- **Public subnets**: allow direct internet access
- **Private subnets**: isolated; access internet via NAT
- Designed across **2 Availability Zones** (HA-friendly)

---

## 📥 Input Variables

| Name | Description | Type | Required |
|------|-------------|------|----------|
| `project` | Project tag name for all resources | `string` | ✅ |
| `vpc_cidr` | Main CIDR block for VPC | `string` | ✅ |
| `public_subnet_cidrs` | List of CIDRs for public subnets | `list(string)` | ✅ |
| `private_subnet_cidrs` | List of CIDRs for private subnets | `list(string)` | ✅ |
| `azs` | List of AZs (e.g., `["us-east-1a", "us-east-1b"]`) | `list(string)` | ✅ |

---

## 📤 Outputs

| Name | Description |
|------|-------------|
| `vpc_id` | VPC ID |
| `public_subnets` | List of public subnet IDs |
| `private_subnets` | List of private subnet IDs |

---

## 🧪 Example Use

```hcl
module "vpc" {
  source               = "../../modules/vpc"
  project              = "demo"
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
  azs                  = ["us-east-1a", "us-east-1b"]
}
