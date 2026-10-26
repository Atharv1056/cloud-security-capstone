# Real evidence checklist (capture only after actual deployment)

Replace simulated examples with screenshots from your own AWS account if you deploy.

1. VPC dashboard: project VPC and CIDR.
2. Subnets: two public, two private app, and two private database subnets.
3. Route tables: public default route to IGW; app default route to NAT; database route table without an internet default route.
4. Load Balancers: ALB scheme is internet-facing and ALB subnets are public.
5. EC2 instance details: private subnet, no public IPv4 address, and app security group.
6. RDS connectivity: Publicly accessible = No; DB subnet group uses private database subnets.
7. Security groups:
   - ALB inbound TCP 80 from 0.0.0.0/0 for this HTTP demo.
   - App inbound TCP 80 from ALB security group only.
   - DB inbound TCP 3306 from app security group only.
8. VPC Flow Logs: enabled for the VPC and delivery destination configured.
9. CloudTrail: trail logging enabled and S3 destination configured.
10. Browser test: ALB DNS shows the sample app page (only after deployment).
11. Terraform terminal: `terraform validate` and reviewed `terraform plan`.
12. Cleanup: capture or record successful `terraform destroy` and verify no resources remain.

Never include access keys, passwords, session tokens, or other secrets in screenshots.
