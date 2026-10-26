# Cloud Security Capstone: Secure Three-Tier AWS Application

## Assignment alignment
This project addresses the uploaded assignment requirements:
- VPC with public and private subnets
- Application Load Balancer in public subnets
- EC2 application server in a private application subnet
- RDS in private database subnets, not publicly accessible
- Internet Gateway, NAT Gateway, route tables, and security groups
- VPC Flow Logs and CloudTrail
- Terraform code, architecture diagram, and evidence checklist

## Beginner explanation
1. **VPC**: an isolated network in AWS.
2. **Public subnet**: has a route to the Internet Gateway. The ALB is placed here.
3. **Private application subnet**: EC2 has no public IP. The ALB security group is the only source allowed to connect to EC2 on HTTP port 80.
4. **Private database subnet**: RDS has `publicly_accessible = false`. Its security group allows MySQL port 3306 only from the application security group.
5. **Internet Gateway (IGW)**: gives public subnets an internet route.
6. **NAT Gateway**: lets private application instances make outbound connections without accepting unsolicited inbound connections. A NAT Gateway has hourly and data-processing charges.
7. **VPC Flow Logs**: records IP traffic metadata for troubleshooting/security analysis.
8. **CloudTrail**: records AWS API activity in an S3 bucket.
9. **Terraform**: Infrastructure as Code (IaC)—resources are described in configuration files rather than created manually.

## Important evidence note
Files under `evidence/simulated/` are **illustrative sample evidence created for this coursework**. They are not screenshots from a real AWS account and do not prove that deployment occurred. For a real deployment, replace them with screenshots from your own AWS console and command outputs.

## Architecture
See `diagrams/architecture.png` and `diagrams/architecture.mmd`.

## Files
- `terraform/versions.tf`: Terraform and AWS provider requirements
- `terraform/variables.tf`: configurable inputs
- `terraform/main.tf`: network, ALB, EC2, RDS, and monitoring resources
- `terraform/outputs.tf`: values printed after deployment
- `terraform/terraform.tfvars.example`: safe example configuration
- `evidence/`: sample evidence and real-evidence checklist

## Prerequisites for real deployment
- An AWS account with permissions to create VPC, EC2, ELB, RDS, IAM, CloudWatch Logs, CloudTrail, and S3 resources.
- Terraform 1.5 or newer.
- AWS CLI configured with credentials (`aws configure`) or another approved credential method.
- An AWS region with at least two available Availability Zones.

## Cost warning
A NAT Gateway, Application Load Balancer, RDS database, EC2 instance, CloudTrail storage, and CloudWatch Logs may incur charges. This is a simulated project by default. Do not run `terraform apply` unless you understand the cost and have permission to create resources.

## Validate the Terraform configuration
Open a terminal in the `terraform` directory and run:

```bash
terraform init
terraform fmt -check
terraform validate
terraform plan
```

`terraform plan` requires AWS credentials and access to query AWS data sources. It does not create resources.

## If deploying with instructor approval
1. Copy `terraform.tfvars.example` to `terraform.tfvars`.
2. Set the password through an environment variable rather than storing it in a file.

Windows PowerShell:
```powershell
$env:TF_VAR_db_password = "Use-A-Unique-Strong-Demo-Password!"
```

macOS/Linux:
```bash
export TF_VAR_db_password='Use-A-Unique-Strong-Demo-Password!'
```

3. Run `terraform init`, `terraform fmt`, `terraform validate`, and `terraform plan`.
4. Review the plan and expected charges carefully.
5. Only with approval, run `terraform apply`.
6. Capture real console screenshots and test the ALB DNS output.
7. When finished, run `terraform destroy` to remove resources. Check the AWS console afterward for anything left behind.

## Security design decisions
- RDS is in isolated database subnets with no default internet route.
- RDS public access is explicitly disabled.
- The database security group accepts TCP 3306 only from the application security group.
- The app security group accepts TCP 80 only from the ALB security group.
- EC2 has no public IP and requires IMDSv2.
- EC2 root storage and RDS storage are encrypted.
- CloudTrail logs are stored in an S3 bucket with public access blocked, versioning, and server-side encryption.
- The application listener uses HTTP for a simple coursework demonstration. For a production system, use HTTPS with an ACM certificate and a secure TLS policy.
- The sample uses one NAT Gateway to reduce costs compared with one per Availability Zone; this creates a single-AZ egress dependency and is not the most resilient production design.
- The app tier is a single EC2 instance, and RDS Multi-AZ is disabled to keep the demo smaller. Production systems should assess redundancy, backups, patching, secrets management, and high availability.

## Suggested viva answers
**Why use three tiers?** To separate public entry, application processing, and data storage, reducing direct exposure and making security rules easier to enforce.

**Why is the database private?** It should not accept direct connections from the public internet. Only the application tier needs database access.

**What is the purpose of a security group?** It is a stateful virtual firewall controlling inbound and outbound traffic for associated resources.

**Why Terraform?** It makes infrastructure repeatable, reviewable, version-controllable, and easier to rebuild.

**What do Flow Logs and CloudTrail record?** Flow Logs capture network traffic metadata; CloudTrail records AWS API and account activity. They provide different kinds of security visibility.
