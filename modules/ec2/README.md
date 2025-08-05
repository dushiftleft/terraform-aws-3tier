# EC2 Module (Private Subnet Only)

This Terraform module provisions a single EC2 instance in a **private subnet**, without a public IP, following AWS Well-Architected and DevSecOps best practices.

---

## ✅ What It Does

- Launches an EC2 instance in a specified private subnet
- Associates secure metadata options (IMDSv2 enabled)
- Disables public IP (intended to be accessed via SSM or Bastion)
- Attaches defined security groups

---

## 🔐 Security Considerations

- No public IP is assigned
- Metadata endpoint hardened (`http_tokens = required`)
- Access controlled strictly by security groups (e.g., allow only from ALB or NAT)

---

## 📥 Input Variables

| Name | Description | Type | Required |
|------|-------------|------|----------|
| `project` | Used for naming and tagging resources | `string` | ✅ |
| `ami_id` | AMI ID to use (e.g., Amazon Linux 2) | `string` | ✅ |
| `instance_type` | Instance size (e.g., `t3.micro`) | `string` | ✅ |
| `subnet_id` | Private subnet ID where EC2 is launched | `string` | ✅ |
| `security_group_ids` | List of SGs to attach | `list(string)` | ✅ |
| `key_name` | EC2 key pair for SSH (or SSM Session Manager) | `string` | ✅ |

---

## 📤 Outputs

| Name | Description |
|------|-------------|
| `instance_id` | EC2 instance ID |
| `private_ip` | Private IP address |

---

## 🧪 Example Use

```hcl
module "ec2" {
  source             = "../../modules/ec2"
  project            = "demo"
  ami_id             = "ami-0c02fb55956c7d316"
  instance_type      = "t3.micro"
  subnet_id          = module.vpc.private_subnets[0]
  security_group_ids = [aws_security_group.ec2.id]
  key_name           = "my-keypair"
}
