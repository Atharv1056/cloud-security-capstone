# Cloud Security Capstone: Secure Three-Tier AWS Application

## 1. Project Overview

This project demonstrates the design of a secure three-tier application on AWS using Terraform (Infrastructure as Code).

The architecture separates public access, application processing, and database storage into different network tiers. Security groups, encryption, and logging services are included to demonstrate cloud security best practices.

**Project status:** Terraform configuration validated locally. No AWS infrastructure has been deployed.

## 2. Assignment Alignment

This project addresses the following requirements:

- VPC with public and private subnets
- Application Load Balancer (ALB) in public subnets
- EC2 application server in a private application subnet
- RDS database in private database subnets
- Internet Gateway, NAT Gateway, route tables, and security groups
- VPC Flow Logs and AWS CloudTrail
- Terraform configuration, architecture diagram, and evidence checklist

## 3. Three-Tier Architecture

### Tier 1: Public Access
The public tier contains the Application Load Balancer, which receives HTTP traffic and forwards requests to the application tier.

### Tier 2: Application
The application tier contains an EC2 instance in a private subnet. It has no public IP address and accepts HTTP traffic only from the ALB security group.

### Tier 3: Database
The database tier contains an Amazon RDS MySQL database in private database subnets. Public accessibility is disabled, and the database security group allows MySQL traffic on TCP port 3306 only from the application security group.

## 4. Security Controls

- **Network isolation:** Public, application, and database tiers use separate subnets.
- **Security groups:** Traffic is restricted according to the intended communication between tiers.
- **Private EC2:** The application instance has no public IP address.
- **IMDSv2:** Required for EC2 instance metadata access.
- **Encryption:** EC2 root storage and RDS storage are encrypted.
- **Database protection:** RDS is configured as not publicly accessible.
- **VPC Flow Logs:** Network traffic metadata is sent to CloudWatch Logs.
- **CloudTrail:** AWS API activity is recorded in an S3 bucket with public access blocked, versioning, and server-side encryption.
- **Secure configuration management:** The database password is supplied through a Terraform variable rather than hard-coded into the main configuration.

## 5. Repository Structure

- `terraform/versions.tf` — Terraform and AWS provider requirements
- `terraform/variables.tf` — configurable input variables
- `terraform/main.tf` — network, ALB, EC2, RDS, and monitoring resources
- `terraform/outputs.tf` — outputs intended to be displayed after deployment
- `terraform/terraform.tfvars.example` — example configuration
- `diagrams/architecture.png` — architecture diagram
- `diagrams/architecture.mmd` — Mermaid architecture source
- `evidence/` — evidence checklist and illustrative sample evidence

## 6. Local Validation Results

The following commands have been run locally:

| Check | Result |
|---|---|
| `terraform fmt -check` | Passed |
| `terraform validate` | Passed |
| `terraform plan -refresh=false` | Not completed; AWS credentials were unavailable |
| `terraform output` | No outputs available from the current state |

Terraform validation checks the configuration's syntax and internal consistency. It does not prove that AWS resources can be created successfully.

The plan command failed because Terraform could not find valid AWS credentials. No successful AWS deployment has been verified.

## 7. Evidence Disclaimer

Files under `evidence/simulated/` are illustrative sample evidence created for coursework. They are not screenshots from a real AWS account and must not be presented as proof of a completed deployment.

For a real deployment, capture genuine AWS Console screenshots and relevant command outputs after obtaining the required account access and instructor approval.

## 8. Prerequisites for Real Deployment

- An AWS account with permission to create the required networking, compute, database, logging, IAM, and storage resources
- Terraform 1.5 or newer
- AWS CLI or another approved AWS credential method
- An AWS region with at least two available Availability Zones
- Instructor approval and a review of estimated costs

## 9. Local Validation Instructions

Run the following commands from the `terraform/` directory:

```powershell
terraform init
terraform fmt -check
terraform validate
```

These commands initialize the provider, check formatting, and validate the configuration. They do not deploy infrastructure.

A Terraform plan requires valid AWS credentials for this project because its configuration uses AWS provider functionality and AWS data sources.

## 10. Cost and Deployment Warning

AWS resources such as NAT Gateways, Application Load Balancers, EC2 instances, RDS databases, CloudWatch Logs, and S3 storage may incur charges.

This project has been maintained as a local coursework project. Do not run `terraform apply` unless you have AWS access, instructor approval, and have reviewed the expected costs.

If deployment is later approved, use a unique strong database password supplied securely through `TF_VAR_db_password`. Do not commit real credentials or secret values to GitHub.

## 11. Design Limitations and Future Improvements

- The ALB listener currently uses HTTP for demonstration. A production deployment should use HTTPS with an ACM certificate and an appropriate TLS policy.
- One NAT Gateway is used to reduce demonstration costs, but it creates a single-AZ egress dependency.
- The application tier uses a single EC2 instance, and RDS Multi-AZ is disabled in this demonstration.
- Production deployment should assess high availability, patch management, secrets management, backup restoration, monitoring alerts, and least-privilege IAM policies.

## 12. Suggested Viva Answers

**Why use a three-tier architecture?**  
It separates public access, application processing, and database storage, reducing direct exposure and simplifying security controls.

**Why is the database private?**  
The database should not accept direct connections from the public internet. Only the application tier needs database access.

**What is a security group?**  
A stateful virtual firewall that controls inbound and outbound traffic for associated AWS resources.

**Why use Terraform?**  
Terraform makes infrastructure repeatable, reviewable, and version-controllable through code.

**What do VPC Flow Logs and CloudTrail record?**  
VPC Flow Logs capture network traffic metadata, while CloudTrail records AWS API activity. They provide different types of security visibility.

**Does `terraform validate` prove deployment success?**  
No. It checks the configuration's syntax and consistency, not whether resources can be deployed successfully in AWS.
